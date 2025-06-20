import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_ko.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ja'),
    Locale('ko'),
    Locale('zh'),
  ];

  /// No description provided for @nav_home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get nav_home;

  /// No description provided for @nav_party.
  ///
  /// In en, this message translates to:
  /// **'Party'**
  String get nav_party;

  /// No description provided for @nav_plaza.
  ///
  /// In en, this message translates to:
  /// **'Plaza'**
  String get nav_plaza;

  /// No description provided for @nav_club.
  ///
  /// In en, this message translates to:
  /// **'Club'**
  String get nav_club;

  /// No description provided for @nav_profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get nav_profile;

  /// No description provided for @home_change_theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get home_change_theme;

  /// No description provided for @home_theme_default.
  ///
  /// In en, this message translates to:
  /// **'Default'**
  String get home_theme_default;

  /// No description provided for @home_theme_1.
  ///
  /// In en, this message translates to:
  /// **'Theme 1'**
  String get home_theme_1;

  /// No description provided for @home_theme_2.
  ///
  /// In en, this message translates to:
  /// **'Theme 2'**
  String get home_theme_2;

  /// No description provided for @home_theme_3.
  ///
  /// In en, this message translates to:
  /// **'Theme 3'**
  String get home_theme_3;

  /// No description provided for @home_theme_4.
  ///
  /// In en, this message translates to:
  /// **'Theme 4'**
  String get home_theme_4;

  /// No description provided for @home_theme_5.
  ///
  /// In en, this message translates to:
  /// **'Theme 5'**
  String get home_theme_5;

  /// No description provided for @home_theme_6.
  ///
  /// In en, this message translates to:
  /// **'Theme 6'**
  String get home_theme_6;

  /// No description provided for @home_change_language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get home_change_language;

  /// No description provided for @home_language_default.
  ///
  /// In en, this message translates to:
  /// **'Default'**
  String get home_language_default;

  /// No description provided for @home_language_zh.
  ///
  /// In en, this message translates to:
  /// **'中文'**
  String get home_language_zh;

  /// No description provided for @home_language_en.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get home_language_en;

  /// No description provided for @home_language_ko.
  ///
  /// In en, this message translates to:
  /// **'한국어'**
  String get home_language_ko;

  /// No description provided for @home_language_ja.
  ///
  /// In en, this message translates to:
  /// **'日本語'**
  String get home_language_ja;

  /// No description provided for @switch_language.
  ///
  /// In en, this message translates to:
  /// **'Select language'**
  String get switch_language;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ja', 'ko', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ja':
      return AppLocalizationsJa();
    case 'ko':
      return AppLocalizationsKo();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
