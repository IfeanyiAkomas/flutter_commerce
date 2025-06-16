import 'package:flutter/material.dart';

import '../../utils/app_color.dart';
import '../../utils/sizer_utils.dart';
import '../utils/app_text_style.dart';
import 'common_text.dart';
import 'shadow_widget.dart';

class CommonTextFormFieldWithOutPrefixAndWithoutSuffix extends StatelessWidget {
  final String hintText;
  final String? validatorText;
  final String? title;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final bool obscureText;
  final bool autofocus;
  final bool readOnly;
  final Color? fillColor;
  final Function(String)? onTextChanged;
  final double radius;
  final int maxLines;
  final Function()? onTap;
  final String? Function(String? value)? validator;
  final Color? borderColor;

  const CommonTextFormFieldWithOutPrefixAndWithoutSuffix({
    super.key,
    required this.controller,
    required this.hintText,
    this.title,
    this.fillColor,
    this.keyboardType,
    this.obscureText = false,
    this.autofocus = false,
    this.readOnly = false,
    this.onTextChanged,
    this.onTap,
    this.radius = 15,
    this.maxLines = 1,
    this.validatorText,
    this.validator,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null) CommonText(text: title ?? "", textStyle: AppTextStyle.of(context).text15BlackBold),
        if (title != null) SizedBox(height: 8.setHeight),
        CommonShadowWidget(
          child: TextFormField(
            controller: controller,
            autofocus: autofocus,
            obscureText: obscureText,
            keyboardType: keyboardType,
            cursorColor: CustomAppColor.of(context).txtBlack,
            style: AppTextStyle.of(context).text14BlackRegular,
            maxLines: maxLines,
            onChanged: onTextChanged,
            readOnly: readOnly,
            onTap: onTap,
            validator: validator ??
                (String? value) {
                  if (value == null || value.isEmpty) {
                    return validatorText;
                  }
                  return null;
                },
            decoration: InputDecoration(
              filled: true,
              fillColor: fillColor ?? CustomAppColor.of(context).textFormFieldColor,
              hintText: hintText,
              hintStyle: AppTextStyle.of(context).text14GrayRegular,
              errorMaxLines: 2,
              errorStyle: AppTextStyle.of(context).text14RedRegular,
              contentPadding: EdgeInsets.only(
                top: 18.setHeight,
                bottom: 18.setHeight,
                left: 20.setWidth,
                right: 20.setWidth,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius),
                borderSide: BorderSide(color: borderColor ?? CustomAppColor.of(context).textFormFieldBorderColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius),
                borderSide: BorderSide(color: borderColor ?? CustomAppColor.of(context).textFormFieldBorderColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius),
                borderSide: BorderSide(color: borderColor ?? CustomAppColor.of(context).textFormFieldBorderColor),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius),
                borderSide: BorderSide(color: CustomAppColor.of(context).bgRed),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius),
                borderSide: BorderSide(color: borderColor ?? CustomAppColor.of(context).textFormFieldBorderColor),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius),
                borderSide: BorderSide(color: borderColor ?? CustomAppColor.of(context).bgRed),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CommonTextFormFieldWithPrefix extends StatelessWidget {
  final String hintText;
  final String? validatorText;
  final String? title;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final bool obscureText;
  final bool autofocus;
  final bool readOnly;
  final Color? fillColor;
  final Function(String)? onTextChanged;
  final double radius;
  final int maxLines;
  final Function()? onTap;
  final String? Function(String? value)? validator;
  final Color? borderColor;
  final String prefixIcon;

  const CommonTextFormFieldWithPrefix({
    super.key,
    required this.controller,
    required this.hintText,
    this.title,
    this.fillColor,
    this.keyboardType,
    this.obscureText = false,
    this.autofocus = false,
    this.readOnly = false,
    this.onTextChanged,
    this.onTap,
    this.radius = 15,
    this.maxLines = 1,
    this.validatorText,
    this.validator,
    this.borderColor,
    required this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null) CommonText(text: title ?? "", textStyle: AppTextStyle.of(context).text15BlackBold),
        if (title != null) SizedBox(height: 8.setHeight),
        CommonShadowWidget(
          child: TextFormField(
            controller: controller,
            autofocus: autofocus,
            obscureText: obscureText,
            keyboardType: keyboardType,
            cursorColor: CustomAppColor.of(context).txtBlack,
            style: AppTextStyle.of(context).text14BlackRegular,
            maxLines: maxLines,
            onChanged: onTextChanged,
            readOnly: readOnly,
            onTap: onTap,
            validator: validator ??
                (String? value) {
                  if (value == null || value.isEmpty) {
                    return validatorText;
                  }
                  return null;
                },
            decoration: InputDecoration(
              filled: true,
              fillColor: fillColor ?? CustomAppColor.of(context).textFormFieldColor,
              hintText: hintText,
              hintStyle: AppTextStyle.of(context).text14GrayRegular,
              errorMaxLines: 2,
              errorStyle: AppTextStyle.of(context).text14RedRegular,
              contentPadding: EdgeInsets.only(
                top: 18.setHeight,
                bottom: 18.setHeight,
                left: 20.setWidth,
                right: 20.setWidth,
              ),
              prefixIcon: Padding(
                padding: EdgeInsets.all(15.setHeight),
                child: Image.asset(
                  prefixIcon,
                  height: 24.setHeight,
                  width: 24.setWidth,
                  gaplessPlayback: true,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius),
                borderSide: BorderSide(color: borderColor ?? CustomAppColor.of(context).textFormFieldBorderColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius),
                borderSide: BorderSide(color: borderColor ?? CustomAppColor.of(context).textFormFieldBorderColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius),
                borderSide: BorderSide(color: borderColor ?? CustomAppColor.of(context).textFormFieldBorderColor),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius),
                borderSide: BorderSide(color: CustomAppColor.of(context).bgRed),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius),
                borderSide: BorderSide(color: borderColor ?? CustomAppColor.of(context).textFormFieldBorderColor),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius),
                borderSide: BorderSide(color: borderColor ?? CustomAppColor.of(context).bgRed),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CommonTextFormFieldWithSuffix extends StatelessWidget {
  final String hintText;
  final String? validatorText;
  final String? title;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final bool obscureText;
  final bool autofocus;
  final bool readOnly;
  final Color? fillColor;
  final Function(String)? onTextChanged;
  final double radius;
  final int maxLines;
  final Function()? onTap;
  final String? Function(String? value)? validator;
  final Color? borderColor;
  final String suffixIcon;
  final Function()? onSuffixIconTap;

  const CommonTextFormFieldWithSuffix({
    super.key,
    required this.controller,
    required this.hintText,
    this.title,
    this.fillColor,
    this.keyboardType,
    this.obscureText = false,
    this.autofocus = false,
    this.readOnly = false,
    this.onTextChanged,
    this.onTap,
    this.radius = 15,
    this.maxLines = 1,
    this.validatorText,
    this.validator,
    this.borderColor,
    required this.suffixIcon,
    this.onSuffixIconTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null) CommonText(text: title ?? "", textStyle: AppTextStyle.of(context).text15BlackBold),
        if (title != null) SizedBox(height: 8.setHeight),
        CommonShadowWidget(
          child: TextFormField(
            controller: controller,
            autofocus: autofocus,
            obscureText: obscureText,
            keyboardType: keyboardType,
            cursorColor: CustomAppColor.of(context).txtBlack,
            style: AppTextStyle.of(context).text14BlackRegular,
            maxLines: maxLines,
            onChanged: onTextChanged,
            readOnly: readOnly,
            onTap: onTap,
            validator: validator ??
                (String? value) {
                  if (value == null || value.isEmpty) {
                    return validatorText;
                  }
                  return null;
                },
            decoration: InputDecoration(
              filled: true,
              fillColor: fillColor ?? CustomAppColor.of(context).textFormFieldColor,
              hintText: hintText,
              hintStyle: AppTextStyle.of(context).text14GrayRegular,
              errorMaxLines: 2,
              errorStyle: AppTextStyle.of(context).text14RedRegular,
              contentPadding: EdgeInsets.only(
                top: 18.setHeight,
                bottom: 18.setHeight,
                left: 20.setWidth,
                right: 20.setWidth,
              ),
              suffixIcon: GestureDetector(
                onTap: onSuffixIconTap,
                child: Padding(
                  padding: EdgeInsets.all(15.setHeight),
                  child: Image.asset(
                    suffixIcon,
                    height: 24.setHeight,
                    width: 24.setWidth,
                    gaplessPlayback: true,
                  ),
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius),
                borderSide: BorderSide(color: borderColor ?? CustomAppColor.of(context).textFormFieldBorderColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius),
                borderSide: BorderSide(color: borderColor ?? CustomAppColor.of(context).textFormFieldBorderColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius),
                borderSide: BorderSide(color: borderColor ?? CustomAppColor.of(context).textFormFieldBorderColor),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius),
                borderSide: BorderSide(color: CustomAppColor.of(context).bgRed),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius),
                borderSide: BorderSide(color: borderColor ?? CustomAppColor.of(context).textFormFieldBorderColor),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius),
                borderSide: BorderSide(color: borderColor ?? CustomAppColor.of(context).bgRed),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CommonTextFormFieldWithPrefixAndSuffix extends StatelessWidget {
  final String hintText;
  final String? validatorText;
  final String? title;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final bool obscureText;
  final bool autofocus;
  final bool readOnly;
  final Color? fillColor;
  final Function(String)? onTextChanged;
  final double radius;
  final int maxLines;
  final Function()? onTap;
  final String? Function(String? value)? validator;
  final Color? borderColor;
  final String prefixIcon;
  final String suffixIcon;
  final Function()? onSuffixIconTap;

  const CommonTextFormFieldWithPrefixAndSuffix({
    super.key,
    required this.controller,
    required this.hintText,
    this.title,
    this.fillColor,
    this.keyboardType,
    this.obscureText = false,
    this.autofocus = false,
    this.readOnly = false,
    this.onTextChanged,
    this.onTap,
    this.radius = 15,
    this.maxLines = 1,
    this.validatorText,
    this.validator,
    this.borderColor,
    required this.prefixIcon,
    required this.suffixIcon,
    this.onSuffixIconTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null) CommonText(text: title ?? "", textStyle: AppTextStyle.of(context).text15BlackBold),
        if (title != null) SizedBox(height: 8.setHeight),
        CommonShadowWidget(
          child: TextFormField(
            controller: controller,
            autofocus: autofocus,
            obscureText: obscureText,
            keyboardType: keyboardType,
            cursorColor: CustomAppColor.of(context).txtBlack,
            style: AppTextStyle.of(context).text14BlackRegular,
            maxLines: maxLines,
            onChanged: onTextChanged,
            readOnly: readOnly,
            onTap: onTap,
            validator: validator ??
                (String? value) {
                  if (value == null || value.isEmpty) {
                    return validatorText;
                  }
                  return null;
                },
            decoration: InputDecoration(
              filled: true,
              fillColor: fillColor ?? CustomAppColor.of(context).textFormFieldColor,
              hintText: hintText,
              hintStyle: AppTextStyle.of(context).text14GrayRegular,
              errorMaxLines: 2,
              errorStyle: AppTextStyle.of(context).text14RedRegular,
              contentPadding: EdgeInsets.only(
                top: 18.setHeight,
                bottom: 18.setHeight,
                left: 20.setWidth,
                right: 20.setWidth,
              ),
              prefixIcon: Padding(
                padding: EdgeInsets.all(15.setHeight),
                child: Image.asset(
                  prefixIcon,
                  height: 24.setHeight,
                  width: 24.setWidth,
                  gaplessPlayback: true,
                ),
              ),
              suffixIcon: GestureDetector(
                onTap: onSuffixIconTap,
                child: Padding(
                  padding: EdgeInsets.all(15.setHeight),
                  child: Image.asset(
                    suffixIcon,
                    height: 24.setHeight,
                    width: 24.setWidth,
                    gaplessPlayback: true,
                  ),
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius),
                borderSide: BorderSide(color: borderColor ?? CustomAppColor.of(context).textFormFieldBorderColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius),
                borderSide: BorderSide(color: borderColor ?? CustomAppColor.of(context).textFormFieldBorderColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius),
                borderSide: BorderSide(color: borderColor ?? CustomAppColor.of(context).textFormFieldBorderColor),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius),
                borderSide: BorderSide(color: CustomAppColor.of(context).bgRed),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius),
                borderSide: BorderSide(color: borderColor ?? CustomAppColor.of(context).textFormFieldBorderColor),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius),
                borderSide: BorderSide(color: borderColor ?? CustomAppColor.of(context).bgRed),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
