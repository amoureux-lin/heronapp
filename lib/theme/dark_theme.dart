import 'package:flutter/material.dart';

import 'app_themes.dart';

final darkTheme = ThemeData.dark().copyWith(
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
  //自定义扩展
  extensions: const [
    CustomColors(
        brand: Colors.teal,
        warning: Colors.orange
    ),
  ],
);
