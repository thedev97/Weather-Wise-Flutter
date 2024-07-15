import 'package:flutter/material.dart';
import 'package:flutter_weather_app/core/styles/font_styles.dart';

class SearchTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Function(String) onSubmitted;

  const SearchTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFf1ded0).withOpacity(0.8),
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.5),
            offset: const Offset(-1, -1),
            blurRadius: 2,
            spreadRadius: 1,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            offset: const Offset(1, 1),
            blurRadius: 2,
            spreadRadius: 1,
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        onChanged: (value) {
          controller.value = controller.value.copyWith(
            text: value.toUpperCase(),
            selection: TextSelection.collapsed(offset: value.length),
          );
        },
        style: FWFonts.regularFonts14,
        cursorColor: Colors.black,
        onSubmitted: onSubmitted,
        decoration: InputDecoration(
          hintText: hintText.toUpperCase(),
          hintStyle: FWFonts.hintRegularFonts14,
          suffixIcon: IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              if (controller.text.isNotEmpty) {
                onSubmitted(controller.text);
              }
            },
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: const BorderSide(
              color: Colors.black,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: const BorderSide(
              color: Colors.black,
              width: 1,
            ),
          ),
          filled: true,
          fillColor: const Color(0xFFf1ded0).withOpacity(0.8),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
        ),
      ),
    );
  }
}
