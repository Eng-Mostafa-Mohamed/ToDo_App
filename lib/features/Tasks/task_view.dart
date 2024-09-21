import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/firebase_utils.dart';
import 'package:todo_app/features/Tasks/widgets/task_item_wedgit.dart';
import 'package:todo_app/models/task_model.dart';

import '../../core/App_Theme.dart';
import '../../core/Settings_Provider.dart';

class TaskView extends StatefulWidget {
  const TaskView({super.key});

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  final EasyInfiniteDateTimelineController _controller =
      EasyInfiniteDateTimelineController();
  var _focusDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<SettingsProvider>(context);
    var theme=Theme.of(context);
    var mediaQuary = MediaQuery.of(context);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 40.0),
          child: Stack(
            clipBehavior: Clip.none,
            alignment:  Alignment.bottomCenter,
            children: [
              Container(

                height: mediaQuary.size.height * 0.2,
                width: mediaQuary.size.width,
                color: theme.primaryColor,
                padding: EdgeInsets.only(left: 30, top: 50, right: 30),
                child: Text(
                  "To Do List",
                  style: theme.textTheme.bodyLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 24),
                ),
              ),


              Positioned(
                top: 100,
                child: SizedBox(
                  width: mediaQuary.size.width,
                  child: EasyInfiniteDateTimeLine(
                    timeLineProps: const EasyTimeLineProps(
                      separatorPadding: 15,
                    ),
                    showTimelineHeader: false,
                    dayProps: EasyDayProps(
                      activeDayStyle: DayStyle(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: provider.isDark()? Color(0xFF1B2025) :Colors.white,
                        ),
                        dayStrStyle: theme.textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: theme.primaryColor),
                        monthStrStyle: theme.textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: theme.primaryColor),
                        dayNumStyle: theme.textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: theme.primaryColor),
                      ),
                      inactiveDayStyle: DayStyle(
                          decoration: BoxDecoration(
                              color: provider.isDark()? Color(0xFF1B2025) :Colors.white.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(14)),
                        dayStrStyle: theme.textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: provider.isDark()? Colors.white:Colors.black),
                        monthStrStyle: theme.textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: provider.isDark()? Colors.white:Colors.black),
                        dayNumStyle: theme.textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: provider.isDark()? Colors.white:Colors.black),

                      ),
                      todayStyle: DayStyle(
                          decoration: BoxDecoration(
                              color: provider.isDark()? Color(0xFF1B2025) :Colors.white.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(14)),
                        dayStrStyle: theme.textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: provider.isDark()? Colors.white:Colors.black),
                        monthStrStyle: theme.textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: provider.isDark()? Colors.white:Colors.black),
                        dayNumStyle: theme.textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: provider.isDark()? Colors.white:Colors.black),


                      ),
                    ),
                    controller: _controller,
                    firstDate: DateTime(2024),
                    focusDate: _focusDate,
                    lastDate: DateTime.now().add(Duration(days: 365)),
                    onDateChange: (selectedDate) {
                      setState(() {
                        _focusDate = selectedDate;
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              StreamBuilder <QuerySnapshot<Task_Model>> (
                stream: Firebase_Utls.GetTasksFromFireRealTime(_focusDate),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text("Error: ${snapshot.error}");
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: theme.primaryColor,
                      ),
                    );
                  }
                  List tasks=[];
                   tasks = snapshot.data?.docs.map((e) => e.data()).toList()?? [];

                  return Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) => TaskItemWedgit(
                        task_model: tasks![index],
                      ),
                      itemCount: tasks?.length ?? 0,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
