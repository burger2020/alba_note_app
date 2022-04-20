import 'package:albanote_project/di/model/member/member_type.dart';
import 'package:albanote_project/etc/custom_class/base_view.dart';
import 'package:albanote_project/presentation/view_model/login/login_page_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectMemberTypeView extends BaseView<LoginPageViewModel> {
  const SelectMemberTypeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('회원가입', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        leading: GestureDetector(
            onTap: () => Get.back(), child: const Icon(Icons.arrow_back_ios_rounded, color: Colors.black)),
        elevation: 0,
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 40, left: 20),
              child: Text("회원의 종류를 선택해 주세요", style: TextStyle(fontSize: 22)),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 40.0, left: 20, right: 20),
              child: Text("사장님 회원가입을 통해\n일터와 직원을 한번에 관리도 하고\n사장님끼리 커뮤니티로 소통도 할 수 있어요.", style: TextStyle(fontSize: 17)),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: const Color(0xfffdae06), elevation: 0),
                  child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.0),
                      child: Text("사장님", style: TextStyle(fontSize: 18, color: Colors.white))),
                  onPressed: () {
                    showAlertDialog(
                      title: "회원 종류 선택",
                      content: "사장님으로 회원가입을 선택했어요.\n회원 종류는 바꿀 수 없습니다.\n가입하시겠어요?",
                      setOnPositiveListener: () {
                        controller.putSelectMemberType(MemberType.BOSS);
                      },
                    );
                  }),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 40.0, left: 20, right: 20),
              child: Text("직원/알바생 회원가입을 통해\n근태와 급여를 한번에 관리도 하고\n직원/알바생끼리 커뮤니티로 소통도 할 수 있어요!",
                  style: TextStyle(fontSize: 17)),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: const Color(0xfffdae06), elevation: 0),
                  onPressed: () {
                    showAlertDialog(
                      title: "회원 종류 선택",
                      content: "직원/알바생으로 회원가입을 선택했어요.\n회원 종류는 바꿀 수 없습니다.\n가입하시겠어요?",
                      setOnPositiveListener: () {
                        controller.putSelectMemberType(MemberType.EMPLOYEE);
                      },
                    );
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                    child: Text("알바/직원", style: TextStyle(fontSize: 18, color: Colors.white)),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
