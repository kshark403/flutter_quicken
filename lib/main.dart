// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_scale/app_router.dart';
import 'package:flutter_scale/provider/locale_provider.dart';
import 'package:flutter_scale/provider/theme_provider.dart';
import 'package:flutter_scale/themes/styles.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// Logger
final logger = Logger(
  printer: PrettyPrinter(
    methodCount: 1,
    colors: true,
    printEmojis: true,
    printTime: false,
  )
);

// Test Logger
void testLogger() {
  logger.v('Verbose log');
  logger.d('Debug log');
  logger.i('Info log');
  logger.w('Warning log');
  logger.e('Error log');
  logger.wtf('What a terrible failure log');
}

var initRoute;
var locale;
ThemeData? themeData;
var isDark;

void main() async {
  // testLogger();

  WidgetsFlutterBinding.ensureInitialized(); // ต้องเรียกใช้เพื่อให้ SharedPreferences ทำงานได้

  // Create SharedPreferences instance
  SharedPreferences prefs = await SharedPreferences.getInstance();

  // อ่านค่า step จาก SharedPreference
  if(prefs.getInt('step') == null) {
    initRoute = AppRouter.welcome;
  } else if(prefs.getInt('step') == 1) {
    initRoute = AppRouter.login;
  } else if(prefs.getInt('step') == 2) {
    initRoute = AppRouter.dashboard;
  }else {
    initRoute = AppRouter.welcome;
  }

  // Set default locale from SharedPreference
  String? languageCode = prefs.getString('languageCode');
  locale = Locale(languageCode ?? 'en');

  // Set default theme from SharedPreference
  isDark = prefs.getBool('isDark') ?? false;
  themeData = isDark == true && isDark != null ? AppTheme.darkTheme : AppTheme.lightTheme;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LocaleProvider(locale),
        ),
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(themeData!, isDark!),
        ),
      ],
      child: Consumer2<LocaleProvider, ThemeProvider>(
        builder: (context, locale, theme, child){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: locale.locale,
            theme: theme.getTheme(),
            initialRoute: initRoute,
            routes: AppRouter.routes,
          );
        }
      ),
    );
  }
}
