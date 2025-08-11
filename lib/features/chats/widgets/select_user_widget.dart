import 'package:albasrawie_dhambaal/data/models/chat/receiver_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/constants/constants.dart';
import '../../../shared/widgets/cached_circle_image_widget.dart';
import '../controllers/chats_controller.dart';

class SelectUserContainer extends StatelessWidget {
  const SelectUserContainer({super.key, required this.controller});

  final ChatsController controller;

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).padding.bottom;
    return Expanded(
      child: SafeArea(
        top: false,
        bottom: bottomInset > 30 ? true : false,
        child: Obx(() {
          final isLoading = controller.isLoading.value;
          final chats = controller.filteredActiveParticipants.toList();
          return controller.allChats.isEmpty && isLoading
              ? Center(
                  child: SizedBox(child: CircularProgressIndicator.adaptive()),
                )
              : controller.allChats.isEmpty
              ? Center(
                  child: SizedBox(
                    child: Text("There is no Active Participants"),
                  ),
                )
              : ListView.builder(
                  itemCount: chats.length,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    final chat = chats[index];
                    final displayName = chat.traineeFullName.isNotEmpty
                        ? chat.traineeFullName
                        : "";
                    final displayImage = chat.imagePath;
                    final email = chat.traineeEmail;
                    final fullName = chat.traineeFullName;
                    final image = chat.imagePath;
                    final phone = chat.traineePhoneNumber;
                    final traineeId = chat.traineeId;

                    final receiver = Receiver(
                      email: email,
                      fullName: fullName,
                      image: image,
                      phone: phone,
                      traineeId: traineeId,
                    );

                    return Builder(
                      builder: (context) {
                        return Column(
                          children: [
                            InkWell(
                              onTap: () {
                                controller.createNewChat(receiver);
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
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CachedCircleImageWidget(
                                      imageUrl:
                                          Constants.imagePath + displayImage,
                                      fallbackText: displayName,
                                    ),
                                    SizedBox(width: 12.w),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          displayName,
                                          style: Theme.of(
                                            context,
                                          ).textTheme.displaySmall,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(height: 4.w),
                                        Text(
                                          email,
                                          style: Theme.of(
                                            context,
                                          ).textTheme.bodySmall,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            if (chats.length > 1)
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
      ),
    );
  }
}
