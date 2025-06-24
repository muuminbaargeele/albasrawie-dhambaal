import 'package:albasrawie_dhambaal/features/home/widgets/search_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../controllers/home_controller.dart';
import '../widgets/chats_widget.dart';
import '../widgets/custom_appBar.dart';
import '../widgets/tab_selector.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomAppBar(
              cameraOnTap: () {},
              searchOnTap: () {},
              dotsOnTap: () {},
            ),
            SearchTextField(
              hintText: "Search",
              icon: LucideIcons.search,
              controller: controller.searchController,
              onChanged: (value) {
                controller.searchQuery.value = value;
              },
            ),
            TabSelector(),
            SizedBox(height: 16.w),
            ChatsContainer(controller: controller),
          ],
        ),
      ),
    );
  }
}
