import 'package:flutter/material.dart';

class CommonText extends StatelessWidget {
  final String text;
  final int? maxLines;
  final TextAlign textAlign;
  final TextStyle textStyle;

  const CommonText({
    super.key,
    required this.text,
    required this.textStyle,
    this.maxLines,
    this.textAlign = TextAlign.center,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: textStyle,
    );
  }
}
