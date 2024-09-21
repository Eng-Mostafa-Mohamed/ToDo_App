import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/App_Theme.dart';
import 'package:todo_app/core/Page_Rotes_Names.dart';

import '../../core/Settings_Provider.dart';
import '../../core/firebase_utils.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
   bool isobscured = true;
  var formkey=GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    var theme=Theme.of(context);

    var language =AppLocalizations.of(context)!;
    var mediaQuary = MediaQuery.of(context);
    var provider=Provider.of<SettingsProvider>(context);
    return Container(
      decoration:  BoxDecoration(
        color: provider.isDark()? Color(0xFF0B092B): Color(0xFFDFECDB),
        image: const DecorationImage(
            image: AssetImage("assets/images/login_bachground.png"),
            fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title:  Text(
            language.login,
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: mediaQuary.size.height * 0.2,
                  ),
                  Text(
                    language.welcome,
                    style: theme.textTheme.bodyLarge,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: emailController,
                    style: theme.textTheme.bodySmall,
                    decoration: InputDecoration(
                        suffixIcon: Icon(Icons.email,color:provider.isDark()? Colors.white:Colors.black),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                        labelText: language.email,
                        labelStyle: theme.textTheme.bodySmall,
                        hintText: (language.email),
                        hintStyle: theme.textTheme.bodySmall,
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: theme.primaryColor,
                            width: 2,
                          ),
                        ),
                        enabledBorder:
                            const UnderlineInputBorder(borderSide: BorderSide())),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Email is required";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    obscureText: isobscured,
                    controller: passwordController,
                    style: theme.textTheme.bodySmall,
                    decoration: InputDecoration(
                        suffixIcon: InkWell(
                            onTap: (){
                              setState(() {
                                isobscured =!isobscured;
                              });
                            },
                            child: Icon(isobscured ? Icons.visibility : Icons.visibility_off ,
                                color:provider.isDark()? Colors.white:Colors.black),),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                        labelText: language.pass,
                        labelStyle: theme.textTheme.bodySmall,
                        hintText: (language.pass),
                        hintStyle: theme.textTheme.bodySmall,
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: theme.primaryColor,
                            width: 2,
                          ),
                        ),
                        enabledBorder:
                            const UnderlineInputBorder(borderSide: BorderSide())),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, PageRoutesName.registration,);
                      },
                      child: Text(
                        language.forget,
                        style: theme.textTheme.bodySmall,

                      ),
                    ),
                  const SizedBox(height: 20,),
                  FilledButton(
                    style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        )),
                    onPressed: () {
                      if (formkey.currentState!.validate()) {
                       EasyLoading.show();
                       if (formkey.currentState!.validate()) {
                         Firebase_Utls.signIn(emailController.text, passwordController.text).then((value) => {
                           if(value==true){
                             EasyLoading.dismiss(),
                             Navigator.pushNamed(context, PageRoutesName.home)
                           },
                           EasyLoading.dismiss(),
                         });
                       }
                      }
                    },
                    child: Text(
                      language.login,
                      style: theme.textTheme.bodyMedium
                          ?.copyWith(color: Colors.white),
                    ),
                  ),

                  const SizedBox(height: 20,),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, PageRoutesName.registration,);

                    },
                    child: Text(
                      language.createaccount,
                      style: theme.textTheme.bodySmall,

                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
