 import 'package:aqua_flow/utils/constants.dart';
import 'package:aqua_flow/widgets/custom_text.dart';
import 'package:flutter/material.dart';

Widget dropdownField({
    required String hint,
    required List<String> items,
    required String? value,
    required Function(String?) onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: ColorConstants.lightGrey),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          hint: CustomText(text: hint, fontSize: 12),
          isExpanded: true,
          items: items
              .map(
                (e) => DropdownMenuItem<String>(
                  value: e,
                  child: CustomText(text: e, fontSize: 12),
                ),
              )
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }