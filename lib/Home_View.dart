import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'features/Tasks/task_view.dart';
import 'features/Tasks/widgets/add_task_widget.dart';
import 'features/settings/Setttings_View.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  int currentIndex = 0;
 List<Widget> screens=[
   TaskView(),
   SettingView(),
 ];
  @override
  Widget build(BuildContext context) {
    var theme=Theme.of(context);
    var language=AppLocalizations.of(context)!;

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(context: context, builder:(context) => AddTaskWidget(),);
          },
          elevation: 5,
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(

            borderRadius: BorderRadius.circular(50),
            side: BorderSide(width: 2,color: Colors.white)
          ),
          child: CircleAvatar(

            backgroundColor: theme.primaryColor,
            radius: 28,
            child: Icon(Icons.add,size: 35,color: Colors.white,),
          ),
        ),
        body: screens[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
      currentIndex: currentIndex,
        onTap: (value){
        setState(() {
          currentIndex = value;
        });
        },
      items:   [
        BottomNavigationBarItem(

          icon: ImageIcon(AssetImage("assets/icons/Icon awesome-list.png")),
          label: language.tasks ,

        ),
        BottomNavigationBarItem(
          icon: InkWell(child: ImageIcon(AssetImage("assets/icons/Path 7.png"))),
          label: language.settings,
        ),
      ],
    ));
  }
}
