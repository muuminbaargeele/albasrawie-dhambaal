import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../core/constants/constants.dart';
import '../../../core/utils/time_utils.dart';
import '../../../shared/widgets/cached_circle_image_widget.dart';
import '../controllers/home_controller.dart';

class ChatsContainer extends StatelessWidget {
  const ChatsContainer({super.key, required this.controller});

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Obx(() {
        final chats = controller.filteredChats;
        return controller.allChats.isEmpty
            ? Center(child: SizedBox(child: CircularProgressIndicator.adaptive()))
            : ListView.builder(
                itemCount: chats.length,
                itemBuilder: (context, index) {
                  final chat = chats[index];
                  final displayName = chat.receiverFullName.isNotEmpty
                      ? chat.receiverFullName
                      : chat.senderFullName;
                  final displayImage = chat.receiverImage;
                  final messagePreview = chat.content ?? "No messages yet";

                  return Builder(
                    builder: (context) {
                      return InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(
                            16.w,
                            (index == 0) ? 20.h : 8,
                            16.w,
                            8.h,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CachedCircleImageWidget(
                                imageUrl: Constants.imagePath + displayImage,
                                fallbackText: displayName,
                              ),
                              SizedBox(width: 12.w),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: 240.w,
                                          child: Text(
                                            displayName,
                                            style: Theme.of(
                                              context,
                                            ).textTheme.displaySmall,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Text(
                                          formatChatTimestamp(
                                            chat.sentAt ??
                                                '2025-06-17T13:11:32.407056',
                                          ),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall
                                              ?.copyWith(
                                                color: Theme.of(
                                                  context,
                                                ).colorScheme.secondary,
                                              ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 4.h),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              LucideIcons.checkCheck,
                                              size: 17.w,
                                              color: Theme.of(
                                                context,
                                              ).hintColor,
                                            ),
                                            SizedBox(width: 4.w),
                                            SizedBox(
                                              width: 240.w,
                                              child: Text(
                                                messagePreview,
                                                style: Theme.of(
                                                  context,
                                                ).textTheme.bodySmall,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                        // RoundedCountBadge(text: '1'),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              );
      }),
    );
  }
}
