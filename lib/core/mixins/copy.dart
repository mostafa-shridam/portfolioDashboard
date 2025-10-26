import 'package:flutter/services.dart';

mixin CopyMixin {
  void copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
  }
}
