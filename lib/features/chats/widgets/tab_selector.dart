import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/utils/color_utils.dart';
import '../controllers/chats_controller.dart';

class TabSelector extends StatelessWidget {
  TabSelector({super.key});

  final List<String> tabs = ['Giddi', 'Dhimman', 'Mudnaan', 'Koox'];
  final ChatsController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 12.h, bottom: 12.h),
      child: SizedBox(
        height: 35.h,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: tabs.length,
          itemBuilder: (context, index) {
            return Obx(() {
              final isSelected = controller.selectedTabIndex.value == index;
              return Builder(
                builder: (context) {
                  final base = Theme.of(context).scaffoldBackgroundColor;
                  final adjusted = adjustColorBrightness(base);
      
                  return GestureDetector(
                    onTap: () => controller.setTab(index),
                    child: Container(
                      margin: EdgeInsets.only(left: (index == 0) ? 16.w : 10.w),
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 8.h,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Theme.of(
                                context,
                              ).colorScheme.outline.withOpacity(0.5)
                            : adjusted,
                        borderRadius: BorderRadius.circular(20.w),
                      ),
                      child: Center(
                        child: Text(
                          tabs[index],
                          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: isSelected
                                ? Theme.of(context).focusColor
                                : Theme.of(context).hintColor,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            });
          },
        ),
      ),
    );
  }
}
