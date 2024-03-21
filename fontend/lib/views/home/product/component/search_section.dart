import 'package:flutter/material.dart';
import 'package:fontend/constant/color.dart';
import 'package:fontend/constant/dimen.dart';
import 'package:fontend/constant/heading.dart';
import 'package:fontend/controller/product_controller.dart';
import 'package:fontend/controller/profile_controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchSection extends StatelessWidget {
  SearchSection({
    super.key,
  });

  final ProfileController _profileController = Get.put(ProfileController());
  final ProductController _productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    AppDimen.init(context);

    return Container(
      padding: EdgeInsets.all(AppDimen.screenWidth * 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(
            () => Text(
              _profileController.user.value?.username != null
                  ? 'Hello,${_profileController.user.value?.username}'
                  : "Hello, ...",
              style:
                  GoogleFonts.roboto(fontSize: H3, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: primaryColor,
                width: 1.5,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(30),
              ),
            ),
            child: TextField(
              controller: _productController.searchController,
              decoration: const InputDecoration(
                hintText: "Search coffee",
                prefixIcon: Icon(Icons.search),
                border: InputBorder.none,
              ),
            ),
          )
        ],
      ),
    );
  }
}
