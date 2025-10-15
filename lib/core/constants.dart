import 'package:flutter/material.dart';

void unfocusCurrent() => FocusManager.instance.primaryFocus?.unfocus();

const supportedLocales = [Locale('en'), Locale('ar')];
const translationsPath = 'assets/translations';
