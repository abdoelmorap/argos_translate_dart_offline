# Argos Translate Dart
[![ko-fi](https://ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/X8X81DBBZ0)

![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)
[![Pub Version](https://img.shields.io/pub/v/argos_translator_offline)](https://pub.dev/packages/argos_translator_offline)

A Flutter package for offline and free automated translation of localization keys from `.arb` and `.json` files.

## Features

- Offline translation support
- Free to use
- Supports `.arb` and `.json` file formats
- Automatic translation of localization keys
- Cross-platform compatibility

## Prerequisites

1. Install Python (3.7 or higher) - Recommended to use Python 3.11 which it's latest supported one for  sentencepiece & argostranslate
[Download Python 3.11](https://www.python.org/downloads/release/python-3110/) 
2. Install argos-translate using pip:
```bash
pip install sentencepiece  
pip install argostranslate    
```

For more information about argos-translate, visit:
- [PyPI Package](https://pypi.org/project/argostranslate/)
- [Documentation](https://github.com/argosopentech/argos-translate)

## Installation

Add this package to your `pubspec.yaml` under dev_dependencies:

```yaml
dev_dependencies:
  argos_translator_offline: ^1.2.0
```

Then run:

```bash
flutter pub get
```

## Usage

Run the translation command with the following format:

```bash
dart run argos_translator_offline path=<path_to_your_file> from=<source_language> to=<target_language>
```

Example:
```bash
dart run argos_translator_offline path=test/lang/lang.arb from=en to=ar
```

This will translate your localization file from English to Arabic.

## Requirements

- Dart SDK >= 3.0.0
- Flutter SDK (latest version recommended)
- Python 3.7 or higher - Recommended to use Python 3.11 which it's latest supported one for  sentencepiece & argostranslate
  [Download Python 3.11](https://www.python.org/downloads/release/python-3110/)
- [argos-translate](https://pypi.org/project/argostranslate/) Python package


## Project Structure

```
├── bin/          # Command-line application entrypoint
├── lib/          # Library code
├── test/         # Unit tests
├── dlls/         # Dynamic link libraries
└── venv/         # Python virtual environment
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Author

- **Abdelrahman Tolba**
  - Email: AbdelrahmanTolba@protonmail.com
  - Website: https://abdelrhmantolba.online

## Support

If you encounter any issues or have questions, please file an issue on the [GitHub repository](https://github.com/abdoelmorap/argos_translate_dart_offline/issues).

## Dependencies

This package uses the following dependencies:
- [ffi](https://pub.dev/packages/ffi) - For foreign function interface
- [path](https://pub.dev/packages/path) - For path manipulation



## API Documentation

The package provides the following public API members:

### ArgosTranslate Class

The main class that provides offline translation capabilities.

#### Methods

- `initialize(String libraryPath)`: Initializes the Argos Translate library with the specified DLL path.
  ```dart
  ArgosTranslate.initialize('path/to/argos_bridge.dll');
  ```

- `translate(String text, String fromCode, String toCode)`: Translates text from one language to another.
  ```dart
  String translated = ArgosTranslate.translate('Hello', 'en', 'ar');
  ```

- `installPackage(String fromCode, String toCode)`: Installs a language package for translation between two languages.
  ```dart
  await ArgosTranslate.installPackage('en', 'ar');
  ```

### Documentation Requirements

When contributing to this package, please ensure all public API members are properly documented. The package uses the `public_member_api_docs` lint rule to enforce documentation standards. Each public member should include:

- A clear description of its purpose
- Parameter descriptions with examples
- Return value descriptions where applicable
- Exception information where relevant

Example of proper documentation:
```dart
/// Translates text from one language to another.
///
/// [text] - The text to translate.
/// [fromCode] - The source language code (e.g., 'en' for English).
/// [toCode] - The target language code (e.g., 'ar' for Arabic).
///
/// Returns the translated text as a String.
static String translate(String text, String fromCode, String toCode)
```