import 'dart:typed_data';

/// id : 1
/// description : "string"
/// location : "string"
/// status: "Requested"

class CustomerRequestsresponse {
  CustomerRequestsresponse({
      this.id, 
      this.description, 
      this.location,
      this.image,
      this.status
  });

  CustomerRequestsresponse.fromJson(dynamic json) {
    id = json['id'];
    description = json['description'];
    location = json['location'];
    image = json['image'];
    status = json['status'];
  }

  int? id;
  String? description;
  String? location;
  Uint8List? image;
  String? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['description'] = description;
    map['location'] = location;
    map['image'] = image;
    map['status'] = status;
    return map;
  }
}