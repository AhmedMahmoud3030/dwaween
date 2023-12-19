import 'package:dwaween/features/Base/provider.dart';
import 'package:dwaween/features/Dwaween/provider.dart';
import 'package:dwaween/features/Home/provider.dart';
import 'package:dwaween/features/Splash/splash.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    EasyLocalization(
      child: MyApp(),
      supportedLocales: [
        Locale('en'),
        Locale('ar'),
      ],
      startLocale: Locale('ar'),
      path: 'assets/lang',
      fallbackLocale: Locale('ar'),
      useOnlyLangCode: true,
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => BaseProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => HomeProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => DwaweenProvider(),
        )
      ],
      child: MaterialApp(
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          EasyLocalization.of(context)!.delegate,
        ],
        supportedLocales: EasyLocalization.of(context)!.supportedLocales,
        locale: EasyLocalization.of(context)!.locale,
        debugShowCheckedModeBanner: false,
        home: Splash(),
      ),
    );
  }
}
