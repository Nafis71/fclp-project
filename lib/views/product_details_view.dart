import 'package:cached_network_image/cached_network_image.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:fclp_app/utils/color_palette.dart';
import 'package:flutter/material.dart';

import '../models/product_model/product_data.dart';

class ProductDetailsView extends StatefulWidget {
  const ProductDetailsView({
    super.key,
    required this.productData,
  });

  final ProductData productData;

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  int? descriptionMaxLine = 8;
  TextOverflow? textOverflow = TextOverflow.ellipsis;
  String descriptionButtonName = "আরো দেখুন";

  @override
  Widget build(BuildContext context) {
    final ProductData productData = widget.productData;
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Row(
                          children: [
                            Icon(
                              EvaIcons.arrowIosBack,
                              size: 30,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "পণ্যের বিবরণ",
                              style: TextStyle(
                                  fontWeight: FontWeight.normal, fontSize: 17),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              EvaIcons.shoppingCartOutline,
                              size: 30,
                              color: AppColors.themeColor,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.favorite_outline_rounded,
                              size: 30,
                              color: AppColors.themeColor,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  CachedNetworkImage(
                    imageUrl:
                        "https://fclpbd.xyz/public/storage/${productData.image.toString()}",
                    imageBuilder: (context, imageProvider) {
                      return Container(
                        height: 320,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: imageProvider, fit: BoxFit.contain)),
                      );
                    },
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Wrap(
                          direction: Axis.horizontal,
                          children: [
                            Text(
                              productData.name.toString(),
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 100,
                              child: Text(
                                productData.category!.name.toString(),
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey.shade500,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                      color: AppColors.secondaryThemeColor,
                                      borderRadius: BorderRadius.circular(6)),
                                  alignment: Alignment.center,
                                  child: const Icon(
                                    Icons.remove,
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text("1"),
                                const SizedBox(
                                  width: 8,
                                ),
                                Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                      color: AppColors.secondaryThemeColor,
                                      borderRadius: BorderRadius.circular(6)),
                                  alignment: Alignment.center,
                                  child: const Icon(
                                    Icons.add,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        if (productData.sizes!.isNotEmpty)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                (productData.category!.name == "Smart Phone")
                                    ? "ভ্যারিয়েন্ট"
                                    : "আকার",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20,
                                    color: AppColors.themeColor),
                              ),
                              SizedBox(
                                height: 40,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: ListView.separated(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: productData.sizes!.length,
                                        itemBuilder: (context, index) {
                                          return Container(
                                            width: 70,
                                            decoration: BoxDecoration(
                                                color: AppColors
                                                    .secondaryThemeColor,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            alignment: Alignment.center,
                                            child: Text(
                                              (productData.category!.name ==
                                                      "Smart Phone")
                                                  ? "${productData.sizes![index].name.toString()} GB"
                                                  : productData
                                                      .sizes![index].name
                                                      .toString(),
                                              style: const TextStyle(
                                                color: AppColors.black,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          );
                                        },
                                        separatorBuilder:
                                            (BuildContext context, int index) {
                                          return const SizedBox(
                                            width: 10,
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                            ],
                          ),
                        Text(
                          "বর্ণনা",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                              color: AppColors.themeColor),
                        ),
                        Text(
                          textAlign: TextAlign.justify,
                          overflow: textOverflow,
                          maxLines: descriptionMaxLine,
                          productData.description.toString(),
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.35,
                              height: 40,
                              child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  elevation: 5,
                                  side: BorderSide(
                                      color: AppColors.secondaryThemeColor),
                                ),
                                onPressed: () {
                                  setState(() {
                                    if (descriptionMaxLine != null) {
                                      descriptionMaxLine = null;
                                      textOverflow = null;
                                      descriptionButtonName = "কম দেখুন";
                                      return;
                                    }
                                    textOverflow = TextOverflow.ellipsis;
                                    descriptionMaxLine = 8;
                                    descriptionButtonName = "আরো দেখুন";
                                  });
                                },
                                child: Text(
                                  descriptionButtonName,
                                  style: TextStyle(color: AppColors.themeColor),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            height: 100,
            width: double.infinity,
            decoration: BoxDecoration(
                color: AppColors.secondaryThemeColor,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(25),
                  topLeft: Radius.circular(25),
                )),
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Price",
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "\u09F3\t1000",
                        style: TextStyle(
                          color: AppColors.themeColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.39,
                      child: ElevatedButton(
                          onPressed: () {},
                          child: Text(
                            "কার্টে যোগ করুন",
                            style: TextStyle(fontSize: 13),
                          )))
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }
}
