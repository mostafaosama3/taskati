import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hive_ce/hive.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:taskati2/core/functions/extensions.dart';
import 'package:taskati2/core/models/task_model.dart';
import 'package:taskati2/core/services/local/hive_provider.dart';
import 'package:taskati2/core/styles/appcolor.dart';
import 'package:taskati2/core/styles/text_styles.dart';

class const Daily_Progress({super.key, required this.selecteddate}) extends StatelessWidget {
  final String selecteddate;
  @override
  Widget build(BuildContext context) {
     return ValueListenableBuilder<Box<TaskModel>>(
      valueListenable: HiveProvider.taskbox.listenable(),
      builder: (context, box, _) {
        // 1) get all tasks by selected date
        final tasks = box.values
            .where((task) => task.date == selecteddate)
            .toList();

        final total = tasks.length;
        final completed = tasks
            .where((task) => task.isCompleted == true)
            .length;
        final progress = total > 0 ? completed / total : 0.0;

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: context.theme.primaryColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      DateFormat('EE, dd MMM').format(DateTime.now()),
                      style: TextStyles.body.copyWith(
                        color: context.colorScheme.secondary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Gap(10),
                    Text(
                      total == 0
                          ? 'No tasks for this day'
                          : '$completed / $total tasks completed',
                      style: TextStyles.body.copyWith(
                        color: DarkPalette.textPrimary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(10),
              Stack(
                alignment: Alignment.center,
                children: [
                  CircularProgressIndicator(
                    constraints: BoxConstraints.tightFor(width: 70, height: 70),
                    value: progress,
                    strokeWidth: 6,
                    color: DarkPalette.textPrimary,
                    backgroundColor: context.theme.hoverColor,
                    strokeCap: StrokeCap.round,
                  ),
                  Text(
                    '${(progress * 100).toInt()}%',
                    style: TextStyles.body.copyWith(
                      color: DarkPalette.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}