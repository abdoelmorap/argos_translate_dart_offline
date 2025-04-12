# Argos Translate Dart
[![ko-fi](https://ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/X8X81DBBZ0)

![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)
[![Pub Version](https://img.shields.io/pub/v/argos_translator_offline)](https://pub.dev/packages/argos_translator_offline)

A Flutter package for offline and free automatic translation of localization keys from `.arb` and `.json` files.

## Features

- Offline translation support
- Free to use
- Supports `.arb` and `.json` file formats
- Automatic translation of localization keys
- Cross-platform compatibility

## Prerequisites

1. Install Python (3.7 or higher)
2. Install argos-translate using pip:
```bash
pip install argostranslate
```

For more information about argos-translate, visit:
- [PyPI Package](https://pypi.org/project/argostranslate/)
- [Documentation](https://github.com/argosopentech/argos-translate)

## Installation

Add this package to your `pubspec.yaml` under dev_dependencies:

```yaml
dev_dependencies:
  argos_translator_offline: ^0.0.1
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
- Python 3.7 or higher
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

If you encounter any issues or have questions, please file an issue on the [GitHub repository](https://github.com/abdoelmorap/argos_translator_offline/issues).

## Dependencies

This package uses the following dependencies:
- [ffi](https://pub.dev/packages/ffi) - For foreign function interface
- [path](https://pub.dev/packages/path) - For path manipulation