
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gp/View/ForgetPassScreen.dart';
import 'package:gp/View/LoginScreen.dart';
import 'package:gp/View/MakeRequest.dart';
import 'package:gp/View/OffersScreen.dart';
import 'package:gp/View/ProviderView/HomeScreenProvider.dart';
import 'package:gp/View/SignUpScreen.dart';
import 'package:gp/View/SubCategoryTab.dart';
import 'package:gp/View/UpdateRequest.dart';
import 'package:gp/View/createProfile.dart';
import 'package:provider/provider.dart';
import 'package:gp/View/StartScreen.dart';
import 'package:gp/View/MyTheme.dart';
import 'package:gp/providers/SettingsProvider.dart';
import 'HomeScreen.dart';
import 'ProviderView/LoginScreenProvider.dart';
import 'ProviderView/SignUpScreenProvider.dart';
import 'ResetPasswordScreen.dart';
import 'SpecificCategoryScreen.dart';
import 'SplashScreen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:gp/firebase_options.dart';

import 'ValidateCodeScreen.dart';
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void getToken() async{
  String? token= await FirebaseMessaging.instance.getToken();
  print("token $token");
}
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await setupFlutterNotifications();
  showFlutterNotification(message);
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  print('Handling a background message ${message.messageId}');
}

/// Create a [AndroidNotificationChannel] for heads up notifications
late AndroidNotificationChannel channel;

bool isFlutterLocalNotificationsInitialized = false;

Future<void> setupFlutterNotifications() async {
  if (isFlutterLocalNotificationsInitialized) {
    return;
  }
  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
    'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  /// Create an Android Notification Channel.
  ///
  /// We use this channel in the `AndroidManifest.xml` file to override the
  /// default FCM channel to enable heads up notifications.
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  isFlutterLocalNotificationsInitialized = true;
}

void showFlutterNotification(RemoteMessage message) {
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
  if (notification != null && android != null && !kIsWeb) {
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          // TODO add a proper drawable resource to android, for now using
          //      one that already exists in example app.
          icon: 'launch_background',
        ),
      ),
    );
  }
}

/// Initialize the [FlutterLocalNotificationsPlugin] package.
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
void main() async {
  HttpOverrides.global = MyHttpOverrides();
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // getToken();
  // // Set the background messaging handler early on, as a named top-level function
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  //
  // if (!kIsWeb) {
  //   await setupFlutterNotifications();
  // }
  runApp(ChangeNotifierProvider(
      create: (buildContext) => SettingsProvider(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var settingsProvider = Provider.of<SettingsProvider>(context);
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_ , child) {
        return MaterialApp(

          theme: MyTheme.lightMode,
          themeMode: settingsProvider.currentTheme,
          routes: {
            HomeScreen.routeName: (context) =>HomeScreen(),
            HomeScreenProvider.routeName: (context) =>HomeScreenProvider(),
            SplashScreen.routeName: (context) => SplashScreen(),
            StartScreen.routeName: (context) => StartScreen(),
            LoginScreen.routeName: (context) =>LoginScreen(),
            LoginScreenProvider.routeName: (context) =>LoginScreenProvider(),
            SignUpScreen.routeName: (context) =>SignUpScreen(),
            SignUpScreenProvider.routeName: (context) =>SignUpScreenProvider(),
            CreateProfile.routeName: (context)=>CreateProfile(),
            SpecificCategoryScreen.routeName: (context)=>SpecificCategoryScreen(),
            ForgetPasswordScreen.routeName: (context)=>ForgetPasswordScreen(),
            ResetPasswordScreen.routeName: (context)=>ResetPasswordScreen(),
            ValidateCodeScreen.routeName: (context)=>ValidateCodeScreen(),
            MakeRequest.routeName: (context)=>MakeRequest(),
            OffersScreen.routeName: (context)=>OffersScreen(),
          },
          initialRoute: SplashScreen.routeName,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: Locale(settingsProvider.currentLocale),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}