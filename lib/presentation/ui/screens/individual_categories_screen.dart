import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/product_controller.dart';
import '../utility/app_colors.dart';
import '../widgets/product_card.dart';

class IndividualCategoriesScrren extends StatefulWidget {
  const IndividualCategoriesScrren(
      {super.key, this.categoryName, required this.categoryId});

  final String? categoryName;
  final int categoryId;

  @override
  State<IndividualCategoriesScrren> createState() =>
      _IndividualCategoriesScrrenState();
}

class _IndividualCategoriesScrrenState extends State<IndividualCategoriesScrren> {
  @override
  void initState() {
    super.initState();
    Get.find<ProductController>().getProduct(widget.categoryId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor.withOpacity(.5),
        title: Text(widget.categoryName!),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.02),
              child:
                  GetBuilder<ProductController>(builder: (productController) {
                return Visibility(
                  visible: productController.isLoading == false,
                  replacement: Center(child: CircularProgressIndicator()),
                  child: Visibility(
                    visible: productController.productModel.ProductList?.isNotEmpty??false,
                    replacement: Center(child: Text('Not available'),),
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: MediaQuery.of(context).orientation ==
                                Orientation.portrait
                            ? 2
                            : 3,
                        childAspectRatio:
                            MediaQuery.of(context).size.width * 0.003,
                        mainAxisSpacing: MediaQuery.of(context).size.width * 0.02,
                      ),
                      itemCount: productController.productModel.ProductList?.length??0,
                      itemBuilder: (context, index) {
                        return ProductCard(
                            product: productController
                                .productModel.ProductList![index]);
                      },
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
