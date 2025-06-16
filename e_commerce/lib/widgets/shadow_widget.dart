import 'package:flutter/material.dart';

import '../utils/app_color.dart';

class CommonShadowWidget extends StatefulWidget {
  final double? radius;
  final Color? color;
  final double? blurRadius;
  final double? spreadRadius;
  final Offset? offset;
  final Widget child;

  const CommonShadowWidget({super.key, this.radius, this.color, this.blurRadius, this.spreadRadius, this.offset, required this.child});

  @override
  State<CommonShadowWidget> createState() => _CommonShadowWidgetState();
}

class _CommonShadowWidgetState extends State<CommonShadowWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.radius ?? 15),
        boxShadow: [
          BoxShadow(
            color: (widget.color ?? CustomAppColor.of(context).textFormFieldShadowColor).withValues(alpha: .07),
            blurRadius: widget.blurRadius ?? 50,
            spreadRadius: widget.spreadRadius ?? 0,
            offset: widget.offset ?? Offset(12, 26),
          ),
        ],
      ),
      child: widget.child,
    );
  }
}
