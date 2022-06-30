import 'package:audio_book/config/device.dart';
import 'package:audio_book/constants/constants.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool? obscureText;
  final Icon? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;
  final int? maxLines;
  final FocusNode? focusNode;
  const CustomTextField({ 
    Key? key,
    required this.controller,
    required this.hintText,
    this.obscureText,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType,
    this.onChanged,
    this.maxLines,
    this.focusNode
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: focusNode,
      controller: controller,
      onChanged: onChanged,
      style: TextStyle(
        fontSize: Device.height*0.018, 
        color: Colors.black
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFFF5F5FA),
        hintText: hintText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        contentPadding: EdgeInsets.all(Device.height*0.024),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Constants.kColor1),
          borderRadius: BorderRadius.circular(6),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color : Color(0xFFF5F5FA),),
          borderRadius: BorderRadius.circular(6),
        ),
        hintStyle: TextStyle(
          fontSize: Device.height*0.02,
          color: Colors.grey
        ),
      ),
      maxLines: maxLines,
    );
  }
}