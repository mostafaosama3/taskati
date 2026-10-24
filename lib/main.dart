import 'package:flutter/material.dart';
import 'package:hive_ce/hive.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:taskati2/core/services/local/hive_provider.dart';
import 'package:taskati2/core/styles/themes.dart';
import 'package:taskati2/feature/splash/splash_screen.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveProvider.init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  ValueListenableBuilder(
      valueListenable: HiveProvider.userbox.listenable(),
      builder: (context, value, child) {

        bool isDark=HiveProvider.getData(HiveProvider.KIsdark) ?? false;
      
      return MaterialApp(
        debugShowCheckedModeBanner: false,
       themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
        theme:AppThemes.lightTheme,
        darkTheme: AppThemes.darkTheme,
        home: SplashScreen(),
      );
      },
    );
  }
}
