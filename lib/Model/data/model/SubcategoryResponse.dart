class SubcategoryResponse {
  SubcategoryResponse({
      this.id, 
      this.name, 
      this.description,
      this.minFees,
      this.maxFees,
  });
  SubcategoryResponse.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    minFees = json['minFees'];
    maxFees = json['maxFees'];
  }
  int? id;
  String? name;
  String? description;
  int? minFees;
  int? maxFees;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['description'] = description;
    map['minFees'] = minFees;
    map['maxFees'] = maxFees;
    return map;
  }
}