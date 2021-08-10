import 'package:get/get.dart';
import 'package:rooj/helpers/Language/ar.dart';
import 'package:rooj/helpers/Language/en.dart';

class Messages extends Translations {
  @override
  Map<String, Map<String, String>> get keys =>
      {'ar': getArabicLanguage(), 'en': getEnglishLanguage()};
}
