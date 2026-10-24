import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:lottie/lottie.dart';
import 'package:taskati2/core/constants/appimages.dart';
import 'package:taskati2/core/models/task_model.dart';
import 'package:taskati2/core/models/task_status_enum.dart';
import 'package:taskati2/core/services/local/hive_provider.dart';
import 'package:taskati2/core/styles/text_styles.dart';
import 'task_card_slidable.dart';


class const TaskListBuilder({
    super.key, required this.SelectedDate, required this.taskstatus,
  }) extends StatelessWidget {
  final String SelectedDate;
  final TaskStatusEnum taskstatus;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<TaskModel>>(
      valueListenable:HiveProvider.taskbox.listenable(),
      builder: (context, box, Widget) {
          var tasks = box.values.toList();

        List<TaskModel> selectedTasks = [];
         for (var task in tasks) {
          if (task.date == SelectedDate) {
             // filter tasks by taskStatus
            if(taskstatus== TaskStatusEnum.all){
             selectedTasks.add(task);
            }
           else if (taskstatus== TaskStatusEnum.inProgress&&task.isCompleted==false){
            selectedTasks.add(task);
           }
           else if (taskstatus== TaskStatusEnum.completed&&task.isCompleted==true){
            selectedTasks.add(task);
           }
          }
        }
         if(selectedTasks.isEmpty){
          return Column(
            children: [
              Lottie.asset(AppImages.emptyLottie,width: 300),
              const Gap(10),
              Text("No Tasks For Today",style: TextStyles.body,)
            ],
          );
        }
        else{
       return ListView.separated(
        itemBuilder: (context, index) => TaskCardSlidable(taskModel: selectedTasks[index],),
        separatorBuilder: (context, index) => const Gap(15),
        itemCount: selectedTasks.length,
      );
        }
      },
       
    );
  }
}
