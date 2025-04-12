import 'dart:ffi';
import 'package:ffi/ffi.dart';

typedef TranslateTextNative = Pointer<Utf8> Function(
    Pointer<Utf8> text, Pointer<Utf8> fromCode, Pointer<Utf8> toCode);
typedef TranslateText = Pointer<Utf8> Function(
    Pointer<Utf8> text, Pointer<Utf8> fromCode, Pointer<Utf8> toCode);

class ArgosTranslateFFI {
  final DynamicLibrary lib;
  late final TranslateText _translateText;

  ArgosTranslateFFI(String libraryPath) : lib = DynamicLibrary.open(libraryPath) {
    _translateText = lib.lookupFunction<TranslateTextNative, TranslateText>(
        'translate_text');
  }

  String translate(String text, String fromCode, String toCode) {
    final textPtr = text.toNativeUtf8();
    final fromPtr = fromCode.toNativeUtf8();
    final toPtr = toCode.toNativeUtf8();
    
    final resultPtr = _translateText(textPtr, fromPtr, toPtr);
    final result = resultPtr.toDartString();
    
    calloc.free(textPtr);
    calloc.free(fromPtr);
    calloc.free(toPtr);
    calloc.free(resultPtr);
    
    return result;
  }
}