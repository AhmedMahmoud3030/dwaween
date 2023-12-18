import 'package:dwaween/Test/TestShare.dart';
import 'package:dwaween/core/constants.dart';
import 'package:dwaween/core/help/app_localization/app_local.dart';
import 'package:dwaween/splash_screen/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  //final dir = await path.getApplicationDocumentsDirectory();
  // await Hive.initFlutter('hive_db');
  // (Hive
  //   ..init(dir.path)
  //   ..registerAdapter<Favourite>(FavouriteAdapter())
  //   ..registerAdapter<Notes>(NotesAdapter()));
  //
  // boxFavourite = await Hive.openBox<Favourite>("favouriteBox");
  // boxNotes = await Hive.openBox<Notes>("notesBox");
  // boxSettings = await Hive.openBox<Notes>("settingsBox");
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Dwaween',
        theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromARGB(255, 250, 250, 234),
          fontFamily: 'Cairo',
          colorScheme: ColorScheme.fromSeed(seedColor: Constants.primary),
          textTheme: Theme.of(context).textTheme.apply(
            bodyColor: Color.fromARGB(255, 0, 0, 0),
            displayColor: Color.fromARGB(255, 0, 0, 0),
          ),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        locale: Locale("en"),
        localizationsDelegates: [
          AppLocale.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          Locale("ar",""),
          Locale("en",""),
        ],
        localeResolutionCallback: (currentLocal,supportedLocal){
        },
        // home: TDI()
         home: splash()
        // home: TestShare()
    );
  }
}

