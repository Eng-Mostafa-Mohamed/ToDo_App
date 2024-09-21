import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/App_Theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:todo_app/core/Page_Rotes_Names.dart';
import 'package:todo_app/core/Routes_Generator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:todo_app/core/Settings_Provider.dart';
import 'core/sevices/loading_service.dart';
import 'features/splash_sccreen/Splash_View.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
      ChangeNotifierProvider(
          create: (context) => SettingsProvider(),
          child: const MyApp()));
  configloading();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var provder=Provider.of<SettingsProvider>(context);
    return MaterialApp(
      title: 'To Do App',
      theme: AppThemeManager.lightThemeData,
      darkTheme: AppThemeManager.darkThemeData,
      locale: Locale(provder.currentLanguage),
      debugShowCheckedModeBanner: false,
      initialRoute:PageRoutesName.insial,
      themeMode: (provder.CurrentThemeMode),
      onGenerateRoute: RoutesGenerator.OnGenerateRout,
      builder: EasyLoading.init(),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
        home: const SplashView(),
    );
  }
}
