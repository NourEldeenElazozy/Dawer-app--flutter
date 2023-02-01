import 'package:dawerf/Utiils/colors.dart';
import 'package:dawerf/Utiils/text_font_family.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

String items='';
heavyText(text, color, double size, [align]) => Text(
      text,
      textAlign: align,
      style: TextStyle(
          fontFamily: TextFontFamily.KHALED_FONT,
          fontSize: size,
          color: color),
    );

bookText(text, color, double size, [align]) => Text(
  text,
  textAlign: align,
  style: TextStyle(
      fontFamily: TextFontFamily.KHALED_FONT,
      fontSize: size,
      color: color),
);

blackText(text, color, double size, [align]) => Text(
  text,
  textAlign: align,
  style: TextStyle(
      fontFamily: TextFontFamily.CAIRO_MEDIUM,
      fontSize: size,
      color: color),
);

lightText(text, color, double size, [align]) => Text(
  text,
  textAlign: align,
  style: TextStyle(
      fontFamily: TextFontFamily.KHALED_FONT,
      fontSize: size,
      color: color),
);

mediumText(text, color, double size, [align]) => Text(
  text,
  textAlign: align,
  style: TextStyle(
      fontFamily: TextFontFamily.KHALED_FONT,
      fontSize: size,
      color: color),
);

romanText(text, color, double size, [align]) => Text(
  text,
  textAlign: align,
  style: TextStyle(
      fontFamily: TextFontFamily.KHALED_FONT,
      fontSize: size,
      color: color),
);

commonButton(onTap, text,buttonColor,textColor) => InkWell(
  onTap: onTap,
  child: Container(
    height: 60,
    width: Get.width,
    decoration: BoxDecoration(
      color: buttonColor,
      borderRadius: BorderRadius.circular(16),
    ),
    child: Center(
      child: heavyText(text,textColor, 18),
    ),
  ),
);

textField1(hintText,controller,keyBoardType) => TextFormField(

  cursorColor: ColorResources.black,
  controller: controller,
  keyboardType: keyBoardType,
  style: TextStyle(
    color: ColorResources.black,
    fontSize: 20,
    fontFamily: TextFontFamily.KHALED_FONT,
  ),
  decoration: InputDecoration(
    contentPadding: EdgeInsets.zero,
    hintText: hintText,
    hintStyle: TextStyle(
      color: ColorResources.grey777,
      fontSize: 16,
      fontFamily: TextFontFamily.KHALED_FONT,
    ),
    filled: true,
    fillColor: ColorResources.whiteF6F,
    border: UnderlineInputBorder(
      borderSide: BorderSide(color: ColorResources.greyA0A, width: 1),
    ),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: ColorResources.greyA0A, width: 1),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: ColorResources.greyA0A, width: 1),
    ),
  ),
);

textField2(hintText,controller,keyBoardType)=> TextFormField(
  maxLines: 5,
  controller: controller,
  cursorColor: ColorResources.black,
  keyboardType: keyBoardType,
  style: TextStyle(
    color: ColorResources.grey777,
    fontSize: 16,
    fontFamily: TextFontFamily.CAIRO_MEDIUM,
  ),
  decoration: InputDecoration(
    hintText: hintText,
    hintStyle: TextStyle(
      color: ColorResources.grey777,
      fontSize: 16,
      fontFamily: TextFontFamily.CAIRO_MEDIUM,
    ),
    filled: true,
    fillColor: ColorResources.whiteF6F,
    border: OutlineInputBorder(
      borderSide:
      BorderSide(color: ColorResources.greyA0A.withOpacity(0.4), width: 1),
      borderRadius: BorderRadius.circular(10),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide:
      BorderSide(color: ColorResources.greyA0A.withOpacity(0.4), width: 1),
      borderRadius: BorderRadius.circular(10),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide:
      BorderSide(color: ColorResources.greyA0A.withOpacity(0.4), width: 1),
      borderRadius: BorderRadius.circular(10),
    ),
  ),
);