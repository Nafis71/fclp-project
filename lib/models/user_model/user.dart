class User {
  int? id;
  String? name;
  String? email;
  String? mobile;
  String? role;
  String? emailVerifiedAt;
  String? isMobileVerified;
  String? referredBy;
  String? createdAt;
  String? updatedAt;

  User(
      {this.id,
        this.name,
        this.email,
        this.mobile,
        this.role,
        this.emailVerifiedAt,
        this.isMobileVerified,
        this.referredBy,
        this.createdAt,
        this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
    role = json['role'];
    emailVerifiedAt = json['email_verified_at'];
    isMobileVerified = json['is_mobile_verified'];
    referredBy = json['referred_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['mobile'] = mobile;
    data['role'] = role;
    data['email_verified_at'] = emailVerifiedAt;
    data['is_mobile_verified'] = isMobileVerified;
    data['referred_by'] = referredBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}