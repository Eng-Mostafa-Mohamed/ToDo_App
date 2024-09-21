import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../core/Settings_Provider.dart';
import '../../../core/firebase_utils.dart';
import '../../../models/task_model.dart';

class TaskItemWedgit extends StatelessWidget {

  final Task_Model task_model;
  const TaskItemWedgit({super.key ,required this.task_model});

  @override
  Widget build(BuildContext context) {
    var theme=Theme.of(context);
    var language=AppLocalizations.of(context)!;
    var provider=Provider.of<SettingsProvider>(context);
    return Container(

      margin: const EdgeInsets.symmetric(horizontal: 15, vertical:10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color:Colors.white,
      ),
      child: Slidable(

        startActionPane: ActionPane(

          motion: const BehindMotion(),
          extentRatio: 0.2,

          dismissible: DismissiblePane(onDismissed: () {}),

          children:  [
            SlidableAction(
              padding: EdgeInsets.zero,
              onPressed: (context) {
                EasyLoading.show();
               Firebase_Utls.DeleteTasksFromFireRealTime(task_model).then((value) => EasyLoading.dismiss());
              },
              borderRadius:  BorderRadius.only(topLeft: Radius.circular(15),bottomLeft:Radius.circular(15) ),
              backgroundColor: Color(0xFFFE4A49),
              foregroundColor: Colors.white,

              icon: Icons.delete,
              label:language.delete,
            ),

          ],
        ),

        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color:provider.isDark()? Color(0xFF1B2025): Colors.white,
          ),
          child: ListTile(
            leading: Container(
              width: 6,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: theme.primaryColor,
              ),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  task_model.title,
                  style: theme.textTheme.bodySmall?.copyWith( fontWeight: FontWeight.bold,  color:task_model.is_completed? Colors.green: theme.primaryColor)
                ),
                Text(
                    task_model.description,
                    style: theme.textTheme.bodySmall?.copyWith( fontWeight: FontWeight.bold,color:task_model.is_completed? Colors.green: Colors.black,fontSize: 12)
                ),

                Row(
                  children: [
                    Icon(Icons.alarm),
                    Text(
                        DateFormat("dd-MM-yyyy").format(task_model.selected_date),
                        style: theme.textTheme.bodySmall?.copyWith( fontWeight: FontWeight.bold ,fontSize: 9)
                    ),
                  ],
                )


              ],
            ),
            trailing:  task_model.is_completed? Text(
                language.save,
                style: theme.textTheme.bodySmall?.copyWith( fontWeight: FontWeight.bold,color: Colors.green)
            ) :Container(
              width: 70,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: theme.primaryColor,
              ),
              child: InkWell(
                   onTap: (){
                     EasyLoading.show();
                    Firebase_Utls.UpdateTask(task_model).then((value) => EasyLoading.dismiss());
                   },
                  child: const Icon( Icons.check,color: Colors.white,)),

            )  ,
          ),
        ),
      ),
    );
  }
}
