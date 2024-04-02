import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ms/core/component/ms_color.dart';

class MsThemeData with Diagnosticable {
  MsThemeData();

  late TextStyle header;
  late TextStyle title1;
  late TextStyle title2;
  late TextStyle body1;
  late TextStyle body2;
  late TextStyle caption1;
  late TextStyle caption2;

  late TextStyle s10w4SteelGrey;

  late TextStyle s12w4GreyDark;
  late TextStyle s12w4GreyBlur;
  late TextStyle s12w4White;
  late TextStyle s12w4SteelGrey;
  late TextStyle s12w6TextGrey2;
  late TextStyle s12w7TextGreyDark;

  late TextStyle s14w4GreyBlur;
  late TextStyle s14w4GreyBlurHeight;
  late TextStyle s14w4TextGrey1;
  late TextStyle s14w4SteelGrey;
  late TextStyle s14w4TextGuideHeight;
  late TextStyle s14w4White;
  late TextStyle s14w4SteelGreyHeight;
  late TextStyle s14w4Error;
  late TextStyle s14w4Success;
  late TextStyle s14w5BrandVNPT;
  late TextStyle s14w5SteelGrey;
  late TextStyle s14w5GreyBlur;
  late TextStyle s14w5Primary;
  late TextStyle s14w5TextGreyDark;
  late TextStyle s14w5BlackHeight;
  late TextStyle s14w6GreyBlur;
  late TextStyle s14W6GreyBlur;
  late TextStyle s14w6TextGrey2;
  late TextStyle s14w6TextGreyDark;
  late TextStyle s14w6SteelGrey;
  late TextStyle s14w6Primary;
  late TextStyle s14w7TextGreyDark;

  late TextStyle s15w5Primary;
  late TextStyle s15w5White;
  late TextStyle s15w6Primary;
  late TextStyle s15w6GreyBlur;

  late TextStyle s16w4GreyBlur;
  late TextStyle s16w5White;
  late TextStyle s16w6GreyBlur;
  late TextStyle s16w6Primary;
  late TextStyle s16w6RedLight;
  late TextStyle s16w7TextGreyDark;

  late TextStyle s17w4GreyBlur;
  late TextStyle s17w6Black;
  late TextStyle s23w6GreyBlur;
  late TextStyle s30w4TextGreyDark;
  late TextStyle titleBrandMediumBold;

  late TextStyle textLink;
  late TextStyle textFieldLabelHoriz;
  late TextStyle textFieldLabelHorizDisabled;
  late TextStyle textFieldLabelHorizFocused;
  late TextStyle textFieldLabel;
  late TextStyle textFieldLabelDisabled;
  late TextStyle textFieldLabelFocused;
  late TextStyle textFieldText;
  late TextStyle textFieldTextDisabled;
  late TextStyle textFieldHint;
  late TextStyle textFieldHintDisabled;
  late TextStyle textFieldError;
  late TextStyle textFieldErrorDisabled;
  late TextStyle s12w4SteelGreyItalic;

  // Builds the Custom Themes, based on the currently defined based Themes
  // ignore: avoid_unused_constructor_parameters
  factory MsThemeData.fromContext(BuildContext context) {
    // final ThemeData themeData = Theme.of(context);
    final MsThemeData theme = MsThemeData();

    theme.header = const TextStyle(
      fontFamily: 'OLInter',
      fontWeight: FontWeight.w700,
      fontStyle: FontStyle.normal,
      fontSize: 20.0,
      color: MsColors.textGreyDark,
    );

    theme.title1 = theme.header.copyWith(fontSize: 16.0);
    theme.title2 = theme.title1.copyWith(fontWeight: FontWeight.w400);
    theme.body1 = theme.header.copyWith(fontSize: 14.0);
    theme.body2 = theme.body1.copyWith(fontWeight: FontWeight.w400);
    theme.caption1 = theme.header.copyWith(fontSize: 12.0);
    theme.caption2 = theme.caption1.copyWith(fontWeight: FontWeight.w400);

    /// fontSize: 10.0; fontWeight: 400; color: steelGrey ;
    theme.s10w4SteelGrey =
        theme.body2.copyWith(fontSize: 10, color: MsColors.steelGrey);

    /// fontSize: 12.0; fontWeight: 400; color: textGreyDark
    theme.s12w4GreyDark = theme.body2.copyWith(fontSize: 12);

    /// fontSize: 12.0; fontWeight: 400; color: steelGrey ; fontStyle: FontStyle.italic
    theme.s12w4SteelGreyItalic = theme.body2.copyWith(
        fontStyle: FontStyle.italic, color: MsColors.steelGrey, fontSize: 12);

    /// fontSize: 12.0; fontWeight: 400; color: greyBlur
    theme.s12w4GreyBlur =
        theme.s12w4GreyDark.copyWith(color: MsColors.greyBlur);

    /// fontSize: 12.0; fontWeight: 400; color: white ; height: 1.3
    theme.s12w4White =
        theme.body2.copyWith(fontSize: 12, color: MsColors.white, height: 1.3);

    /// fontSize: 12.0; fontWeight: 400; color: steelGrey ;
    theme.s12w4SteelGrey =
        theme.body2.copyWith(fontSize: 12, color: MsColors.steelGrey);

    /// fontSize: 12.0; fontWeight: 600; color: textGrey2;
    theme.s12w6TextGrey2 = theme.body2.copyWith(
        color: MsColors.textGrey2, fontWeight: FontWeight.w600, fontSize: 12);

    /// fontSize: 12.0; fontWeight: 700; color: textGreyDark
    theme.s12w7TextGreyDark = theme.title1.copyWith(fontSize: 12.0);

    /// fontSize: 14.0; fontWeight: 400; color: MsColors.greyBlur
    theme.s14w4GreyBlur =
        theme.title2.copyWith(color: MsColors.greyBlur, fontSize: 14);

    /// fontSize: 14.0; fontWeight: 400; color: MsColors.greyBlur, height: 1.5;
    theme.s14w4GreyBlurHeight = theme.title2
        .copyWith(color: MsColors.greyBlur, fontSize: 14, height: 1.5);

    /// fontSize: 14.0; fontWeight: 400; color: MsColors.textGrey1; (same as theme.body2)
    theme.s14w4TextGrey1 = theme.body2.copyWith(color: MsColors.textGrey1);

    /// fontSize: 14.0; fontWeight: 400; color: MsColors.steelGrey; (same as theme.body2)
    theme.s14w4SteelGrey = theme.body2.copyWith(color: MsColors.steelGrey);

    /// fontSize: 14.0; fontWeight: 400; color: MsColors.error; (same as theme.body2)
    theme.s14w4Error = theme.body2.copyWith(color: MsColors.error);

    /// fontSize: 14.0; fontWeight: 400; color: MsColors.success; (same as theme.body2)
    theme.s14w4Success = theme.body2.copyWith(color: MsColors.success);

    /// fontSize: 14.0; fontWeight: 400; color: MsColors.textGuide; height: 1.5
    theme.s14w4TextGuideHeight =
        theme.body2.copyWith(color: MsColors.textGuide, height: 1.5);

    /// fontSize: 14.0; fontWeight: 400; color: MsColors.steelGrey; height: 1.5
    theme.s14w4SteelGreyHeight =
        theme.body2.copyWith(color: MsColors.steelGrey, height: 1.5);

    /// fontSize: 14.0; fontWeight: 400; color: MsColors.white
    theme.s14w4White = theme.body2.copyWith(color: MsColors.white);

    /// fontSize: 14.0; fontWeight: 500; color: MsColors.brandVNPT
    theme.s14w5BrandVNPT = theme.title1.copyWith(
        color: MsColors.brandVNPT, fontSize: 14, fontWeight: FontWeight.w500);

    /// fontSize: 14.0; fontWeight: 500; color: MsColors.greyBlur
    theme.s14w5GreyBlur = theme.title1.copyWith(
        color: MsColors.greyBlur, fontSize: 14, fontWeight: FontWeight.w500);

    /// fontSize: 14.0; fontWeight: 500; color: MsColors.steelGrey; (same as theme.s14w5BrandVNPT)
    theme.s14w5SteelGrey =
        theme.s14w5BrandVNPT.copyWith(color: MsColors.steelGrey);

    /// fontSize: 14.0; fontWeight: 600; color: MsColors.greyBlur
    theme.s14W6GreyBlur =
        theme.s14w5GreyBlur.copyWith(fontWeight: FontWeight.w600);

    /// fontSize: 14.0; fontWeight: 500; color: MsColors.primary; (same as theme.body1)
    theme.s14w5Primary = theme.body1
        .copyWith(fontWeight: FontWeight.w500, color: MsColors.primary);

    /// fontSize: 14.0; fontWeight: 500; color: (same as theme.header)
    theme.s14w5TextGreyDark = theme.body1.copyWith(fontWeight: FontWeight.w500);

    /// fontSize: 14.0; fontWeight: 500; color: Colors.black; height: 1.5
    theme.s14w5BlackHeight = theme.body1.copyWith(
        color: Colors.black, height: 1.5, fontWeight: FontWeight.w500);

    /// fontSize: 14.0; fontWeight: 600; color: MsColors.actionBackAppbar
    theme.s14W6GreyBlur =
        theme.s14w5GreyBlur.copyWith(fontWeight: FontWeight.w600);

    /// fontSize: 14.0; fontWeight: 600; color: MsColors.primary; (same as theme.body1)
    theme.s14w6Primary = theme.body1
        .copyWith(fontWeight: FontWeight.w600, color: MsColors.primary);

    /// fontSize: 14.0; fontWeight: 600; color: textGrey2
    theme.s14w6TextGrey2 = theme.body2
        .copyWith(color: MsColors.textGrey2, fontWeight: FontWeight.w600);

    /// fontSize: 14.0; fontWeight: 600; color: textGreyDark
    theme.s14w6TextGreyDark = theme.body1.copyWith(fontWeight: FontWeight.w600);

    /// fontSize: 14.0; fontWeight: 600; color: steelGrey
    theme.s14w6SteelGrey =
        theme.s14w6TextGreyDark.copyWith(color: MsColors.steelGrey);

    /// fontSize: 14.0; fontWeight: w600; color: MsColors.greyBlur; (same as theme.s14w4GreyBlur)
    theme.s14w6GreyBlur =
        theme.s14w4GreyBlur.copyWith(fontWeight: FontWeight.w600);

    /// fontSize: 14.0; fontWeight: 700; color: (same as theme.header)
    theme.s14w7TextGreyDark = theme.body1.copyWith(fontWeight: FontWeight.w700);

    /// fontSize: 15.0; fontWeight: 500; color: MsColors.white; (same as theme.s14w5Primary)
    theme.s15w5White =
        theme.s14w5Primary.copyWith(fontSize: 15, color: MsColors.white);

    /// fontSize: 15.0; fontWeight: 500; color: MsColors.primary; (same as theme.s14w5BrandVNPT)
    theme.s15w5Primary =
        theme.s14w5BrandVNPT.copyWith(color: MsColors.primary, fontSize: 15);

    /// fontSize: 15.0; fontWeight: w600; color: MsColors.primary;
    theme.s15w6Primary =
        theme.s15w5Primary.copyWith(fontWeight: FontWeight.w600);

    /// fontSize: 15.0; fontWeight: w600; color: MsColors.greyBlur;
    theme.s15w6GreyBlur =
        theme.s14w6GreyBlur.copyWith(fontWeight: FontWeight.w600);

    /// fontSize: 16.0; fontWeight: 500; color: MsColors.white; (same as theme.title1)
    theme.s16w5White = theme.title1
        .copyWith(color: MsColors.white, fontWeight: FontWeight.w500);

    /// fontSize: 16.0; fontWeight: 600; color: MsColors.primary
    theme.s16w6Primary = theme.title1
        .copyWith(fontWeight: FontWeight.w600, color: MsColors.primary);

    /// fontSize: 16.0; fontWeight: 600; color: MsColors.greyBlur
    theme.s16w6GreyBlur = theme.title1
        .copyWith(fontWeight: FontWeight.w600, color: MsColors.greyBlur);

    /// fontSize: 16.0; fontWeight: 600; color: MsColors.redLight; (same as theme.s16w6Primary)
    theme.s16w6RedLight = theme.s16w6Primary.copyWith(color: MsColors.redLight);

    /// fontSize: 16.0; fontWeight: 700; color: MsColors.textGreyDark
    theme.s16w7TextGreyDark =
        theme.title1.copyWith(color: MsColors.textGreyDark);

    /// fontSize: 17.0; fontWeight: 400; color: Colors.black; (same as theme.title1)
    theme.s17w4GreyBlur = theme.title1.copyWith(
        color: MsColors.greyBlur, fontSize: 17, fontWeight: FontWeight.w400);

    /// fontSize: 17.0; fontWeight: 600; color: Colors.black; (same as theme.title1)
    theme.s17w6Black = theme.title1.copyWith(
        color: Colors.black, fontSize: 17, fontWeight: FontWeight.w600);

    /// fontSize: 23.0; fontWeight: 600; color: greyBlur
    theme.s23w6GreyBlur = theme.body1.copyWith(
        fontSize: 23, fontWeight: FontWeight.w600, color: MsColors.greyBlur);

    /// fontSize: 30.0; fontWeight: 400; color: textGreyDark
    theme.s30w4TextGreyDark = theme.title1.copyWith(fontSize: 30);

    /// fontSize: 16; fontWeight: 400; color: greyBlur
    theme.s16w4GreyBlur = theme.body1.copyWith(
        fontSize: 16, fontWeight: FontWeight.w400, color: MsColors.greyBlur);

    theme.textLink = theme.header.copyWith(
      fontWeight: FontWeight.w600,
      fontSize: 14.0,
      color: MsColors.brandVNPT,
      decoration: TextDecoration.underline,
    );
    theme.textFieldLabelHoriz =
        theme.title2.copyWith(color: MsColors.textGrey3);
    theme.textFieldLabelHorizDisabled =
        theme.textFieldLabelHoriz.copyWith(color: MsColors.textGrey1);
    theme.textFieldLabelHorizFocused =
        theme.textFieldLabelHoriz.copyWith(color: MsColors.brandVNPT);
    theme.textFieldLabel = theme.header.copyWith(
        fontWeight: FontWeight.w600, fontSize: 12.0, color: MsColors.textGrey3);
    theme.textFieldLabelDisabled =
        theme.textFieldLabel.copyWith(color: MsColors.textGrey1);
    theme.textFieldLabelFocused =
        theme.textFieldLabel.copyWith(color: MsColors.brandVNPT, fontSize: 16);
    theme.textFieldText = theme.textFieldLabel.copyWith(
        fontSize: 14.0,
        color: MsColors.textGreyDark,
        fontWeight: FontWeight.w400);
    theme.textFieldTextDisabled = theme.textFieldText
        .copyWith(color: MsColors.textGrey1, fontWeight: FontWeight.w400);
    theme.textFieldHint = theme.textFieldText
        .copyWith(fontWeight: FontWeight.w400, color: MsColors.textGrey2);
    theme.textFieldHintDisabled =
        theme.textFieldHint.copyWith(color: MsColors.textGrey1);
    theme.textFieldError = theme.textFieldLabel
        .copyWith(fontWeight: FontWeight.w400, color: MsColors.error);

    return theme;
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }

    return other is MsThemeData &&
        other.header == header &&
        other.title1 == title1 &&
        other.title2 == title2 &&
        other.body1 == body1 &&
        other.body2 == body2 &&
        other.caption1 == caption1 &&
        other.caption2 == caption2 &&
        other.s12w7TextGreyDark == s12w7TextGreyDark &&
        other.s16w6Primary == s16w6Primary &&
        other.s16w6RedLight == s16w6RedLight &&
        other.s14w4GreyBlur == s14w4GreyBlur &&
        other.s14w6GreyBlur == s14w6GreyBlur &&
        other.s14w5BrandVNPT == s14w5BrandVNPT &&
        other.s16w7TextGreyDark == s16w7TextGreyDark &&
        other.s30w4TextGreyDark == s30w4TextGreyDark &&
        other.s14w5SteelGrey == s14w5SteelGrey &&
        other.s15w5Primary == s15w5Primary &&
        other.s14w5GreyBlur == s14w5GreyBlur &&
        other.s16w6GreyBlur == s16w6GreyBlur &&
        other.s14w4GreyBlurHeight == s14w4GreyBlurHeight &&
        other.s23w6GreyBlur == s23w6GreyBlur &&
        other.s12w4GreyDark == s12w4GreyDark &&
        other.s14w4TextGrey1 == s14w4TextGrey1 &&
        other.s14w5Primary == s14w5Primary &&
        other.s14w5TextGreyDark == s14w5TextGreyDark &&
        other.s15w5White == s15w5White &&
        other.s14w7TextGreyDark == s14w7TextGreyDark &&
        other.s14w5BlackHeight == s14w5BlackHeight &&
        other.s14w4TextGuideHeight == s14w4TextGuideHeight &&
        other.s14w4White == s14w4White &&
        other.s16w5White == s16w5White &&
        other.s17w6Black == s17w6Black &&
        other.s12w4White == s12w4White &&
        other.s14W6GreyBlur == s14W6GreyBlur &&
        other.titleBrandMediumBold == titleBrandMediumBold &&
        other.s14w6TextGrey2 == s14w6TextGrey2 &&
        other.s14w6TextGreyDark == s14w6TextGreyDark &&
        other.s12w6TextGrey2 == s12w6TextGrey2 &&
        other.s12w4GreyBlur == s12w4GreyBlur &&
        other.s14w6Primary == s14w6Primary &&
        other.s12w4SteelGrey == s12w4SteelGrey &&
        other.s10w4SteelGrey == s10w4SteelGrey &&
        other.s14w4SteelGreyHeight == s14w4SteelGreyHeight &&
        other.s14w4Error == s14w4Error &&
        other.s14w4Success == s14w4Success &&
        other.s12w4SteelGreyItalic == s12w4SteelGreyItalic &&
        other.s14W6GreyBlur == s14W6GreyBlur &&
        other.s15w6Primary == s15w6Primary &&
        other.textLink == textLink &&
        other.textFieldLabelHoriz == textFieldLabelHoriz &&
        other.textFieldLabelHorizDisabled == textFieldLabelHorizDisabled &&
        other.textFieldLabelHorizFocused == textFieldLabelHorizFocused &&
        other.textFieldLabel == textFieldLabel &&
        other.textFieldLabelDisabled == textFieldLabelDisabled &&
        other.textFieldLabelFocused == textFieldLabelFocused &&
        other.textFieldText == textFieldText &&
        other.textFieldTextDisabled == textFieldTextDisabled &&
        other.textFieldHint == textFieldHint &&
        other.textFieldHintDisabled == textFieldHintDisabled &&
        other.textFieldError == textFieldError &&
        other.textFieldErrorDisabled == textFieldErrorDisabled &&
        other.s16w4GreyBlur == s16w4GreyBlur;
  }

  @override
  int get hashCode => Object.hashAll([
        header,
        title1,
        title2,
        body1,
        body2,
        caption1,
        caption2,
        s12w7TextGreyDark,
        s16w6Primary,
        s16w6RedLight,
        s14w4GreyBlur,
        s14w6GreyBlur,
        s14w5BrandVNPT,
        s16w7TextGreyDark,
        s30w4TextGreyDark,
        s14w5SteelGrey,
        s15w5Primary,
        s14w5GreyBlur,
        s16w5White,
        s17w6Black,
        s16w6GreyBlur,
        s14w4GreyBlurHeight,
        s23w6GreyBlur,
        s12w4GreyDark,
        s14w4TextGrey1,
        s14w5Primary,
        s14w5TextGreyDark,
        s15w5White,
        s14w7TextGreyDark,
        s14w5BlackHeight,
        s14w4TextGuideHeight,
        s14w4White,
        s12w4White,
        s14W6GreyBlur,
        titleBrandMediumBold,
        s14w6TextGrey2,
        s14w6TextGreyDark,
        s12w6TextGrey2,
        s12w4GreyBlur,
        s14w6Primary,
        s12w4SteelGrey,
        s10w4SteelGrey,
        s14w4SteelGreyHeight,
        s14w4Error,
        s14w4Success,
        s14W6GreyBlur,
        s15w6Primary,
        textLink,
        textFieldLabelHoriz,
        textFieldLabelHorizDisabled,
        textFieldLabelHorizFocused,
        textFieldLabel,
        textFieldLabelDisabled,
        textFieldLabelFocused,
        textFieldText,
        textFieldTextDisabled,
        textFieldHint,
        textFieldHintDisabled,
        textFieldError,
        textFieldErrorDisabled,
        s12w4SteelGreyItalic,
        s16w4GreyBlur,
      ]);
}
