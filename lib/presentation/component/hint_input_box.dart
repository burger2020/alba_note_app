import 'package:albanote_project/etc/colors.dart';
import 'package:albanote_project/etc/custom_class/masked_text_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

///
class TitleTextField extends StatelessWidget {
  const TitleTextField(
      {Key? key, this.controller,
      required this.title,
      this.subtitle,
      required this.hintText,
      this.keyboardType = TextInputType.text,
      this.textInputAction = TextInputAction.next,
      this.onChange})
      : super(key: key);

  final String title;
  final String? subtitle;
  final String hintText;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final Function? onChange;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 14)),
        const SizedBox(height: 10),
        subtitle != null
            ? Column(children: [
                Text(subtitle!, style: const TextStyle(fontSize: 13, color: Colors.grey)),
                const SizedBox(height: 10)
              ])
            : Container(),
        TextField(
          inputFormatters: keyboardType == TextInputType.phone
              ? [
                  MaskTextInputFormatter(
                      mask: '###-####-####', filter: {"#": RegExp(r'[0-9]')}, type: MaskAutoCompletionType.lazy)
                ]
              : [],
          textInputAction: textInputAction,
          cursorColor: MyColors.primary,
          keyboardType: keyboardType,
          onChanged: (text) {
            if(onChange != null) onChange!(text);
          },
          style: const TextStyle(fontSize: 14),
          decoration: InputDecoration(
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
              hintText: hintText,
              hintStyle: const TextStyle(color: Colors.grey),
              border: const OutlineInputBorder(
                borderSide: BorderSide(width: 0.5, color: Colors.black),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: MyColors.primary),
              )),
          controller: controller,
        )
      ],
    );
  }
}
