/// id : 1
/// name : "stringeman1"
/// description : "stringemannn1"
/// services : null

class CategoryResponse {
  CategoryResponse({
      this.id,
      this.name,
      this.description,});

  CategoryResponse.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
  }
  int? id;
  String? name;
  String? description;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['description'] = description;
    return map;
  }
}