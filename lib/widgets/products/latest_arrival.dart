import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/product_model.dart';
import '../../providers/cart_provider.dart';
import '../../providers/viewed_recently_provider.dart';
import '../../screens/inner_screen/product_details.dart';
import '../../services/my_app_functions.dart';
import '../subtitle_text.dart';
import 'heart_btn.dart';

class LatestArrivalProductsWidget extends StatelessWidget {
  const LatestArrivalProductsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final productsModel = Provider.of<ProductModel>(context);
    final cartProvider = Provider.of<CartProvider>(context);

    final viewedProdProvider = Provider.of<ViewedProdProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () async {
          viewedProdProvider.addViewedProd(productId: productsModel.productId);
          await Navigator.pushNamed(context, ProductDetailsScreen.routName,
              arguments: productsModel.productId);
        },
        child: Card(
          elevation: 5,
          shadowColor: Colors.black54,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: const BorderSide(
                color: Color(0xFF0ffc0a95),
                width: 5.0,
                style: BorderStyle.solid,
              )),
          color: Colors.white,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          margin: const EdgeInsets.all(0),
          semanticContainer: true,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Color(0xFF0ffc0a95), // Set the background color here
            ),
            child: SizedBox(
              width: size.width * 0.50,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: FancyShimmerImage(
                        imageUrl: productsModel.productImage,
                        height: size.width * 0.31,
                        width: size.width * 0.40,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Flexible(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          productsModel.productTitle,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        FittedBox(
                          child: Row(
                            children: [
                              HeartButtonWidget(
                                productId: productsModel.productId,
                              ),
                              IconButton(
                                onPressed: () async {
                                  if (cartProvider.isProdinCart(
                                      productId: productsModel.productId)) {
                                    return;
                                  }
                                  try {
                                    await cartProvider.addToCartFirebase(
                                        productId: productsModel.productId,
                                        qty: 1,
                                        context: context);
                                  } catch (e) {
                                    await MyAppFunctions
                                        .showErrorOrWarningDialog(
                                      context: context,
                                      subtitle: e.toString(),
                                      fct: () {},
                                    );
                                  }
                                },
                                icon: Icon(
                                  cartProvider.isProdinCart(
                                    productId: productsModel.productId,
                                  )
                                      ? Icons.check
                                      : Icons.add_shopping_cart_outlined,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 1,
                        ),
                        FittedBox(
                          child: SubtitleTextWidget(
                            label: "${productsModel.productPrice}\Rs",
                            fontWeight: FontWeight.w600,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
