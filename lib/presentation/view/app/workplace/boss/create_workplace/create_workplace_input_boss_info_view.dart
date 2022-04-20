import 'package:albanote_project/etc/colors.dart';
import 'package:albanote_project/etc/custom_class/base_view.dart';
import 'package:albanote_project/presentation/component/hint_input_box.dart';
import 'package:albanote_project/presentation/view_model/app/workplace/boss/create_workplace_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateWorkplaceInputBossInfoView extends BaseView<CreateWorkplaceViewModel> {
  const CreateWorkplaceInputBossInfoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildBaseAppBar(
        title: "일터 생성",
        leadIcon: Icons.arrow_back_ios_rounded,
        actions: [
          Obx(() {
            var enable = false;
            if (controller.bossName.value.length > 1 &&
                controller.bossRankName.value.length > 1 &&
                controller.bossPhoneNumber.value.length > 11) {
              enable = true;
            }
            return enable
                ? GestureDetector(
                    child: const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Center(child: Text("다음", style: TextStyle(fontSize: 15, color: MyColors.primary)))),
                    onTap: () {
                      Get.to(const CreateWorkplaceInputBossInfoView(),
                          binding: BindingsBuilder(() => {Get.put(controller)}));
                    },
                  )
                : const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Center(child: Text("다음", style: TextStyle(fontSize: 15, color: Colors.grey))));
          })
        ],
      ),
      body: disallowIndicatorWidget(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                const Text("사장님 정보 입력", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                const Text(
                  "직원들이 볼 수 있는 사장님의 정보를 입력해주세요.",
                  style: TextStyle(fontSize: 15),
                ),
                const SizedBox(height: 30),
                HintInputBox(title: '이름', hintText: '홍길동', onChange: (text) => controller.bossName(text)),
                const SizedBox(height: 20),
                HintInputBox(title: '직책 이름', hintText: '사장님', onChange: (text) => controller.bossRankName(text)),
                const SizedBox(height: 20),
                HintInputBox(
                  title: '전화번호',
                  hintText: '010-0000-0000',
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.done,
                  onChange: (t) => controller.bossPhoneNumber(t),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
