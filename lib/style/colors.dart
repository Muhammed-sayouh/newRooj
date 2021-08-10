import 'package:flutter/material.dart';

class AppColors {
  static final Color mainColor = Color(getColorHexFromStr('#DD9985'));
  static final Color textFieldIconBackColor =
      Color(getColorHexFromStr('#FBF3F1'));
  static final Color cardTitleColor = Color(getColorHexFromStr('#535353'));
  static final Color menuBackGround = Color(getColorHexFromStr('#FEDBD0'));
  static final Color menuBackGround2 = Color.fromRGBO(254, 210, 208, 1);
  static final Color pinColor = Color(getColorHexFromStr('#F8EFED'));
  static final Color secondaryTextColorBackColor =
      Color(getColorHexFromStr('#818181'));
  static final Color iconBackgroundColor = Color(getColorHexFromStr('#d1dede'));
  static final Color badgeColor = Color(getColorHexFromStr('#51DEB3'));
  static final Color badgeTextColor = Color(getColorHexFromStr('#20AF85'));
  static final Color mainColor1 = Color(getColorHexFromStr('#4ED9B1'));
  static final Color mainColor2 = Color(getColorHexFromStr('#45C6A9'));
  static final Color mainColor3 = Color(getColorHexFromStr('#3DB3A2'));
  static final Color mainColor4 = Color(getColorHexFromStr('#2D9195'));
  static final Color mainColor5 = Color(getColorHexFromStr('#23788B'));
  static final Color mainColor6 = Color(getColorHexFromStr('#155B7F'));
  static final Color mainColor7 = Color(getColorHexFromStr('#0F4C7A'));
  static final Color mainColor8 = Color(getColorHexFromStr('#043871'));
  static final Color flatOkButtonColor = Color(getColorHexFromStr('#40B874'));
  static final Color flatCancelButtonColor =
      Color(getColorHexFromStr('#FF0000'));
  static final Color noActiveColor = Color(getColorHexFromStr('#C8C8C8'));
  static final Color activeColor = Color(getColorHexFromStr('#2A988F'));
  static final Color starColor = Color(getColorHexFromStr('#FFF700'));
  static final Color smallBoxColor = Color(getColorHexFromStr('#F5F5F5'));
  static final Color languageItemColor = Color(getColorHexFromStr('#F8F9FB'));
  static final Color activeIndecatorColor =
      Color(getColorHexFromStr('#08FF00'));
  static final Color notActiveIndecatorColor =
      Color(getColorHexFromStr('#AEAEAE'));
  static final Color secondaryColor = Color(getColorHexFromStr('#F4F2F3'));
  static final Color backGroundColor = Color(getColorHexFromStr('#FFFFFF'));
  static final Color mainBackGroundColor = Color(getColorHexFromStr('#F8F9FB'));
  static final Color addressCardBackGroundColor =
      Color(getColorHexFromStr('#F8F9FB'));
  static final Color addressTitleColor = Color(getColorHexFromStr('#2A988F'));
  static final Color deleteAddressButtonColor =
      Color(getColorHexFromStr('#FF4849'));
  static final Color mainDropDownColor = Color(getColorHexFromStr('#F4F2F3'));
  static final Color mainTextColor = Color(getColorHexFromStr('#252324'));
  static final Color greyTextColor = Color(getColorHexFromStr('#C8C8C8'));
  static final Color mainButtonColor = Color(getColorHexFromStr('#2A988F'));
  static final Color oddCardColor = Color(getColorHexFromStr('#EEFDF1'));
  static final Color evenCardColor = Color(getColorHexFromStr('#FFFFFF'));
  static final Color radioButtonColor = Color(getColorHexFromStr('#27AE49'));

  //BADGE COLORS
  static final Color goldBadgeColor = Color(getColorHexFromStr('#F1C304'));
  static final Color silverBadgeColor = Color(getColorHexFromStr('#C3C1C2'));
  static final Color titaniumBadgeColor = Color(getColorHexFromStr('#7D5300'));
}

int getColorHexFromStr(String colorStr) {
  colorStr = 'FF' + colorStr;
  colorStr = colorStr.replaceAll('#', '');
  var val = 0;
  var len = colorStr.length;
  for (var i = 0; i < len; i++) {
    var hexDigit = colorStr.codeUnitAt(i);
    if (hexDigit >= 48 && hexDigit <= 57) {
      val += (hexDigit - 48) * (1 << (4 * (len - 1 - i)));
    } else if (hexDigit >= 65 && hexDigit <= 70) {
      val += (hexDigit - 55) * (1 << (4 * (len - 1 - i)));
    } else if (hexDigit >= 97 && hexDigit <= 102) {
      val += (hexDigit - 87) * (1 << (4 * (len - 1 - i)));
    } else {
      throw FormatException('An error occurred when converting a color');
    }
  }
  return val;
}
