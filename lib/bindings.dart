import 'dart:ffi';
import 'package:ffi/ffi.dart';

typedef TranslateTextNative = Pointer<Utf8> Function(
    Pointer<Utf8> text, Pointer<Utf8> fromCode, Pointer<Utf8> toCode);
typedef TranslateText = Pointer<Utf8> Function(
    Pointer<Utf8> text, Pointer<Utf8> fromCode, Pointer<Utf8> toCode);

typedef InstallPackageNative = Int32 Function(
    Pointer<Utf8> fromCode, Pointer<Utf8> toCode);
typedef InstallPackage = int Function(
    Pointer<Utf8> fromCode, Pointer<Utf8> toCode);

class ArgosBindings {
  late final DynamicLibrary lib;
  late final TranslateText _translateText;
  late final InstallPackage _installPackage;

  ArgosBindings(String libraryPath) {
    try {
      lib = DynamicLibrary.open(libraryPath);
      _translateText = lib.lookupFunction<TranslateTextNative, TranslateText>(
          'translate_text');
      _installPackage = lib.lookupFunction<InstallPackageNative, InstallPackage>(
          'install_language_package');
    } catch (e) {
      print('Error loading library: $e');
      rethrow;
    }
  }

  String translate(String text, String fromCode, String toCode) {
    final textPtr = text.toNativeUtf8();
    final fromPtr = fromCode.toNativeUtf8();
    final toPtr = toCode.toNativeUtf8();
    
    try {
      final resultPtr = _translateText(textPtr, fromPtr, toPtr);
      final result = resultPtr.toDartString();
      calloc.free(resultPtr);
      return result;
    } finally {
      calloc.free(textPtr);
      calloc.free(fromPtr);
      calloc.free(toPtr);
    }
  }

  Future<int> installPackage(String fromCode, String toCode) async {
    final fromPtr = fromCode.toNativeUtf8();
    final toPtr = toCode.toNativeUtf8();
    
    try {
      return _installPackage(fromPtr, toPtr);
    } finally {
      calloc.free(fromPtr);
      calloc.free(toPtr);
    }
  }
}