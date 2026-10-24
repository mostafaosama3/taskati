import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taskati2/core/constants/appimages.dart';
import 'package:taskati2/core/functions/extensions.dart';
import 'package:taskati2/core/models/task_model.dart';
import 'package:taskati2/core/services/local/hive_provider.dart';
import 'package:taskati2/core/widgets/custom_svg_image.dart';
import 'package:taskati2/core/widgets/custom_textfield.dart';
import 'package:taskati2/core/widgets/main_button.dart';
import 'package:taskati2/core/widgets/my_scaffold.dart';

import '../widgets/date_time_field.dart';

class CreateAndEditTaskScreen extends StatefulWidget {
  CreateAndEditTaskScreen({super.key, this.task});
  final TaskModel? task;
  @override
  State<CreateAndEditTaskScreen> createState() =>
      _CreateAndEditTaskScreenState();
}

class _CreateAndEditTaskScreenState extends State<CreateAndEditTaskScreen> {
  String? selectedDate;
  DateTime? selectedDateValue;
  String? selectedStartTime;
  TimeOfDay? selectedStartTimeValue;
  String? selectedEndTime;
  TimeOfDay? selectedEndTimeValue;
  bool isClicked = false;

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool get isEdit => widget.task != null;
  @override
  void initState() {
    titleController.text = widget.task?.title ?? '';
    descriptionController.text = widget.task?.description ?? '';
    selectedDate = widget.task?.date ?? 'Select Date';
    selectedStartTime = widget.task?.startTime ?? 'Select Time';
    selectedEndTime = widget.task?.endTime ?? 'Select Time';
    super.initState();
  }

  Widget build(BuildContext context) {
    return MyScaffold(
      appBar: AppBar(
        leading: Center(
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: CustomSvgImage(path: AppImages.backSvg, width: 35,color: context.colorScheme.onSurface,),
          ),
        ),
        title: Text(isEdit ? 'Edit Task' : 'Create Task'),
      ),
      body: Form(
        key: formKey,
        autovalidateMode: AutovalidateMode.onUnfocus,
        child: SingleChildScrollView(
          child: Column(
            spacing: 32,
            children: [
              CustomTextField(
                title: 'Title',
                hintText: 'Enter Task Title',
                maxLines: 2,
                controller: titleController,
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return "Please Enter Task Title";
                  return null;
                },
              ),

              CustomTextField(
                title: 'Description',
                hintText: 'Enter Task Description',
                maxLines: 5,
                controller: descriptionController,
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return "Please Enter Task Description";
                  return null;
                },
              ),
              DateTimeField(
                title: "Date",
                subtitle: selectedDate ?? "Select Date",
                leading: AppImages.calendarSvg,
                errorMsg: isClicked && selectedDate == null
                    ? 'Please Select Date'
                    : null,
                onTap: () async {
                  var date = await showDatePicker(
                    context: context,
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(Duration(days: 60)),
                    initialDate: DateTime.now(),
                  );
                  if (date != null) {
                    setState(() {
                      selectedDateValue = date;
                      selectedDate = DateFormat('dd MMM, yyyy').format(date);
                      selectedStartTime = null;
                      selectedStartTimeValue = null;
                      selectedEndTime = null;
                      selectedEndTimeValue = null;
                    });
                  }
                },
              ),
              DateTimeField(
                title: "Start Time",
                subtitle: selectedStartTime ?? "Select Time",
                leading: AppImages.timeSvg,
                errorMsg: isClicked && selectedStartTime == null
                    ? 'Please Select Start Time'
                    : null,
                onTap: () async {
                  final time = await showTimePicker(
                    context: context,
                    initialTime: selectedStartTimeValue ?? TimeOfDay.now(),
                  );
                  if (time != null) {
                    final now = TimeOfDay.now();
                    final isToday =
                        selectedDateValue == null ||
                        DateUtils.isSameDay(selectedDateValue, DateTime.now());
                    if (isToday && _timeInMinutes(time) < _timeInMinutes(now)) {
                      _showTimeError(
                        'Start time cannot be earlier than the current time.',
                      );
                      return;
                    }
                    setState(() {
                      selectedStartTime = time.format(context);
                      selectedStartTimeValue = time;
                      if (selectedEndTimeValue != null &&
                          _timeInMinutes(selectedEndTimeValue!) <=
                              _timeInMinutes(time)) {
                        selectedEndTime = null;
                        selectedEndTimeValue = null;
                      }
                    });
                  }
                },
              ),
              DateTimeField(
                title: "End Time",
                subtitle: selectedEndTime ?? "Select Time",
                leading: AppImages.timeSvg,
                errorMsg: isClicked && selectedEndTime == null
                    ? 'Please Select End Time'
                    : null,
                onTap: () async {
                  if (selectedStartTimeValue == null) {
                    _showTimeError('Select a start time first.');
                    return;
                  }
                  final time = await showTimePicker(
                    context: context,
                    initialTime:
                        selectedEndTimeValue ?? selectedStartTimeValue!,
                  );
                  if (time != null) {
                    if (_timeInMinutes(time) <=
                        _timeInMinutes(selectedStartTimeValue!)) {
                      _showTimeError('End time must be after the start time.');
                      return;
                    }
                    setState(() {
                      selectedEndTime = time.format(context);
                      selectedEndTimeValue = time;
                    });
                  }
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: MainButton(
            title: isEdit ? "Save Changes" : "Add Task",
            ontap: () async {
              setState(() {
                isClicked = true;
              });
              if (formKey.currentState!.validate() &&
                  selectedDate != null &&
                  selectedStartTime != null &&
                  selectedEndTime != null) {
                String key;
                if (isEdit) {
                  key = widget.task?.id ?? '';
                } else {
                  key = DateTime.now().microsecondsSinceEpoch.toString();
                }

                var task = TaskModel(
                  id: key,
                  title: titleController.text,
                  description: descriptionController.text,
                  startTime: selectedStartTime,
                  endTime: selectedEndTime,
                  date: selectedDate,
                  isCompleted: false,
                );
                await HiveProvider.cacheTask(key, task);
                Navigator.pop(context);
              }
            },
          ),
        ),
      ),
    );
  }

  void _showTimeError(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  int _timeInMinutes(TimeOfDay time) => time.hour * 60 + time.minute;
}
