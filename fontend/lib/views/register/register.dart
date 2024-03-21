import 'package:flutter/material.dart';
import 'package:fontend/constant/color.dart';
import 'package:fontend/constant/dimen.dart';
import 'package:fontend/constant/heading.dart';
import 'package:fontend/constant/image.dart';
import 'package:fontend/controller/register_controller.dart';
import 'package:fontend/controller/theme_controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Register extends StatelessWidget {
  Register({super.key});

  final RegisterController _registerController = Get.put(RegisterController());
  final _themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    AppDimen.init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SizedBox(
            width: AppDimen.screenWidth,
            height: AppDimen.screenHeight,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(LOGO, width: AppDimen.screenWidth / 1.5),
                  const Text(
                    'REGISTER',
                    style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: H1),
                  ),
                  Form(
                    key: _registerController.formKey,
                    child: Column(
                      children: [
                        Container(
                          width: AppDimen.screenWidth,
                          margin: EdgeInsets.only(
                              left: AppDimen.screenWidth * 0.05,
                              right: AppDimen.screenWidth * 0.05,
                              top: AppDimen.screenWidth * 0.05),
                          child: TextFormField(
                            controller: _registerController.emailController,
                            decoration: const InputDecoration(
                              hintText: "Email",
                              hintStyle: TextStyle(color: primaryColor),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50))),
                              contentPadding: EdgeInsets.all(10),
                              prefixIcon: Icon(
                                Icons.email,
                                color: primaryColor,
                              ),
                            ),
                            style: const TextStyle(
                              color: Colors.black
                            ),
                            keyboardType: TextInputType.emailAddress,
                            validator: (email) =>
                                _registerController.emailValidator(email!),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                          ),
                        ),
                        Container(
                            width: AppDimen.screenWidth,
                            margin: EdgeInsets.only(
                                left: AppDimen.screenWidth * 0.05,
                                right: AppDimen.screenWidth * 0.05,
                                top: AppDimen.screenWidth * 0.05),
                            child: Obx(
                              () => TextFormField(
                                controller:
                                    _registerController.passwordController,
                                decoration: InputDecoration(
                                  hintText: "Password",
                                  hintStyle:
                                      const TextStyle(color: primaryColor),
                                  border: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(50))),
                                  contentPadding: const EdgeInsets.all(10),
                                  suffixIcon: GestureDetector(
                                      onTap: () => _registerController
                                          .toggleShowPassword(),
                                      child:
                                          _registerController.hidePassword.value
                                              ? const Icon(
                                                  Icons.visibility_off,
                                                  color: Colors.grey,
                                                )
                                              : const Icon(
                                                  Icons.visibility,
                                                  color: Colors.grey,
                                                )),
                                  prefixIcon: const Icon(
                                    Icons.lock,
                                    color: primaryColor,
                                  ),
                                ),
                                style: const TextStyle(
                                    color: Colors.black
                                ),
                                validator: (value) => _registerController
                                    .passwordValidator(value!),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                keyboardType: TextInputType.visiblePassword,
                                obscureText:
                                    _registerController.hidePassword.value,
                              ),
                            )),
                        Container(
                          width: AppDimen.screenWidth,
                          margin: EdgeInsets.only(
                              left: AppDimen.screenWidth * 0.05,
                              right: AppDimen.screenWidth * 0.05,
                              top: AppDimen.screenWidth * 0.05),
                          child: Obx(
                            () => TextFormField(
                              controller:
                                  _registerController.confirmPasswordController,
                              decoration: InputDecoration(
                                hintText: "Confirm password",
                                hintStyle: const TextStyle(color: primaryColor),
                                border: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50))),
                                contentPadding: const EdgeInsets.all(10),
                                suffixIcon: GestureDetector(
                                    onTap: () => _registerController
                                        .toggleShowConfirmPassword(),
                                    child: _registerController
                                            .hidePasswordConfirm.value
                                        ? const Icon(
                                            Icons.visibility_off,
                                            color: Colors.grey,
                                          )
                                        : const Icon(
                                            Icons.visibility,
                                            color: Colors.grey,
                                          )),
                                prefixIcon: const Icon(
                                  Icons.lock,
                                  color: primaryColor,
                                ),
                              ),
                              style: const TextStyle(
                                  color: Colors.black
                              ),
                              validator: (value) => _registerController
                                  .confirmPasswordValidator(value!),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              keyboardType: TextInputType.visiblePassword,
                              obscureText:
                                  _registerController.hidePasswordConfirm.value,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(
                            AppDimen.screenWidth * 0.05,
                          ),
                          child: InkWell(
                            onTap: () => _registerController.register(
                                _registerController.emailController.text,
                                _registerController.passwordController.text),
                            child: Container(
                              width: double.infinity,
                              height: 45,
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(30),
                                boxShadow: [
                                  BoxShadow(
                                    color: _themeController.isDarkMode.value ? Colors.black12 : Colors.grey.withOpacity(0.7),
                                    spreadRadius: 3,
                                    blurRadius: 6,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Obx(() => _registerController.isLoading.value
                                      ? Container(
                                          width: 20,
                                          height: 20,
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child:
                                              const CircularProgressIndicator(
                                                  color: Colors.white))
                                      : Container()),
                                  // Conditionally show CircularProgressIndicator
                                  const Text(
                                    'REGISTER',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: H5),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                       Text('You have a account? ', style: GoogleFonts.roboto(color: Colors.black)),
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
