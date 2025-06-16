import 'package:de_errand/utils/sizer_utils.dart';
import 'package:flutter/material.dart';

import '../../utils/app_assets.dart';
import '../../utils/app_constant.dart';
import '../interfaces/top_bar_click_listener.dart';
import '../utils/app_color.dart';
import '../utils/app_text_style.dart';
import 'common_text.dart';

class TopBar extends StatelessWidget {
  const TopBar(
    this.clickListener, {
    super.key,
    this.title,
    this.isShowBack = true,
  });

  final String? title;
  final bool isShowBack;
  final TopBarClickListener clickListener;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Container(
        padding: EdgeInsets.only(left: 15.setWidth, right: 15.setWidth, top: 15.setHeight),
        color: CustomAppColor.of(context).transparent,
        alignment: Alignment.center,
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (isShowBack) ...{
              Align(
                alignment: Alignment.centerLeft,
                child: InkWell(
                  onTap: () {
                    clickListener.onTopBarClick(AppConstant.strBack);
                  },
                  child: Image.asset(
                    AppAssets.icBack,
                    height: 45.setHeight,
                    width: 45.setWidth,
                    gaplessPlayback: true,
                  ),
                ),
              ),
              SizedBox(width: 15.setWidth),
            },
            if (title != null) ...{
              CommonText(
                text: title ?? "",
                textStyle: AppTextStyle.of(context).text20BlackBold,
                textAlign: TextAlign.center,
              ),
            },
          ],
        ),
      ),
    );
  }
}
