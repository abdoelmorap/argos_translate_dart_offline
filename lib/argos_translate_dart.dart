import 'dart:io';
import 'package:package_config/package_config.dart';
import 'bindings.dart';

/// A class that provides offline translation capabilities using the Argos Translate library.
///
/// This class serves as the main interface for translating text between different languages
/// using the Argos Translate library. It handles initialization, translation, and package
/// installation for language pairs.
class ArgosTranslate {
  static late ArgosBindings _bindings;

  /// Initializes the Argos Translate library with the specified DLL path.
  ///
  /// This method must be called before using any translation functionality.
  ///
  /// [libraryPath] - The path to the Argos Translate DLL file.
  static void initialize(String libraryPath) async {
    _bindings = ArgosBindings(libraryPath);
  }

  /// Translates text from one language to another.
  ///
  /// [text] - The text to translate.
  /// [fromCode] - The source language code (e.g., 'en' for English).
  /// [toCode] - The target language code (e.g., 'ar' for Arabic).
  ///
  /// Returns the translated text as a String.
  static String translate(String text, String fromCode, String toCode) {
    return _bindings.translate(text, fromCode, toCode);
  }

  /// Installs a language package for translation between two languages.
  ///
  /// [fromCode] - The source language code (e.g., 'en' for English).
  /// [toCode] - The target language code (e.g., 'ar' for Arabic).
  ///
  /// Throws an exception if the package installation fails.
  static Future<void> installPackage(String fromCode, String toCode) async {
    final result = await _bindings.installPackage(fromCode, toCode);
    if (result != 0) {
      throw Exception(
          'Failed to install language package from $fromCode to $toCode');
    }
  }

  /// Finds the DLL in the current directory or its subdirectories
  static Future<String> findDllPath() async {
    // Get the package root directory
    final packageConfig = await findPackageConfig(Directory.current);
    final package = packageConfig?.packages
        .firstWhere((p) => p.name == 'argos_translator_offline');

    if (package == null) {
      throw Exception('Package not found!');
    }

    // Get the package directory
    final packageDir = Directory(package.root.path);
    String path = packageDir.path;
    if (path[0] == "/") {
      path = path.substring(1);
    }

    final dllPath = "${path}dlls/argos_bridge.dll".replaceAll("/", "\\");

    if (File(dllPath).existsSync()) {
      return dllPath;
    }

    throw Exception(
        'Could not find argos_bridge.dll in the dlls directory where $dllPath');
  }
}
