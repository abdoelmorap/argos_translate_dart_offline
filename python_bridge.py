import argostranslate.package
import argostranslate.translate
from argostranslate.tags import translate_tags
import ctypes
import json
import sys
import argostranslate
from argostranslate import translate
print("Argos Translate imported successfully")


def install_package(from_code, to_code):
    argostranslate.package.update_package_index()
    available_packages = argostranslate.package.get_available_packages()
    package = next(
        filter(
            lambda x: x.from_code == from_code and x.to_code == to_code, available_packages
        )
    )
    argostranslate.package.install_from_path(package.download())

def translate_text(text, from_code, to_code):
    installed_languages = argostranslate.translate.get_installed_languages()
    from_lang = next(filter(lambda x: x.code == from_code, installed_languages))
    to_lang = next(filter(lambda x: x.code == to_code, installed_languages))
    translation = from_lang.get_translation(to_lang)
    return translation.translate(text)

# Create C-compatible function signatures
class ArgosBridge:
    def __init__(self):
        self.lib = ctypes.CDLL('./dlls/argos_bridge.dll')
        
        # Define function signatures
        self.lib.translate_text.argtypes = [ctypes.c_char_p, ctypes.c_char_p, ctypes.c_char_p]
        self.lib.translate_text.restype = ctypes.c_char_p
        
        self.lib.install_language_package.argtypes = [ctypes.c_char_p, ctypes.c_char_p]
        self.lib.install_language_package.restype = None

    def translate(self, text, from_code, to_code):
        return self.lib.translate_text(
            text.encode('utf-8'),
            from_code.encode('utf-8'),
            to_code.encode('utf-8')
        ).decode('utf-8')

    def install_package(self, from_code, to_code):
        self.lib.install_language_package(
            from_code.encode('utf-8'),
            to_code.encode('utf-8')
        )

if __name__ == "__main__":
    bridge = ArgosBridge()
    # Test the functions
    bridge.install_package("en", "es")
    result = bridge.translate("Hello, world!", "en", "es")
    print(result)