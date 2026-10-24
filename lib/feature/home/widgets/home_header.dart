import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:taskati2/core/functions/extensions.dart';
import 'package:taskati2/core/services/local/hive_provider.dart';
import 'package:taskati2/core/styles/text_styles.dart';

class HomeHeader extends StatefulWidget {
  const HomeHeader({super.key});

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  String image = '';
  String name = '';

  @override
  void initState() {
    image = HiveProvider.getData(HiveProvider.Kimage) ?? '';
    name = HiveProvider.getData(HiveProvider.Kname) ?? 'User';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (image.isNotEmpty)
          ClipOval(
            child: Image.file(
              File(image),
              height: 50,
              width: 50,
              fit: BoxFit.cover,
            ),
          ),
        const Gap(10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Hello!", style: TextStyles.caption1),
              Text(
                name,
                style: TextStyles.subtitle,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ), 
            ],
          ),
        ),
        const Gap(10),
              IconButton(   icon:  Icon(Icons.dark_mode_rounded,color: context.theme.colorScheme.onSurface,),
          onPressed: () {
            bool isDark = HiveProvider.getData(HiveProvider.KIsdark) ?? false;
            HiveProvider.cacheData(HiveProvider.KIsdark, !isDark);
          },
        ),
      ],
    );
  }
}