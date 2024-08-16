import 'package:anchor_app/app/localization/hindi/hn_in_translations.dart';
import 'package:get/get.dart';
import 'en_us/en_us_translations.dart';

class AppLocalization extends Translations {

  static Map<String, Map<String, String>> translationsKeys = {
    "en_US": enUs,
    "hi": hi,
  };


  @override
  Map<String, Map<String, String>> get keys => {'en_US': enUs, 'hi' : hi};
}
