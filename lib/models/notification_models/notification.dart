class Notification {
  int? id;
  String? title;
  String? details;
  String? status;
  String? userId;
  String? type;
  String? createdAt;
  String? updatedAt;

  Notification(
      {this.id,
        this.title,
        this.details,
        this.status,
        this.userId,
        this.type,
        this.createdAt,
        this.updatedAt});

  Notification.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    details = json['details'];
    status = json['status'];
    userId = json['user_id'];
    type = json['type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['details'] = details;
    data['status'] = status;
    data['user_id'] = userId;
    data['type'] = type;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}