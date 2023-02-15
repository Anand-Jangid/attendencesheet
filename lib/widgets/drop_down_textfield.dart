import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class DropDownTextFielD extends StatelessWidget {
  final String hintText;
  final SingleValueDropDownController controller;
  final List<DropDownValueModel> dropDownList;

  const DropDownTextFielD({
    Key? key,
    required this.hintText,
    required this.controller,
    required this.dropDownList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropDownTextField(
      textFieldDecoration: InputDecoration(
          hintText: hintText,
          hintStyle: KtextstyleActivity,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.circular(10.0)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.circular(10.0))),
      controller: controller,
      clearOption: true,
      dropdownRadius: 10.0,
      textStyle: KtextstyleActivity1,
      listTextStyle: KtextstyleActivity1,
      dropDownList: dropDownList,
      onChanged: (val) {},
    );
  }
}
