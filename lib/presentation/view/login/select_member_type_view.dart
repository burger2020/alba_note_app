import 'package:albanote_project/di/model/member/member_type.dart';
import 'package:albanote_project/presentation/view_model/login/login_page_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

class SelectMemberTypeView extends GetView<LoginPageViewModel> {
  const SelectMemberTypeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('유저 타입 선택')),
      body: Column(
        children: [
          const Text("유저 타입을 선택해 주세요"),
          const SizedBox(height: 30),
          const Text("사장님"),
          ElevatedButton(
              onPressed: () {
                controller.putSelectMemberType(MemberType.BOSS);
              },
              child: const Text("사장님")),
          const SizedBox(height: 30),
          const Text("알바/직원"),
          ElevatedButton(
              onPressed: () {
                controller.putSelectMemberType(MemberType.EMPLOYEE);
              },
              child: const Text("알바/직원")),
        ],
      ),
    );
  }
}
