import 'package:flutter/material.dart';
import 'package:fontend/constant/color.dart';
import 'package:fontend/constant/dimen.dart';
import 'package:fontend/constant/heading.dart';
import 'package:fontend/controller/cart_controller.dart';
import 'package:fontend/controller/location_controller.dart';
import 'package:fontend/controller/product_controller.dart';
import 'package:fontend/controller/profile_controller.dart';
import 'package:fontend/models/product.dart';
import 'package:fontend/views/home/product/component/header.dart';
import 'package:fontend/views/home/product/component/search_section.dart';
import 'package:fontend/views/product_detail/product_detail_screen.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductScreen extends StatelessWidget {
  ProductScreen({super.key});

  final ProductController _productController = Get.put(ProductController());
  final ProfileController _profileController = Get.put(ProfileController());
  final LocationController _locationController = Get.put(LocationController());
  final CartController _cartController = Get.put(CartController());

  // final _categoryController = Get.put(CategoryController());

  @override
  Widget build(BuildContext context) {
    AppDimen.init(context);

    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: AppDimen.screenWidth * 0.03,
                ),
                Header(
                  onClick: () {},
                ),
                SearchSection(),
                Obx(
                  () {
                    if (_productController.listProduct.isEmpty) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppDimen.screenWidth * 0.03,
                        ),
                        child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 4.0,
                            mainAxisSpacing: 4.0,
                            childAspectRatio: 3 / 4,
                          ),
                          itemCount: _productController.listProduct.length,
                          itemBuilder: (context, index) {
                            final product =
                                _productController.listProduct[index];
                            return Card(
                              clipBehavior: Clip.antiAlias,
                              elevation: 1.0,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height:
                                        AppDimen.screenWidth * 0.6 * (3 / 4),
                                    child: InkWell(
                                      child: Hero(
                                        tag: '${product['_id']}',
                                        child: Image.network(
                                          product["image"],
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      onTap: () {
                                        final data = Product.fromJson(product);
                                        Get.to(
                                          ProductDetailScreen(
                                            product: data,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 4.0,
                                    ),
                                    child: Text(
                                      product['name'],
                                      style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.bold,
                                        fontSize: H6,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: AppDimen.screenWidth * 0.03,
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '\$ ${product['price']}',
                                          style: GoogleFonts.roboto(
                                            fontWeight: FontWeight.bold,
                                            fontSize: H6,
                                          ),
                                        ),
                                        InkWell(
                                          child: Container(
                                            padding: const EdgeInsets.all(2),
                                            decoration: BoxDecoration(
                                              color: primaryColor,
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(
                                                  AppDimen.screenWidth,
                                                ),
                                              ),
                                            ),
                                            child: const Icon(
                                              Icons.add,
                                              color: Colors.white,
                                            ),
                                          ),
                                          onTap: () async {
                                            final data =
                                                Product.fromJson(product);
                                            await _cartController.addToData(
                                                data, "small");
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    const Icon(
                                                      Icons.check,
                                                      color: Colors.white,
                                                    ),
                                                    Text(
                                                      'Add to card',
                                                      style: GoogleFonts.roboto(
                                                          color: Colors.white),
                                                    ),
                                                  ],
                                                ),
                                                backgroundColor: primaryColor,
                                                duration: Durations.extralong3,
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
