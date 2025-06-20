import 'package:flutter/material.dart';
import 'app_theme_enum.dart';
import 'light_theme.dart';
import 'dark_theme.dart';
import 'blue_theme.dart';
import 'green_theme.dart';
import 'pink_theme.dart';

final appThemes = <AppTheme, ThemeData>{
  AppTheme.light: lightTheme,
  AppTheme.dark: darkTheme,
  AppTheme.blue: blueTheme,
  AppTheme.green: greenTheme,
  AppTheme.pink: pinkTheme,
};


@immutable
class CustomColors extends ThemeExtension<CustomColors> {
  final Color brand;
  final Color warning;

  const CustomColors({required this.brand, required this.warning});

  @override
  CustomColors copyWith({Color? brand, Color? warning}) {
    return CustomColors(
      brand: brand ?? this.brand,
      warning: warning ?? this.warning,
    );
  }

  @override
  CustomColors lerp(ThemeExtension<CustomColors>? other, double t) {
    if (other is! CustomColors) return this;
    return CustomColors(
      brand: Color.lerp(brand, other.brand, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
    );
  }
}

extension CustomThemeContext on BuildContext {
  /// 使用 `context.colors.brand` 获取自定义颜色
  CustomColors get colors {
    final ext = Theme.of(this).extension<CustomColors>();
    assert(ext != null, 'CustomColors not found on ThemeData');
    return ext!;
  }
}