import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:taskati2/core/constants/appimages.dart';
import 'package:taskati2/core/functions/Navigations.dart';
import 'package:taskati2/core/functions/extensions.dart';
import 'package:taskati2/core/services/local/hive_provider.dart';
import 'package:taskati2/core/styles/text_styles.dart';
import 'package:taskati2/core/widgets/my_scaffold.dart';
import 'package:taskati2/feature/home/page/home_screen.dart';
import 'package:taskati2/feature/upload/upload_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
  bool userHasData=HiveProvider.getData(HiveProvider.Kimage)!=null;
   Future.delayed(const Duration(seconds: 5), () {
    if(userHasData){
      pushReplacement(context, HomeScreen());
    }
    else{
      pushReplacement(context, const UploadScreen());
    }});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(AppImages.logoLottie, width: 250),
            const Gap(16),
            Text(
              'Taskati',
              style: TextStyles.headline2.copyWith(fontWeight: FontWeight.w500),
            ),
            const Gap(8),
            Text(
              'It\'s time to get organized',
              style: TextStyles.body.copyWith(
                fontWeight: FontWeight.normal,
                color: context.colorScheme.tertiary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}