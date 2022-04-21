import 'package:albanote_project/etc/colors.dart';
import 'package:albanote_project/etc/custom_class/base_view.dart';
import 'package:albanote_project/presentation/component/hint_input_box.dart';
import 'package:albanote_project/presentation/view/app/workplace/boss/create_workplace/commute_range_set_view.dart';
import 'package:albanote_project/presentation/view/app/workplace/boss/create_workplace/create_workplace_input_boss_info_view.dart';
import 'package:albanote_project/presentation/view_model/app/workplace/boss/create_workplace_view_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// 일터 생성 일터 정보 입력 화면
class CreateWorkplaceView extends BaseView<CreateWorkplaceViewModel> {
  const CreateWorkplaceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildBaseAppBar(
        title: "일터 생성",
        actions: [
          Obx(() {
            var enable = false;
            if (controller.workplaceName.value.length > 1 &&
                controller.workplaceAddress.value.length > 1 &&
                controller.workplaceDetailAddress.value.isNotEmpty) {
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
                const SizedBox(height: 20),
                const Text("일터 정보 입력", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                const Text("직원들이 볼 수 있는 일터 정보를 입력해주세요.", style: TextStyle(fontSize: 14)),
                const SizedBox(height: 40),
                TitleTextField(title: '일터 이름', hintText: '홍길동', onChange: (t) => controller.workplaceName(t)),

                /// 직원 수는 구인구직 업데이트할 때 수집하면 될듯
                // const SizedBox(height: 30),
                // HintInputBox(
                //     controller: controller.controller,
                //     title: '총 직원 수',
                //     subtitle: '일터에서 근무할 전체 직원 수를 입력해 주세요.',
                //     hintText: '홍길동'),
                const SizedBox(height: 30),
                const Text("일터 주소", style: TextStyle(fontSize: 14)),
                const SizedBox(height: 10),
                GestureDetector(
                  child: TextField(
                    style: const TextStyle(fontSize: 14),
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
                    onChanged: (text) => controller.workplaceAddress(text),
                  ),
                  onTap: () {
                    print("주소 선택 화면");
                  },
                ),
                const SizedBox(height: 10),
                TextField(
                  style: const TextStyle(fontSize: 14),
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
                  onChanged: (text) => controller.workplaceDetailAddress(text),
                ),
                const SizedBox(height: 30),
                const Text('출퇴근 기록 방식', style: TextStyle(fontSize: 14)),
                const SizedBox(height: 10),
                const Text('직원들의 출퇴근 범위 지정을 할 수 있어요.', style: TextStyle(fontSize: 13, color: Colors.grey)),
                // const Text('출퇴근은 와이파이 기기 지정과 출퇴근 범위 지정을 할 수 있습니다.', style: TextStyle(fontSize: 13, color: Colors.grey)),
                const SizedBox(height: 10),
                Column(
                  children: [
                    Row(
                      children: [
                        // GestureDetector(
                        //   child: Container(
                        //     decoration: BoxDecoration(
                        //         borderRadius: const BorderRadius.all(Radius.circular(4)),
                        //         border: Border.all(color: MyColors.primary)),
                        //     child: const Padding(
                        //       padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
                        //       child: Text("와이파이 지정", style: TextStyle(color: MyColors.primary, fontSize: 14)),
                        //     ),
                        //   ),
                        //   onTap: () {
                        //     showSnackBar('와이파이 지정');
                        //   },
                        // ),
                        // const SizedBox(width: 20),
                        GestureDetector(
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(Radius.circular(4)),
                                border: Border.all(color: MyColors.primary)),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
                              child: Text("출퇴근 범위 지정", style: TextStyle(color: MyColors.primary, fontSize: 14)),
                            ),
                          ),
                          onTap: () {
                            Get.to(const CommuteRangeSetView(), binding: BindingsBuilder(() {
                              Get.put(controller);
                            }));
                          },
                        )
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      alignment: Alignment.topLeft,
                      decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Obx(() {
                        return !controller.isCommuteRangeSet.value
                            ? Container()
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CachedNetworkImage(
                                      width: 100,
                                      height: 100,
                                      httpHeaders: const {
                                        'X-NCP-APIGW-API-KEY-ID': 'crnxxhqxtl',
                                        'X-NCP-APIGW-API-KEY': 'DsAciH7GOMUnrM3JuuV4E6uXMFIGaNMScdoZRgfy'
                                      },
                                      imageUrl:
                                          'https://naveropenapi.apigw.ntruss.com/map-static/v2/raster?w=200&h=200&'
                                          'center=${controller.selectCoordinate.value.longitude},${controller.selectCoordinate.value.latitude}&'
                                          'level=16&scale=1&markers=type:a|size:mid|color:orange|pos:${controller.selectCoordinate.value.longitude}%20${controller.selectCoordinate.value.latitude}'),
                                  const SizedBox(width: 10),
                                  Text(
                                    "출퇴근 가능 범위 - ${controller.selectRadius}m",
                                    style: const TextStyle(color: Colors.black87),
                                  )
                                ],
                              );
                      }),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
