import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../core/constants/constants.dart';
import '../../../core/utils/time_utils.dart';
import '../../../shared/widgets/cached_circle_image_widget.dart';
import '../controllers/home_controller.dart';
import 'search_text_field.dart';
import 'tab_selector.dart';

class ChatsContainer extends StatelessWidget {
  const ChatsContainer({super.key, required this.controller});

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Obx(() {
        final chats = controller.filteredChats;
        return controller.allChats.isEmpty
            ? Center(
                child: SizedBox(child: CircularProgressIndicator.adaptive()),
              )
            : ListView.builder(
                itemCount: chats.length + 2,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return SearchTextField(
                      hintText: "Search",
                      icon: LucideIcons.search,
                      controller: controller.searchController,
                      onChanged: (value) {
                        controller.searchQuery.value = value;
                      },
                    );
                  }
                  if (index == 1) {
                    return TabSelector();
                  }
                  final chat = chats[index - 2];
                  final displayName = chat.receiver.fullName.isNotEmpty
                      ? chat.receiver.fullName
                      : chat.sender.fullName;
                  final displayImage = chat.receiver.image;
                  final messagePreview = chat.chat.isNotEmpty
                      ? chat.chat[0].content
                      : "Dhambaal cusub dir.";
                  final statusIcon =
                      chat.chat.isNotEmpty &&
                          chat.chat[0].status != null &&
                          chat.chat[0].senderId == controller.user!.traineeId
                      ? switch (chat.chat[0].status) {
                          'sent' => LucideIcons.check,
                          'delivered' || 'seen' => LucideIcons.checkCheck,
                          _ => null,
                        }
                      : null;

                  final statusIconColor =
                      chat.chat.isNotEmpty && chat.chat[0].status != null
                      ? switch (chat.chat[0].status) {
                          'seen' => Theme.of(context).scaffoldBackgroundColor,
                          'delivered' || 'sent' => Theme.of(context).hintColor,
                          _ => null,
                        }
                      : null;

                  return Builder(
                    builder: (context) {
                      return Column(
                        children: [
                          InkWell(
                            onTap: () {
                              controller.navigateToChat(chat);
                            },
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(
                                16.w,
                                8.h,
                                16.w,
                                8.h,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CachedCircleImageWidget(
                                    imageUrl:
                                        Constants.imagePath + displayImage,
                                    fallbackText: displayName,
                                  ),
                                  SizedBox(width: 12.w),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
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
                                              chat.chat.isNotEmpty &&
                                                      chat.chat[0].sentAt !=
                                                          null
                                                  ? formatChatTimestamp(
                                                      chat.chat[0].sentAt!,
                                                    )
                                                  : formatChatTimestamp(
                                                      chat.createdAt,
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
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                if (statusIcon != null)
                                                  Icon(
                                                    statusIcon,
                                                    size: 17.w,
                                                    color: statusIconColor,
                                                  ),
                                                if (statusIcon != null)
                                                  SizedBox(width: 4.w),
                                                SizedBox(
                                                  width: 240.w,
                                                  child: Text(
                                                    messagePreview?.replaceAll(
                                                          '\n',
                                                          ' ',
                                                        ) ??
                                                        "",
                                                    style: Theme.of(
                                                      context,
                                                    ).textTheme.bodySmall,
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
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
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(76.w, 0, 16.w, 0),
                            child: Container(
                              height: 0.2,
                              width: double.infinity,
                              color: Theme.of(context).hintColor,
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              );
      }),
    );
  }
}
