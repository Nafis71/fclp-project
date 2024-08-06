import 'package:fclp_app/Controllers/product_controller.dart';
import 'package:fclp_app/Controllers/profile_controller.dart';
import 'package:fclp_app/views/home_screen/home_product_widget/product_grid_view.dart';
import 'package:fclp_app/widgets/global_widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductView extends StatefulWidget {
  final String categoryId;
  const ProductView({super.key, required this.categoryId});

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  int page = 1;
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    _scrollController.addListener(_scrollListener);
    _loadSpecificProductData(page, widget.categoryId);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ProductGridView(categoryId: widget.categoryId,fromCategoryScreen: true,)
          ],
        ),
      ),
    );
  }
  Future<void> _loadSpecificProductData(int page, String categoryId,
      {bool? fromScrollListener}) async {
    if (fromScrollListener != null && mounted) {
      await context.read<ProductController>().loadCategorialProductData(
          categoryId,
          context.read<ProfileController>().token,
          page,);
      return;
    }
    context.read<ProductController>().categorialProductData.clear();
    await context.read<ProductController>().loadCategorialProductData(
        categoryId,
        context.read<ProfileController>().token,
        page,);
  }

  void _scrollListener() {
    if (!context.read<ProductController>().isRelatedProductFetching &&
        context.read<ProductController>().relatedProductNextPageAvailable) {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        page += 1;
        _loadSpecificProductData(page, widget.categoryId,
            fromScrollListener: true);
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
