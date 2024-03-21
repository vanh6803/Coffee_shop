import 'package:flutter/material.dart';
import 'package:fontend/constant/color.dart';
import 'package:fontend/constant/dimen.dart';
import 'package:fontend/constant/heading.dart';
import 'package:fontend/constant/image.dart';
import 'package:fontend/controller/login_controller.dart';
import 'package:fontend/controller/theme_controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatelessWidget {
  Login({super.key});

  final _loginController = Get.put(LoginController());
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
                    'LOGIN',
                    style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: H1),
                  ),
                  Form(
                    key: _loginController.formKey,
                    child: Column(
                      children: [
                        Container(
                          width: AppDimen.screenWidth,
                          margin: EdgeInsets.only(
                              left: AppDimen.screenWidth * 0.05,
                              right: AppDimen.screenWidth * 0.05,
                              top: AppDimen.screenWidth * 0.05),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: TextFormField(
                              controller: _loginController.emailController,
                              decoration: const InputDecoration(
                                hintText: "Email",
                                hintStyle: TextStyle(color: primaryColor),
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30))),
                                contentPadding: EdgeInsets.all(10),
                                prefixIcon: Icon(
                                  Icons.email,
                                  color: primaryColor,
                                ),
                              ),
                              style: const TextStyle(
                                  color: Colors.black
                              ),
                              validator: (value) =>
                                  _loginController.emailValidator(value!),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              keyboardType: TextInputType.emailAddress,
                            ),
                          ),
                        ),
                        Container(
                          width: AppDimen.screenWidth,
                          margin: EdgeInsets.only(
                              left: AppDimen.screenWidth * 0.05,
                              right: AppDimen.screenWidth * 0.05,
                              top: AppDimen.screenWidth * 0.05),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Obx(
                              () => TextFormField(
                                controller: _loginController.passwordController,
                                decoration: InputDecoration(
                                  hintText: "Password",
                                  hintStyle:
                                      const TextStyle(color: primaryColor),
                                  border: const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(30),
                                    ),
                                  ),
                                  contentPadding: const EdgeInsets.all(10),
                                  suffixIcon: GestureDetector(
                                    onTap: () =>
                                        _loginController.toggleHidePassword(),
                                    child: Icon(
                                        _loginController.hidePassword.value
                                            ? Icons.visibility
                                            : Icons.visibility_off),
                                  ),
                                  prefixIcon: const Icon(
                                    Icons.lock,
                                    color: primaryColor,
                                  ),
                                ),
                                style: const TextStyle(
                                    color: Colors.black
                                ),
                                obscureText:
                                    _loginController.hidePassword.value,
                                validator: (value) =>
                                    _loginController.passwordValidator(value!),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(
                            AppDimen.screenWidth * 0.05,
                          ),
                          child: GestureDetector(
                            onTap: () => _loginController.login(
                                _loginController.emailController.text,
                                _loginController.passwordController.text),
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
                              child: const Center(
                                child: Text(
                                  'LOGIN',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: H5),
                                ),
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
                       Text('Create a new account? ', style: GoogleFonts.roboto(color: Colors.black),),
                      InkWell(
                        onTap: () => _loginController.goToRegister(),
                        child: const Text(
                          'Register',
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
