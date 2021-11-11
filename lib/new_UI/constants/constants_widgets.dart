import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

Widget TextFormFieldWithBorder(
    {int lengthInputFormater,
    String regEx,
    int maxLength,
    String hintText,
    Icon icon}) {
  return TextFormField(
    cursorColor: Colors.black,
    keyboardType: TextInputType.number,
    inputFormatters: [
      LengthLimitingTextInputFormatter(lengthInputFormater),
      FilteringTextInputFormatter.allow(
        RegExp(regEx),
      ),
    ],
    maxLength: maxLength,
    onChanged: (value) {
      // controller.mobileNumber.value = value;
    },
    decoration: InputDecoration(
      suffixIcon: icon,
      // prefix: Text(
      //   " Give your Pin",
      //   style: TextStyle(color: Colors.black.withOpacity(0.7)),
      // ),
      fillColor: Colors.grey.shade200,
      filled: true,
      contentPadding: EdgeInsets.symmetric(horizontal: 8),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      counterText: "",
      hintText: hintText,
      hintStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.black26,
      ),
    ),
  );
}

Widget elevatedButtonStyled(
    {IconData icon,
    String text,
    Color buttonColor,
    Color buttonTextColor,
    double width,
    double height,
    double sizedBoxWidth,
    String svgAsset}) {
  return ElevatedButton(
    onPressed: () {},
    child: Row(
      children: [
        Icon(
          icon,
          color: Colors.black,
        ),
        SvgPicture.asset(svgAsset),
        SizedBox(
          width: sizedBoxWidth,
        ),
        Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(color: buttonTextColor, fontSize: 12),
          ),
        )
      ],
    ),
    style: ElevatedButton.styleFrom(
      side: BorderSide(width: 1, color: buttonColor),
      primary: buttonColor,
      fixedSize: Size(width, height),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(2),
      ),
    ),
  );
}
