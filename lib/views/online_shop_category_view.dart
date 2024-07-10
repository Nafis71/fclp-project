import 'package:fclp_app/Controllers/product_category_view_controller.dart';
import 'package:fclp_app/utils/color_palette.dart';
import 'package:fclp_app/views/product_view.dart';
import 'package:fclp_app/widgets/global_widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OnlineShopCategoryView extends StatefulWidget {
  const OnlineShopCategoryView({super.key});

  @override
  State<OnlineShopCategoryView> createState() => _OnlineShopCategoryViewState();
}

class _OnlineShopCategoryViewState extends State<OnlineShopCategoryView> {
  @override
  Widget build(BuildContext context) {
    final produdctController =
        Provider.of<ProdudctCategoryViewController>(context);
    return Scaffold(
      appBar: customAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: GridView.builder(
          itemCount: produdctController.productCategoryViewData.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProductView(),
                  ),
                );
              },
              child: Card(
                child: SizedBox(
                  height: 150,
                  width: 150,
                  child: FittedBox(
                    child: Column(
                      children: [
                        Image.asset(
                          produdctController.productCategoryViewData[index]
                              ['img'],
                          height: 50,
                        ),
                        Text(
                          produdctController.productCategoryViewData[index]
                              ['title'],
                          style: const TextStyle(
                            color: AppColors.green,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
