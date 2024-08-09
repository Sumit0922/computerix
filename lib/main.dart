import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:newsflash/color/theme.dart';
import 'package:newsflash/provider/bubleimage_provider.dart';
import 'package:newsflash/provider/language_provider.dart';
import 'package:newsflash/provider/pickimage_provider.dart';
import 'package:newsflash/provider/textcontroll_provider.dart';
import 'package:newsflash/provider/theme_provider.dart';
import 'package:newsflash/provider/user_provider.dart';
import 'package:newsflash/view/Onboarding.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en', 'US'), Locale('es', 'ES')],
      path: 'assets/translation',
      fallbackLocale: const Locale('en', 'US'),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(),
        ),
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
        ChangeNotifierProvider(create: (_) => PickImageProvider()),
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
        ChangeNotifierProvider(create: (_) => TextProvider()),
        ChangeNotifierProvider(create: (_) => BubbleProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, value, child) => MaterialApp(
          theme: MyTheme().ligthTheme,
          darkTheme: MyTheme().darkTheme,
          themeMode: value.themeValue == true ? ThemeMode.dark : ThemeMode.light,
          debugShowCheckedModeBanner: false,
          locale: context.locale,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          home: OnboardingWrapper(),
        ),
      ),
    );
  }
}
