import 'package:flutter/cupertino.dart';
import 'package:todo_app/Home_View.dart';
import 'package:todo_app/core/Page_Rotes_Names.dart';
import '../features/Registration/Registration_View.dart';
import '../features/login/Login_View.dart';
import '../features/splash_sccreen/Splash_View.dart';


class RoutesGenerator {

static Route<dynamic> OnGenerateRout(RouteSettings settings){
  switch (settings.name) {
    case PageRoutesName.insial:
      return CupertinoPageRoute(builder: (context) => SplashView() ,settings: settings);

    case PageRoutesName.login:
      return CupertinoPageRoute(builder: (context) => LoginView() ,settings: settings);
    case PageRoutesName.registration:
      return CupertinoPageRoute(builder: (context) => RegistrationView() ,settings: settings);
    case PageRoutesName.home:
      return CupertinoPageRoute(builder: (context) => HomeView() ,settings: settings);
    default:
      return CupertinoPageRoute(builder: (context) => SplashView() ,settings: settings);
  }
}
}