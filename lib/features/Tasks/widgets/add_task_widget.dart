import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/firebase_utils.dart';
import 'package:todo_app/models/task_model.dart';

import '../../../core/Settings_Provider.dart';

class AddTaskWidget extends StatefulWidget {
  const AddTaskWidget({super.key});

  @override
  State<AddTaskWidget> createState() => _AddTaskWidgetState();
}

var formKey =GlobalKey<FormState>();
class _AddTaskWidgetState extends State<AddTaskWidget> {
  DateTime selecteddate = new DateTime.now();
  TextEditingController descController = TextEditingController();
  TextEditingController titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var language = AppLocalizations.of(context)!;
    var provider=Provider.of<SettingsProvider>(context);

    return Container(
        padding:const EdgeInsets.only(top: 30, right: 20, left: 20, bottom: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color:provider.isDark()? Color(0xFF1B2025): Colors.white,
          border: Border.all(color: Colors.grey),
        ),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
               Text(
                language.addtask,
                textAlign: TextAlign.center,style: TextStyle(
                   color:provider.isDark()? Colors.white: Colors.black
               ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: titleController ,
                style: theme.textTheme.bodySmall,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                    labelText: language.task,
                    labelStyle: theme.textTheme.bodySmall,
                    hintText: (language.task),
                    hintStyle: theme.textTheme.bodySmall,
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: theme.primaryColor,
                        width: 2,
                      ),
                    ),
                    enabledBorder:
                         UnderlineInputBorder(borderSide: BorderSide(color:provider.isDark()? Colors.white: theme.primaryColor,))),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "task is required";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: descController,
                style: theme.textTheme.bodySmall,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                    labelText: language.description,
                    labelStyle: theme.textTheme.bodySmall,
                    hintText: (language.description),
                    hintStyle: theme.textTheme.bodySmall,
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color:provider.isDark()? Colors.white: theme.primaryColor,
                        width: 2,
                      ),
                    ),
                    enabledBorder:
                         UnderlineInputBorder(borderSide: BorderSide(color:provider.isDark()? Colors.white: theme.primaryColor,),)),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return language.description;
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                language.selecttime,
                style: theme.textTheme.bodySmall,
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                  onTap: () {
                    getselcteddate();
                  },
                  child: Text(
                   // DateFormat("dd-MMM-yyyy").format(selecteddate),
                    selecteddate.toString(),
                    style: theme.textTheme.bodySmall,
                    textAlign: TextAlign.center,
                  )),
              Spacer(),
              FilledButton(
                  style:
                      FilledButton.styleFrom(backgroundColor: theme.primaryColor),
                  onPressed: () {

                     if (formKey.currentState!.validate()){
                       var newTask=Task_Model(title: titleController.text, description: descController.text, selected_date: selecteddate);
                       EasyLoading.show();
                       Firebase_Utls.AddTaskToFirestore(newTask).then((value) =>
                       {

                         Navigator.pop(context),
                         EasyLoading.dismiss(),
                       });
                     }

                  },
                  child: Text(language.save,
                      style: theme.textTheme.bodySmall
                          ?.copyWith(color: Colors.white)))
            ],
          ),
        ));
  }

  getselcteddate() async {
    var curuentdate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));
    if (curuentdate != null) {
      setState(() {
        selecteddate = curuentdate;
      });
    }
  }
}
