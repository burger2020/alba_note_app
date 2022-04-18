import 'package:albanote_project/di/model/member/member_type.dart';
import 'package:albanote_project/etc/custom_class/base_view.dart';
import 'package:albanote_project/presentation/view/app/workplace/boss_workplace.dart';
import 'package:albanote_project/presentation/view/app/workplace/employee_workplace.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../view_model/app/app_view_model.dart';

class AppView extends BaseView<AppViewModel> {
  const AppView({Key? key}) : super(key: key);

  Future<void> setupInteractedMessage() async {
    // 앱이 종료된 상태에서 푸시 알림 클릭하여 열릴 경우 메세지 가져옴
    RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();

    // 종료상태에서 클릭한 푸시 알림 메세지 핸들링
    if (initialMessage != null) _handleMessage(initialMessage);

    // 앱이 백그라운드 상태에서 푸시 알림 클릭 하여 열릴 경우 메세지 스트림을 통해 처리
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  // fcm 메세지 핸들링
  void _handleMessage(RemoteMessage message) {
    print('${message.notification!.title}');
    if (message.data['type'] == 'chat') {
      Get.toNamed('/chat', arguments: message.data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return progressWidget(
      child: Obx(
        () => Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            currentIndex: controller.pageIndex.value,
            elevation: 0,
            onTap: controller.changeBottomNave,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.work),
                label: 'home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.chat),
                label: 'home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.notifications),
                label: 'home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.more_horiz),
                label: 'home',
              ),
            ],
          ),
          body: IndexedStack(
            index: controller.pageIndex.value,
            children: [
              if (controller.getMemberType() == MemberType.BOSS) const BossWorkplace() else const EmployeeWorkplace(),
              const Center(),
              const Center(),
              const Center()
            ],
          ),
        ),
      ),
    );
  }
}
