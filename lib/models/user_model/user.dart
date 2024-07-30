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
  String image ="";
  String base64Image= "";
  String status = "";
  String totalRefer ="";
  String points = "";
  String referralCode ="";

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
      this.updatedAt,
      required this.image, required this.base64Image, required this.status});

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
    image = json['image'] ?? "";
    base64Image = json['base64'] ?? "";
    status = json['status'];
    totalRefer = json['total_refer'] ?? "";
    points = json['points'] ?? "";
    referralCode = json['referral_code'] ?? "";
  }

  Map<String, dynamic> toJsonUpdateProfile() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['mobile'] = mobile;
    data['image'] = base64Image;
    data['base64'] = base64Image;
    return data;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['isMobileVerified'] = isMobileVerified;
    data['emailVerifiedAt'] = emailVerifiedAt;
    data['referredBy'] = referredBy;
    data['role'] = role;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['name'] = name;
    data['email'] = email;
    data['mobile'] = mobile;
    data['image'] = image;
    data['base64'] = base64Image;
    data['status'] = status;
    return data;
  }
}
