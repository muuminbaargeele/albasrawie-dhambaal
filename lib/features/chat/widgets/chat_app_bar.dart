import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/constants/constants.dart';
import '../../../shared/widgets/cached_circle_image_widget.dart';
import '../controllers/chat_controller.dart';

class ChatAppBar extends StatelessWidget {
  const ChatAppBar({
    super.key,
    required this.adjusted,
    required this.isNeedSafeArea,
    required this.controller,
  });

  final Color adjusted;
  final bool isNeedSafeArea;
  final ChatController controller;

  @override
  Widget build(BuildContext context) {
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: Row(
                            children: [
                              Icon(LucideIcons.chevronLeft),
                              Text("1"),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 16.w),
                      CachedCircleImageWidget(
                        imageUrl:
                            Constants.imagePath +
                            controller.chatMessage!.receiver.image,
                        fallbackText:
                            controller.chatMessage!.receiver.fullName,
                        size: 38,
                      ),
                      SizedBox(width: 12.w),
                      Text(
                        controller.chatMessage!.receiver.fullName,
                        style: Theme.of(context).textTheme.displaySmall,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(LucideIcons.video),
                        padding: EdgeInsets.zero,
                        visualDensity: VisualDensity.compact,
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(LucideIcons.phone),
                        padding: EdgeInsets.zero,
                        visualDensity: VisualDensity.compact,
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
