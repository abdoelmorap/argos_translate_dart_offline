import 'bindings.dart';

class ArgosTranslate {
  static late ArgosBindings _bindings;

  static void initialize(String libraryPath) async{
    _bindings = ArgosBindings(libraryPath);
  }

  static String translate(String text, String fromCode, String toCode) {
    return _bindings.translate(text, fromCode, toCode);
  }

  static Future<void> installPackage(String fromCode, String toCode) async {
    final result = await _bindings.installPackage(fromCode, toCode);
    if (result != 0) {
      throw Exception('Failed to install language package from $fromCode to $toCode');
    }
  }
}