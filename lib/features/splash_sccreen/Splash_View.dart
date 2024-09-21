import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/Page_Rotes_Names.dart';

import '../../core/Settings_Provider.dart';

class SplashView extends StatefulWidget {
  static String routename="SplashView";
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    Timer(const Duration(seconds: 2), () {
     Navigator.pushReplacementNamed(context, PageRoutesName.home);
    },);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<SettingsProvider>(context);
    //var provider = Provider.of<SettingsProvider>(context);
    return Image.asset(
     provider.getsplashviewbackground(),
      fit: BoxFit.cover,);
  }
}
