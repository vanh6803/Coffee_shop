import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:fontend/constant/color.dart';
import 'package:fontend/constant/dimen.dart';
import 'package:fontend/constant/heading.dart';
import 'package:fontend/controller/profile_controller.dart';
import 'package:fontend/controller/theme_controller.dart';
import 'package:fontend/views/home/profile/component/button_customer.dart';
import 'package:fontend/views/my_order/my_order_screen.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  _profileController.user.value?.username! ?? "",
                  style: const TextStyle(
                      fontSize: H3, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: InkWell(
                    onTap: () => _editProfile(context),
                    child: const Icon(Icons.edit),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  _profileController.user.value?.email! ?? "",
                  style: const TextStyle(fontSize: H6),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: InkWell(
                    onTap: () => _editEmail(context),
                    child: const Icon(Icons.edit),
                  ),
                ),
              ],
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
              onClick: () => _changePassword(context),
              title: "Change password",
              icon: const Icon(Icons.lock_outline),
            ),
            ButtonCustomer(
              onClick: () {
                Get.to(() => const MyOrderScreen());
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
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
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

  void _editProfile(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Wrap(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0)
                  .copyWith(bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Column(
                children: [
                  Text(
                    'Edit profile',
                    style: GoogleFonts.roboto(
                        fontWeight: FontWeight.bold, fontSize: H3),
                  ),
                  Form(
                    key: _profileController.formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            keyboardType: TextInputType.text,
                            validator: (text) =>
                                _profileController.usernameValidator(text!),
                            controller: _profileController.usernameController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              hintText: "Enter username",
                              prefixIcon: Icon(Icons.person),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            var result =
                                await _profileController.updateProfile();
                            if (result == 'success') {
                              setState(() {
                                _profileController.user.value!.username =
                                    _profileController.usernameController.text;
                              });

                              Navigator.of(context).pop();

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Profile updated successfully'),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Failed to update profile'),
                                ),
                              );
                            }
                          },
                          child: Container(
                            margin: const EdgeInsets.only(top: 10, bottom: 20),
                            padding: const EdgeInsets.all(12),
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'Update',
                                style: GoogleFonts.roboto(
                                    color: Colors.white, fontSize: H6),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  void _editEmail(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Wrap(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0)
                  .copyWith(bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Column(
                children: [
                  Text(
                    'Edit profile',
                    style: GoogleFonts.roboto(
                        fontWeight: FontWeight.bold, fontSize: H3),
                  ),
                  Form(
                    key: _profileController.formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            keyboardType: TextInputType.emailAddress,
                            validator: (text) =>
                                _profileController.emailValidator(text!),
                            controller: _profileController.emailController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              hintText: "enter email address",
                              prefixIcon: Icon(Icons.person),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            var result = await _profileController.updateEmail();
                            if (result == 'success') {
                              setState(() {
                                _profileController.user.value!.email =
                                    _profileController.emailController.text;
                              });

                              Navigator.of(context).pop();

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Profile updated successfully'),
                                ),
                              );
                            }
                            if (result == "email already exists") {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('email already exists'),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Failed to update profile'),
                                ),
                              );
                            }
                          },
                          child: Container(
                            margin: const EdgeInsets.only(top: 10, bottom: 20),
                            padding: const EdgeInsets.all(12),
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'Update',
                                style: GoogleFonts.roboto(
                                    color: Colors.white, fontSize: H6),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  void _changePassword(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Wrap(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0)
                  .copyWith(bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Column(
                children: [
                  Text(
                    'Edit profile',
                    style: GoogleFonts.roboto(
                        fontWeight: FontWeight.bold, fontSize: H3),
                  ),
                  Form(
                    key: _profileController.formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            controller:
                                _profileController.oldPasswordController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              hintText: "Old password",
                              prefixIcon: Icon(Icons.key),
                              suffixIcon: Icon(Icons.remove_red_eye_sharp),
                            ),

                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            controller:
                                _profileController.newPasswordController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              hintText: "Enter new password",
                              prefixIcon: Icon(Icons.key),
                              suffixIcon: Icon(Icons.remove_red_eye_sharp),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            controller:
                                _profileController.confirmNewPasswordController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              hintText: "Confirm new password",
                              prefixIcon: Icon(Icons.key),
                              suffixIcon: Icon(Icons.remove_red_eye_sharp),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            var result =
                                await _profileController.updateProfile();
                            if (result == 'success') {
                              setState(() {
                                _profileController.user.value!.username =
                                    _profileController.usernameController.text;
                              });

                              Navigator.of(context).pop();

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Profile updated successfully'),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Failed to update profile'),
                                ),
                              );
                            }
                          },
                          child: Container(
                            margin: const EdgeInsets.only(top: 10, bottom: 20),
                            padding: const EdgeInsets.all(12),
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'Update',
                                style: GoogleFonts.roboto(
                                    color: Colors.white, fontSize: H6),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
