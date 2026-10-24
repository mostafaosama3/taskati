import 'package:flutter/material.dart';
import 'package:taskati2/core/constants/appimages.dart';
import 'package:taskati2/core/functions/extensions.dart';
import 'package:taskati2/core/styles/appcolor.dart';
import 'package:taskati2/core/styles/text_styles.dart';
import 'package:taskati2/core/widgets/custom_svg_image.dart';

class DateTimeField extends StatelessWidget {
  const new({
    super.key,
    required this.leading,
    required this.title,
    required this.subtitle,
    required this.onTap,
    required this.errorMsg,
  });
  final String leading;
  final String title;
  final String subtitle;
  final String? errorMsg;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        boxShadow: context.isDark?[]: [
          BoxShadow(
            color: context.colorScheme.secondary,
            blurRadius: 20,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Material(
        color: context.theme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(14),
        clipBehavior: Clip.antiAlias,
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          leading: CustomSvgImage(path: leading),
          title: Text(
            title,
            style: TextStyles.caption2.copyWith(color: context.colorScheme.tertiary),
          ),
          subtitle: Text(
            errorMsg ?? subtitle,
            style: TextStyles.body.copyWith(
              fontWeight:
                  errorMsg != null ? FontWeight.normal : FontWeight.w500,
              fontSize: errorMsg != null ? 12 : 16,
              color: errorMsg != null
                  ? LightPalette.redColor
                  :  context.colorScheme.onSurface,
            ),
          ),
          trailing: CustomSvgImage(
            path: AppImages.downSvg,
            color: context.theme.colorScheme.onSurface,
          ),
          onTap: onTap,
        ),
      ),
    );
  }
}
