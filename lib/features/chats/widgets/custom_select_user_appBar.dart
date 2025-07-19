import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../controllers/chats_controller.dart';

class CustomSelectUserAppBar extends StatelessWidget {
  const CustomSelectUserAppBar({
    super.key,
    required this.adjusted,
    required this.isNeedSafeArea,
    required this.controller,
  });

  final Color adjusted;
  final bool isNeedSafeArea;
  final ChatsController controller;

  @override
  Widget build(BuildContext context) {
    final userLength = controller.activeParticipants.length;
    return Container(
      color: adjusted,
      height: isNeedSafeArea ? 102.h : 82.h,
      child: Padding(
        padding: EdgeInsets.fromLTRB(7.w, 0, 16.w, 4.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Flexible(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Material(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                    child: InkWell(
                      onTap: () {
                        controller.searchController.clear();
                        Get.back();
                      },
                      borderRadius: BorderRadius.circular(20),
                      child: Row(children: [Icon(LucideIcons.chevronLeft)]),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Select User",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Text(
                        "$userLength Users",
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Theme.of(context).textTheme.bodyLarge!.color,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
