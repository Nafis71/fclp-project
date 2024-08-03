class RedeemList {
  int? id;
  String? userId;
  String? paymentMethod;
  String? mobile;
  String? trxId;
  String? point;
  String? amount;
  String? status;
  String? createdAt;
  String? updatedAt;

  RedeemList(
      {this.id,
      this.userId,
      this.paymentMethod,
      this.mobile,
      this.trxId,
      this.point,
      this.amount,
      this.status,
      this.createdAt,
      this.updatedAt});

  RedeemList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    paymentMethod = json['payment_method'];
    mobile = json['mobile'];
    trxId = json['trx_id'];
    point = json['point'];
    amount = json['amount'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['payment_method'] = this.paymentMethod;
    data['mobile'] = this.mobile;
    data['trx_id'] = this.trxId;
    data['point'] = this.point;
    data['amount'] = this.amount;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
