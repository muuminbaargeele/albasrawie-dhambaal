import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../controllers/chat_controller.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({
    super.key,
    required this.adjusted,
    required this.bottomInset,
    required this.adjustedField,
    required this.controller,
    this.onChanged,
  });

  final Color adjusted;
  final double bottomInset;
  final Color adjustedField;
  final ChatController controller;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        color: adjusted,
        // height: 40.h + bottomInset,
        child: Padding(
          padding: EdgeInsets.fromLTRB(0.w, 4.h, 0.w, bottomInset + 4.h),
          child: Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(LucideIcons.plus),
                padding: EdgeInsets.zero,
                visualDensity: VisualDensity.compact,
              ),
              Flexible(
                child: Container(
                  decoration: BoxDecoration(
                    color: adjustedField,
                    borderRadius: BorderRadius.circular(20.w),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4),
                  child: Row(
                    children: [
                      Flexible(
                        child: TextField(
                          controller: controller.messageController,
                          onChanged: onChanged,
                          cursorHeight: 20.0,
                          cursorWidth: 2,
                          textAlignVertical: TextAlignVertical.center,
                          textAlign: TextAlign.left,
                          maxLines: 10,
                          minLines: 1,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                            hintStyle: Theme.of(context).textTheme.bodyLarge,
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            filled: false,
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(vertical: 0),
                          ),
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                      Material(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(20),
                        child: InkWell(
                          onTap: () {},
                          borderRadius: BorderRadius.circular(20),
                          child: Icon(LucideIcons.stickyNote, size: 18.h),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (controller.isSending.value == false)
                IconButton(
                  onPressed: () {},
                  icon: Icon(LucideIcons.camera),
                  padding: EdgeInsets.zero,
                  visualDensity: VisualDensity.compact,
                ),
              if (controller.isSending.value == false)
                IconButton(
                  onPressed: () {},
                  icon: Icon(LucideIcons.mic),
                  padding: EdgeInsets.zero,
                  visualDensity: VisualDensity.compact,
                ),
              if (controller.isSending.value == true)
                Container(
                  height: 30.h,
                  width: 30.w,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 8.w),
                  child: IconButton(
                    onPressed: () {
                      controller.sendMessage();
                      controller.sendMessageWithSocket();
                    },
                    icon: Icon(Icons.send),
                    padding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
