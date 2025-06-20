enum AppTheme {
  light,
  dark,
  blue,
  green,
  pink,
}
extension AppThemeName on AppTheme {
  String get label {
    switch (this) {
      case AppTheme.light:
        return 'Light';
      case AppTheme.dark:
        return 'Dark';
      case AppTheme.blue:
        return 'Blue';
      case AppTheme.green:
        return 'Green';
      case AppTheme.pink:
        return 'Pink';
    }
  }
}
