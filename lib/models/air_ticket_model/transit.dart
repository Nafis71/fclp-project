class Transit{
  int? id;
  String? airportName;
  String? divisionName;
  String? createdAt;
  String? updatedAt;

  Transit(
      {this.id,
        this.airportName,
        this.divisionName,
        this.createdAt,
        this.updatedAt});

  Transit.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    airportName = json['airport_name'];
    divisionName = json['division_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['airport_name'] = airportName;
    data['division_name'] = divisionName;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}