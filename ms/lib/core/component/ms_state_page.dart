import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ms/core/component/ms_theme.dart';


enum MsStatePageType {
  EMPTY_DATA,

}

class MsStatePage extends StatelessWidget {
  const MsStatePage({
    Key? key,
    this.type = MsStatePageType.EMPTY_DATA,
    this.title,
    this.desc,
    this.titleStyle,
    this.descStyle,
  }) : super(key: key);

  factory MsStatePage.fromError(dynamic error, {TextStyle? titleStyle, TextStyle? descStyle}) {
    return MsStatePage(
      type: MsStatePageType.EMPTY_DATA,
      title: "Không có dữ liệu",
      desc: error.toString(),
      titleStyle: titleStyle,
      descStyle: descStyle,
    );
  }

  factory MsStatePage.empty({String? title, String? error, TextStyle? titleStyle, TextStyle? descStyle}) {
    return MsStatePage(
      title: title ?? "Không có dữ liệu",
      desc: error,
      titleStyle: titleStyle,
      descStyle: descStyle,
    );
  }

  final MsStatePageType type;
  final String? title;
  final String? desc;
  final TextStyle? titleStyle;
  final TextStyle? descStyle;

  Widget _getWidgetByPageType(MsStatePageType pageType) {
    switch (pageType) {
      case MsStatePageType.EMPTY_DATA:
        return SvgPicture.asset('assets/icon/ic_empty_data.svg');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _getWidgetByPageType(type),
          const SizedBox(height: 20),
          if (title?.isNotEmpty ?? false)
            SelectableText(
              title!,
              style: titleStyle ?? MsTheme.of(context).title1,
              textAlign: TextAlign.center,
            ),
          if (desc?.isNotEmpty ?? false)
            SelectableText(
              desc!,
              style: descStyle ?? MsTheme.of(context).body2,
              textAlign: TextAlign.center,
            ),
        ],
      ),
    );
  }
}
