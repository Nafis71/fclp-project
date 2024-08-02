import 'package:fclp_app/utils/assets_paths.dart';
import 'package:fclp_app/utils/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TransactionHistory extends StatelessWidget {
  const TransactionHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Redeemed Coin : 46"),
                Text("Total Amount: 460 BDT")
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
                itemBuilder: (context, index) {
                  return Material(
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      leading: SvgPicture.asset(AssetsPaths.transaction,width: 35,color: AppColors.themeColor,),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Mobile Banking: Nagad"),
                          const SizedBox(height: 5,),
                          const Text("Points: 10"),
                          const SizedBox(height: 5,),
                          const Text("Amount: 10 BDT"),
                          const SizedBox(height: 5,),
                          RichText(text: TextSpan(
                              children: [
                                TextSpan(
                                    text: "TRXID: ",style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.grey, fontWeight: FontWeight.normal)
                                ),
                                TextSpan(text: "fhgbjfggf",style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.grey, fontWeight: FontWeight.normal)),
                              ]
                          ),),
                        ],
                      ),
                      tileColor: AppColors.secondaryThemeColor,
                      trailing: RichText(text: TextSpan(
                          children: [
                            TextSpan(text: "unpaid",style: Theme.of(context).textTheme.titleMedium),
                          ]
                      )),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 10,
                  );
                },
                itemCount: 2),
          )
        ],
      ),
    );
  }
}
