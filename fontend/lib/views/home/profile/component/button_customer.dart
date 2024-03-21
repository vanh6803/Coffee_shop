import 'package:flutter/material.dart';
import 'package:fontend/constant/color.dart';
import 'package:fontend/constant/dimen.dart';
import 'package:fontend/constant/heading.dart';

class ButtonCustomer extends StatelessWidget {

  final VoidCallback onClick;
  final String title;
  final Widget icon;
  final Widget? action;

  const ButtonCustomer({super.key, required this.onClick, required this.title, required this.icon, this.action});

  @override
  Widget build(BuildContext context) {

    AppDimen.init(context);

    return GestureDetector(
      onTap: onClick,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: AppDimen.screenWidth * 0.025, horizontal: AppDimen.screenWidth * 0.025),
        margin: EdgeInsets.symmetric(vertical: AppDimen.screenHeight* 0.01, horizontal: AppDimen.screenWidth * 0.05),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(width: 1, color: primaryColor),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: icon,
            ),
            Expanded(child: Text(title, style: TextStyle(fontSize: H6, fontWeight: FontWeight.w700),)),
            if (action != null) action!,
          ],
        ),
      ),
    );
  }
}
