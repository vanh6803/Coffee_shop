import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:fontend/constant/color.dart';
import 'package:fontend/constant/dimen.dart';
import 'package:fontend/constant/heading.dart';
import 'package:fontend/controller/theme_controller.dart';
import 'package:fontend/views/home/profile/component/button_customer.dart';
import 'package:fontend/views/my_order/my_order_screen.dart';
import 'package:get/get.dart';
import '../../../controller/profile_controller.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final ProfileController _profileController = Get.put(ProfileController());
  final ThemeController _themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    AppDimen.init(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: AppDimen.screenWidth * 0.3,
              height: AppDimen.screenWidth * 0.3,
              margin: EdgeInsets.only(top: AppDimen.screenHeight * 0.02),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12),
                  borderRadius: BorderRadius.all(
                      Radius.circular(AppDimen.screenWidth * 0.3 / 2)),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(_profileController
                                  .user.value?.avatar !=
                              ""
                          ? _profileController.user.value!.avatar!
                          : "https://image-us.24h.com.vn/upload/3-2023/images/2023-09-12/q--2--1694514524-739-width641height960.jpg"))),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              _profileController.user.value?.username! ?? "",
              style:
                  const TextStyle(fontSize: H3, fontWeight: FontWeight.bold),
            ),
            Text(
              _profileController.user.value?.email! ?? "",
              style: const TextStyle(fontSize: H6),
            ),
            Container(
              height: 1,
              width: AppDimen.screenWidth,
              margin: EdgeInsets.symmetric(
                  horizontal: AppDimen.screenWidth * 0.1,
                  vertical: AppDimen.screenHeight * 0.02),
              color: primaryColor,
            ),
            Obx(
              () => ButtonCustomer(
                onClick: () {
                  _themeController.toggleTheme();
                },
                title: _themeController.isDarkMode.value
                    ? "Switch to light mode"
                    : "Switch to dark mode",
                icon: Icon(_themeController.isDarkMode.value
                    ? Icons.light_mode
                    : Icons.dark_mode_outlined),
                action: FlutterSwitch(
                  height: AppDimen.screenWidth * 0.06,
                  width: AppDimen.screenWidth * 0.105,
                  toggleSize: AppDimen.screenWidth * 0.05,
                  value: _themeController.isDarkMode.value,
                  onToggle: (value) {
                    _themeController.toggleTheme();
                  },
                ),
              ),
            ),
            ButtonCustomer(
                onClick: () => _editProfile(context),
                title: "Edit profile",
                icon: const Icon(Icons.account_circle_outlined)),
            ButtonCustomer(
              onClick: () {
                Get.to(() => MyOrderScreen());
              },
              title: "My order",
              icon: const Icon(Icons.bookmark_border),
            ),
            GestureDetector(
              onTap: () {
                _profileController.logout();
              },
              child: Container(
                margin: EdgeInsets.all(AppDimen.screenWidth * 0.05),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.redAccent),
                    borderRadius:
                        const BorderRadius.all(Radius.circular(10))),
                child: const Text(
                  'Log out',
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: H6,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _editProfile(context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          child: Form(
            child: Column(
              children: [
                TextFormField()
              ],
            ),
          ),
        );
      },
    );
  }
}
