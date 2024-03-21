import 'package:flutter/material.dart';
import 'package:fontend/constant/color.dart';
import 'package:fontend/constant/dimen.dart';
import 'package:fontend/constant/heading.dart';
import 'package:fontend/controller/location_controller.dart';
import 'package:fontend/controller/profile_controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Header extends StatelessWidget {
  final VoidCallback onClick;

  Header({
    super.key,
    required this.onClick,
  });

  final ProfileController _profileController = Get.put(ProfileController());
  final LocationController _locationController = Get.put(LocationController());

  @override
  Widget build(BuildContext context) {
    AppDimen.init(context);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppDimen.screenWidth * 0.05,
        vertical: AppDimen.screenWidth * 0.02,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Obx(
            () => Container(
              width: AppDimen.screenWidth * 0.1,
              height: AppDimen.screenWidth * 0.1,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                    Radius.circular(AppDimen.screenWidth * 0.3 / 2)),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(_profileController
                              .user.value?.avatar?.isNotEmpty ==
                          true
                      ? _profileController.user.value!.avatar!
                      : "https://image-us.24h.com.vn/upload/3-2023/images/2023-09-12/q--2--1694514524-739-width641height960.jpg"),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.location_pin,
                  color: primaryColor,
                ),
                Obx(
                  () => Text(
                    _locationController.userAddress.value ?? "your location",
                    style: GoogleFonts.roboto(fontSize: H6),
                  ),
                )
              ],
            ),
          ),
          GestureDetector(
            child: const Icon(
              Icons.favorite_border,
              color: Colors.redAccent,
              size: H2,
            ),
          )
        ],
      ),
    );
  }
}
