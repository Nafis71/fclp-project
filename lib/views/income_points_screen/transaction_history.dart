import 'package:fclp_app/Controllers/profile_controller.dart';
import 'package:fclp_app/utils/assets_paths.dart';
import 'package:fclp_app/utils/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class TransactionHistory extends StatefulWidget {
  const TransactionHistory({super.key});

  @override
  State<TransactionHistory> createState() => _TransactionHistoryState();
}

class _TransactionHistoryState extends State<TransactionHistory> {
  @override
  void initState() {
    context.read<ProfileController>().getRedeemTransactionList(forceRefresh: false);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileController>(builder: (_, profileController, __) {
      if(profileController.isTransactionHistoryLoading){
        return Column(
          children: [
            LinearProgressIndicator(color: AppColors.themeColor,minHeight: 2,),
          ],
        );
      }
      if(profileController.redeemList.isEmpty){
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(AssetsPaths.noTransaction,width: 250,),
            const Text("আপনার বর্তমানে কোনো লেনদেনের ইতিহাস নেই")
          ],
        );
      }
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("পয়েন্ট ব্যাবহার করেছেন : ${profileController.total_redeem}",style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 15),),
                  Text("সর্বমোট টাকা তুলেছেন : ${profileController.total_amount} BDT",style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 13),)
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    return Material(
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        leading: SvgPicture.asset(
                          AssetsPaths.transaction,
                          width: 33,

                        ),
                        title: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "Mobile Banking: ",
                                style:
                                    Theme.of(context).textTheme.titleMedium,
                              ),
                              TextSpan(
                                text: profileController
                                    .redeemList[index].paymentMethod!
                                    .toUpperCase(),
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                      color: AppColors.themeColor,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: profileController
                                        .redeemList[index].status,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                        color: profileController
                                            .redeemList[index]
                                            .status ==
                                            "unpaid"
                                            ? Colors.red
                                            : AppColors.themeColor),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text("${profileController.redeemList[index].point!} points",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                    color: Colors.grey, fontSize: 14)),
                            const SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                        tileColor: Colors.grey.shade100,
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.attach_money,
                              color: AppColors.themeColor,
                            ),
                            Text(
                              profileController.redeemList[index].amount!,
                              style: Theme.of(context).textTheme.titleMedium,
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 10,
                    );
                  },
                  itemCount: profileController.redeemList.length),
            )
          ],
        ),
      );
    });
  }
}
