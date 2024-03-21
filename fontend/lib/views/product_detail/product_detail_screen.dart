import 'package:flutter/material.dart';
import 'package:fontend/constant/color.dart';
import 'package:fontend/constant/dimen.dart';
import 'package:fontend/constant/heading.dart';
import 'package:fontend/controller/cart_controller.dart';
import 'package:fontend/controller/theme_controller.dart';
import 'package:fontend/models/product.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductDetailScreen extends StatefulWidget {
  ProductDetailScreen({Key? key, required this.product}) : super(key: key);

  final Product product;

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final _themeController = Get.put(ThemeController());
  final _cartController = Get.put(CartController());
  late String selectedSize;
  final sizesCoffee = ['small', 'medium', 'large'];

  @override
  void initState() {
    super.initState();
    selectedSize = 'small'; // Set default size to 'small'
  }

  @override
  Widget build(BuildContext context) {
    AppDimen.init(context);

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: AppDimen.screenWidth,
            height: AppDimen.screenWidth,
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(50),
                bottomLeft: Radius.circular(50),
              ),
            ),
            child: Stack(
              children: [
                Hero(
                  tag: '${widget.product.id}',
                  child: Container(
                    width: AppDimen.screenWidth,
                    height: AppDimen.screenWidth,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(widget.product.image ?? ""),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: AppDimen.screenHeight * 0.06,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppDimen.screenWidth * 0.07,
                    ),
                    width: AppDimen.screenWidth,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: _themeController.isDarkMode.value
                                ? Colors.black54
                                : Colors.white54,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(60),
                            ),
                          ),
                          child: InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: const Icon(
                              Icons.arrow_back,
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.favorite_border,
                          color: Colors.redAccent,
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.all(AppDimen.screenWidth * 0.03),
                    color: Colors.black54,
                    child: Center(
                      child: Text(
                        widget.product.name ?? "",
                        style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w700,
                          fontSize: H3,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppDimen.screenWidth * 0.04,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        height: AppDimen.screenWidth * 0.17,
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: _themeController.isDarkMode.value
                              ? Colors.black12
                              : Colors.grey[300],
                          borderRadius: const BorderRadius.all(
                            Radius.circular(30),
                          ),
                        ),
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: widget.product.ingredients!.length,
                          itemBuilder: (context, index) {
                            final item = widget.product.ingredients![index];
                            return Row(
                              children: [
                                Text(
                                  item ?? "",
                                  style: GoogleFonts.roboto(
                                    fontSize: H6,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                if (index <
                                    widget.product.ingredients!.length - 1)
                                  Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: CustomDivider(),
                                  ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: AppDimen.screenHeight * 0.02,
                    ),
                    Text(
                      'Coffee size',
                      style: GoogleFonts.roboto(
                        fontSize: H4,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: AppDimen.screenHeight * 0.02,
                    ),
                    SizedBox(
                      width: AppDimen.screenWidth,
                      height: AppDimen.screenWidth * 0.14,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: sizesCoffee.map((size) {
                          return InkWell(
                            splashColor: Colors.white10,
                            onTap: () {
                              setState(() {
                                selectedSize = size; // Update selected size
                              });
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              elevation: 2,
                              color: selectedSize == size
                                  ? primaryColor
                                  : _themeController.isDarkMode.value
                                      ? null
                                      : Colors.white,
                              child: Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: AppDimen.screenWidth * 0.07),
                                  child: Text(
                                    size,
                                    style: GoogleFonts.roboto(
                                      fontSize: H6,
                                      fontWeight: FontWeight.w500,
                                      color: selectedSize == size
                                          ? Colors.white
                                          : null, // Update text color
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(
                      height: AppDimen.screenHeight * 0.02,
                    ),
                    Text(
                      'About',
                      style: GoogleFonts.roboto(
                        fontSize: H4,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: AppDimen.screenHeight * 0.01,
                    ),
                    Text(
                      widget.product.about ?? "",
                      style: GoogleFonts.roboto(),
                    ),
                    SizedBox(
                      height: AppDimen.screenHeight * 0.04,
                    ),
                    GestureDetector(
                      onTap: () async {
                        await _cartController.addToData(
                            widget.product, selectedSize);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.check,
                                  color: Colors.white,
                                ),
                                Text(
                                  'Add to card',
                                  style:
                                      GoogleFonts.roboto(color: Colors.white),
                                ),
                              ],
                            ),
                            backgroundColor: primaryColor,
                            duration: Durations.extralong3,
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(13),
                        decoration: const BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.all(
                            Radius.circular(30),
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Add to Cart",
                              style: GoogleFonts.roboto(
                                fontSize: H4,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              width: AppDimen.screenWidth * 0.04,
                            ),
                            Container(
                              color: Colors.white,
                              width: 1,
                              height: 30,
                            ),
                            SizedBox(
                              width: AppDimen.screenWidth * 0.04,
                            ),
                            Text(
                              '\$ ${widget.product.price}',
                              style: GoogleFonts.roboto(
                                fontSize: H4,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: AppDimen.screenHeight * 0.04,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomDivider extends StatelessWidget {
  final _themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: double.infinity,
      color: _themeController.isDarkMode.value ? Colors.white : Colors.black,
      margin: const EdgeInsets.symmetric(
        horizontal: 4.0,
      ),
    );
  }
}
