import 'package:flutter/material.dart';
import 'package:taskati2/core/functions/extensions.dart';

import '../styles/appcolor.dart';
import '../styles/text_styles.dart';


class const MainButton({
    super.key, required this.title, required this.ontap,
  }) extends StatelessWidget {
  final String title;
  final Function ()ontap;
 

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: ontap, child: Text(title,style: TextStyles.subtitle.copyWith(
      color: DarkPalette.textPrimary,
    )),
    
    style: ElevatedButton.styleFrom(
    backgroundColor: context.theme.primaryColor,
    minimumSize:  const Size(double.infinity, 50),
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadiusGeometry.circular(10),
    ),
    ),
    
      );
  }
}