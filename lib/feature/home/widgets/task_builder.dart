import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:taskati2/core/functions/extensions.dart';
import 'package:taskati2/core/styles/appcolor.dart';
import 'package:taskati2/core/styles/text_styles.dart';
import 'package:taskati2/feature/home/widgets/daily__progress.dart';
import 'package:taskati2/feature/home/widgets/task_list_builder.dart';

class TaskBuilder extends StatefulWidget {
  const new({super.key});

  @override
  State<TaskBuilder> createState() => _TaskBuilderState();
}

class _TaskBuilderState extends State<TaskBuilder>
    with TickerProviderStateMixin {
  int currentindex = 0;
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  String SelectedDate = "";
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        spacing: 15,
        children: [
            Daily_Progress(selecteddate: SelectedDate,),
          DatePicker(
            DateTime.now().subtract(const Duration(days: 3)),
            height: 90,
            width: 70,
            initialSelectedDate: DateTime.now(),
            selectionColor: context.theme.primaryColor,
            selectedTextColor: context.theme.colorScheme.inversePrimary,
            dayTextStyle: TextStyles.title1,
            dateTextStyle: TextStyles.title1,
            monthTextStyle: TextStyles.title1,
            onDateChange: (date) {
              setState(() {
                SelectedDate = DateFormat("dd MMM, yyyy").format(date);
              });
            },
          ),
          
          TabBar(
            controller: _tabController,
            dividerHeight: 0,
            indicator: BoxDecoration(
              color: context.theme.primaryColor,
              borderRadius: BorderRadius.circular(10),
            ),
            indicatorPadding: EdgeInsets.all(0),
            indicatorSize: TabBarIndicatorSize.tab,
            labelPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
            onTap: (value) {
              setState(() {
                currentindex = value;
              });
            },
            tabs: [
              Tab(
                child: CustomTab(
                  label: "All",
                  isSeletced: _tabController.index == 0,
                ),
              ),
              Tab(
                child: CustomTab(
                  label: "In Progress",
                  isSeletced: _tabController.index == 1,
                ),
              ),
              Tab(
                child: CustomTab(
                  label: "Completed",
                  isSeletced: _tabController.index == 2,
                ),
              ),
            ],
          ),
          const Gap(15),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              physics: NeverScrollableScrollPhysics(),
              children: [
                TaskListBuilder(SelectedDate: SelectedDate,taskstatus: .all,),
                TaskListBuilder(SelectedDate: SelectedDate,taskstatus: .inProgress,),
                TaskListBuilder(SelectedDate: SelectedDate,taskstatus: .completed,),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class const CustomTab({
  super.key,
  required this.label,
  required this.isSeletced,
}) extends StatelessWidget {
  final String label;
  final bool isSeletced;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: isSeletced ? context.theme.primaryColor : context.colorScheme.secondary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          label,
          style: TextStyles.body.copyWith(
            fontWeight: .bold,
            color: isSeletced ?context.theme.colorScheme.surfaceContainer : context.theme.primaryColor,
          ),
        ),
      ),
    );
  }
}
