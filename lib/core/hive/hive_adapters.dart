import 'package:hive_ce/hive.dart';
import 'package:taskati2/core/models/task_model.dart';
import 'package:taskati2/core/models/user_model.dart';

@GenerateAdapters([AdapterSpec<TaskModel>(), AdapterSpec<UserModel>()])
part 'hive_adapters.g.dart';