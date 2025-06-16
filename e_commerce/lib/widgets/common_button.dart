import 'package:flutter/material.dart';

import '../../utils/app_color.dart';
import '../../utils/sizer_utils.dart';
import '../utils/app_text_style.dart';
import 'common_text.dart';

class CommonButton extends StatelessWidget {
  final double? buttonTextSize;
  final double borderWidth;
  final double? height;
  final double? width;
  final double radius;
  final double mTop;
  final double mBottom;
  final double mLeft;
  final double mRight;
  final double pVertical;
  final double pHorizontal;
  final Function()? onTap;
  final LinearGradient? gradient;
  final bool isLoading;

  final String text;
  final int? buttonTextMaxLines;
  final TextAlign buttonTextAlign;
  final TextStyle? buttonTextStyle;

  const CommonButton({
    super.key,
    required this.text,
    this.borderWidth = 1.2,
    this.buttonTextSize,
    this.radius = 15,
    this.height,
    this.width,
    this.mTop = 0,
    this.mBottom = 0,
    this.mLeft = 0,
    this.mRight = 0,
    this.pVertical = 0,
    this.pHorizontal = 0,
    this.onTap,
    this.buttonTextStyle,
    this.buttonTextMaxLines,
    this.buttonTextAlign = TextAlign.center,
    this.gradient,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: mTop, bottom: mBottom, left: mLeft, right: mRight),
      child: InkWell(
        onTap: isLoading ? null : onTap,
        splashColor: CustomAppColor.of(context).transparent,
        child: Container(
          height: height?.setHeight ?? 0.buttonHeight,
          width: width?.setWidth ?? 0.screenFullWidth,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: pVertical, horizontal: pHorizontal),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            gradient: gradient ?? CustomAppColor.of(context).buttonGradient,
          ),
          child: isLoading
              ? SizedBox(
                  height: 22.setHeight,
                  width: 22.setHeight,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2.5,
                  ),
                )
              : CommonText(
                  text: text,
                  textStyle: buttonTextStyle ?? AppTextStyle.of(context).text16WhiteBold,
                  maxLines: buttonTextMaxLines,
                  textAlign: buttonTextAlign,
                ),
        ),
      ),
    );
  }
}
