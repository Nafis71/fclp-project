import 'package:fclp_app/widgets/global_widgets/custom_app_bar.dart';
import 'package:fclp_app/widgets/global_widgets/product_grid_view.dart';
import 'package:flutter/material.dart';

class ProductView extends StatefulWidget {
  const ProductView({super.key});

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            ProductGridView(),
          ],
        ),
      ),
    );
  }
}
