import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InputCreditionalsWidget extends StatelessWidget {
  const InputCreditionalsWidget(
      {Key? key,
      required this.controller,
      required this.hintText,
      this.obscureText,
      this.keyboardType,
      this.errorText,
      this.maxLength})
      : super(key: key);

  final TextEditingController controller;
  final String hintText;
  final String? errorText;
  final bool? obscureText;
  final TextInputType? keyboardType;
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350.w,
      height: 60.h,
      child: TextField(
        enabled: true,
        style: const TextStyle(color: Colors.white, fontSize: 20),
        keyboardType: keyboardType ?? TextInputType.text,
        decoration: InputDecoration(
            fillColor: const Color.fromRGBO(185, 185, 185, 1),
            filled: true,
            contentPadding:
                EdgeInsets.symmetric(vertical: 20.5.h, horizontal: 31.w),
            counterText: "",
            hintText: hintText,
            hintStyle: const TextStyle(
                color: Color.fromARGB(255, 255, 255, 255),
                fontWeight: FontWeight.w400,
                fontSize: 20),
            errorText: errorText,
            errorStyle: TextStyle(color: Colors.red.shade400, fontSize: 14),
            border: OutlineInputBorder(
                borderSide: const BorderSide(width: 0, style: BorderStyle.none),
                borderRadius: BorderRadius.circular(30))),
        controller: controller,
        maxLength: maxLength,
        obscureText: obscureText ?? false,
      ),
    );
  }
}
