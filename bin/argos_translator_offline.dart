import 'dart:io';
import 'dart:convert';
import 'package:argos_translator_offline/argos_translate_dart.dart';
import 'package:path/path.dart' as path;

void main(List<String> args) async {
  try {
    // Parse command-line arguments
    final Map<String, String> params = {};
    for (var arg in args) {
      final split = arg.split('=');
      if (split.length == 2) {
        params[split[0]] = split[1];
      }
    }

    final filePath = params['path'];
    final fromLang = params['from'] ?? 'en';
    final toLang = params['to'] ?? 'ar';

    if (filePath == null) {
      print('❌ Error: Please provide a path to the file using path=...');
      return;
    }

    final extension = path.extension(filePath).toLowerCase();
    final isArb = extension == '.arb';

    final tempDllFile = await ArgosTranslate.findDllPath();
    final dllPath = tempDllFile;
    print('🔄 Loading library from: $dllPath');
    ArgosTranslate.initialize(dllPath);

    // Install language package
    print('🌐 Installing $fromLang → $toLang translation package...');
    await ArgosTranslate.installPackage(fromLang, toLang);
    print('✅ Package installed successfully!');

    // Read file content
    final rawContent = await File(filePath).readAsString();
    final Map<String, dynamic> jsonData = jsonDecode(rawContent);

    // Translate strings
    final Map<String, dynamic> translated = {};
    for (var entry in jsonData.entries) {
      final key = entry.key;
      final value = entry.value;

      // Skip metadata keys in ARB
      if (isArb && key.startsWith('@')) {
        translated[key] = value;
        continue;
      }

      final original = value.toString();
      final translatedText =
          ArgosTranslate.translate(original, fromLang, toLang);
      translated[key] = translatedText;
    }

    // Save translated content
    final outputPath =
        path.join(path.dirname(filePath), 'translated_${toLang}${extension}');
    await File(outputPath).writeAsString(
      JsonEncoder.withIndent('  ').convert(translated),
      flush: true,
    );
    print('✅ Translation saved to $outputPath');

    exit(0);
  } catch (e, stackTrace) {
    print('❌ Error: $e');
    print(stackTrace);
  }
}
