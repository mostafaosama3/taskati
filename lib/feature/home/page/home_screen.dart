import 'dart:io';

import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hive_ce/hive.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:taskati2/core/constants/appimages.dart';
import 'package:taskati2/core/functions/Navigations.dart';
import 'package:taskati2/core/functions/extensions.dart';
import 'package:taskati2/core/services/local/hive_provider.dart';
import 'package:taskati2/core/styles/appcolor.dart';
import 'package:taskati2/core/styles/text_styles.dart';
import 'package:taskati2/core/widgets/my_scaffold.dart';
import 'package:taskati2/feature/create_task/page/create_task_screen.dart';
import 'package:taskati2/feature/home/widgets/task_builder.dart';

import '../widgets/daily__progress.dart';
import '../widgets/home_header.dart';
import '../widgets/task_builder.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var box = Hive.box('userBox');
  int currentindex = 0;
  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      body: DefaultTabController(
        length: 3,
        child: Column(
          spacing: 20,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            HomeHeader(),
          
            TaskBuilder(),
          ],
        ),
      ),
floatingActionButton: FloatingActionButton(onPressed: (){
  pushTo(context, CreateAndEditTaskScreen());
},
shape: CircleBorder(),
backgroundColor: context.theme.primaryColor,
child: Icon(Icons.add,color: LightPalette.background,size:28,),
),
    );
  }
}

