import 'package:flutter/material.dart';
import 'package:sowlab_assignment/constant/color_constant.dart';
import 'package:sowlab_assignment/constant/font_constant.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final IconData icon;
  final String hintText;
  final bool isPassword;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;

  CustomTextField({
    required this.controller,
    required this.icon,
    required this.hintText,
    this.isPassword = false,
    this.suffixIcon,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      decoration: const BoxDecoration(
          color: Color(0xffeeedec),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(icon, color: Colors.black),
          hintText: hintText,
          hintStyle: Vit.regular
              .copyWith(fontSize: 14, color: const Color(0x61000000)),
          suffixIcon: suffixIcon,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        ),
      ),
    );
  }
}
