import 'package:fclp_app/models/redeem_list_model/redeem_list.dart';

class RedeemListModel {
  List<RedeemList>? redeemList;
  String? totalRedeem;
  String? totalAmount;

  RedeemListModel({this.redeemList, this.totalRedeem, this.totalAmount});

  RedeemListModel.fromJson(Map<String, dynamic> json) {
    if (json['redeem_list'] != null) {
      redeemList = <RedeemList>[];
      json['redeem_list'].forEach((v) {
        redeemList!.add(RedeemList.fromJson(v));
      });
    }
    totalRedeem = json['total_redeem'];
    totalAmount = json['total_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (redeemList != null) {
      data['redeem_list'] = redeemList!.map((v) => v.toJson()).toList();
    }
    data['total_redeem'] = totalRedeem;
    data['total_amount'] = totalAmount;
    return data;
  }
}