import 'package:albanote_project/etc/colors.dart';
import 'package:albanote_project/etc/custom_class/base_view.dart';
import 'package:albanote_project/presentation/component/hint_input_box.dart';
import 'package:albanote_project/presentation/view/app/workplace/boss/create_workplace/create_workplace_input_boss_info_view.dart';
import 'package:albanote_project/presentation/view_model/app/workplace/boss/create_workplace_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateWorkplaceView extends BaseView<CreateWorkplaceViewModel> {
  const CreateWorkplaceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildBaseAppBar(
        title: "일터 생성",
        actions: [
          GestureDetector(
            child: const Padding(
                padding: EdgeInsets.all(10.0), child: Center(child: Text("다음", style: TextStyle(color: Colors.black)))),
            onTap: () {
              Get.to(const CreateWorkplaceInputBossInfoView(), binding: BindingsBuilder(() => {Get.put(controller)}));
            },
          )
        ],
      ),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            const Text("일터 정보 입력", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            const Text("직원들이 볼 수 있는 일터 정보를 입력해주세요.", style: TextStyle(fontSize: 15)),
            const SizedBox(height: 30),
            HintInputBox(title: '일터 이름', hintText: '홍길동', onChange: (t) => controller.workplaceName(t)),

            /// 직원 수는 구인구직 업데이트할 때 수집하면 될듯
            // const SizedBox(height: 30),
            // HintInputBox(
            //     controller: controller.controller,
            //     title: '총 직원 수',
            //     subtitle: '일터에서 근무할 전체 직원 수를 입력해 주세요.',
            //     hintText: '홍길동'),
            const SizedBox(height: 30),
            const Text("일터 주소"),
            const SizedBox(height: 10),
            GestureDetector(
              child: TextField(
                enabled: false,
                // readOnly: true,
                cursorColor: MyColors.primary,
                decoration: const InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                  hintText: "주소",
                  disabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 0.5, color: Colors.black)),
                ),
                controller: controller.addressController,
                onChanged: (text) => controller.address(text),
              ),
              onTap: () {
                print("sadfsadfasf");
              },
            ),
            const SizedBox(height: 10),
            TextField(
              cursorColor: MyColors.primary,
              decoration: const InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                  hintStyle: TextStyle(color: Colors.grey),
                  hintText: "상세 주소",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 0.5, color: Colors.black),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: MyColors.primary),
                  )),
              onChanged: (text) => controller.detailAddress(text),
            )
          ],
        ),
      ),
    );
  }
}
