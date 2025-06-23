import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons/lucide_icons.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    required this.cameraOnTap,
    required this.searchOnTap,
    required this.dotsOnTap,
  });

  final VoidCallback cameraOnTap;
  final VoidCallback searchOnTap;
  final VoidCallback dotsOnTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Dhambaal",
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
              color: Theme.of(context).primaryColor,
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: cameraOnTap,
                icon: Icon(LucideIcons.camera),
                padding: EdgeInsets.zero,
                visualDensity: VisualDensity.compact,
              ),
              IconButton(
                onPressed: searchOnTap,
                icon: Icon(LucideIcons.search),
                padding: EdgeInsets.zero,
                visualDensity: VisualDensity.compact,
              ),
              IconButton(
                onPressed: dotsOnTap,
                icon: Icon(LucideIcons.moreVertical),
                padding: EdgeInsets.zero,
                visualDensity: VisualDensity.compact,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
