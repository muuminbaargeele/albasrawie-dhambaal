import 'package:albasrawie_dhambaal/features/chats/widgets/custom_select_user_appBar.dart';
import 'package:albasrawie_dhambaal/features/chats/widgets/select_user_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/utils/color_utils.dart';
import '../controllers/chats_controller.dart';
import '../widgets/search_text_field.dart';

class SelectUserScreen extends GetView<GetxController> {
  const SelectUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ChatsController>();
    final base = Theme.of(context).scaffoldBackgroundColor;
    final adjusted = adjustColorBrightness(base);
    bool isNeedTopSafeArea = MediaQuery.of(context).viewPadding.top > 24;

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
            child: Column(
              children: [
                CustomSelectUserAppBar(
                  adjusted: adjusted,
                  isNeedSafeArea: isNeedTopSafeArea,
                  controller: controller,
                ),
                SizedBox(height: 8.h),
                SearchTextField(
                  hintText: "Search Name or email or number",
                  icon: LucideIcons.search,
                  controller: controller.searchController,
                  onChanged: (value) {
                    controller.searchQuery.value = value;
                  },
                ),
                SelectUserContainer(controller: controller),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
