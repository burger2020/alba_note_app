import 'package:albanote_project/domain/model/coordinate_model.dart';
import 'package:albanote_project/etc/colors.dart';
import 'package:albanote_project/etc/custom_class/base_view.dart';
import 'package:albanote_project/presentation/view_model/app/workplace/boss/create_workplace_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:get/get.dart';

/// 출퇴근 범위 지정
class CommuteRangeSetView extends BaseView<CreateWorkplaceViewModel> {
  const CommuteRangeSetView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NaverMapController? naverMapController;
    final List<int> radiusList = [25, 50, 75, 100, 150];

    return Scaffold(
      appBar: buildBaseAppBar(title: '출퇴근 위치 지정', leadIcon: Icons.arrow_back_ios_rounded),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(
            () => Stack(alignment: Alignment.center, children: [
              Text(controller.selectLocationOverlay.string, style: const TextStyle(color: Colors.white)),
              Container(
                color: Colors.grey,
                width: Get.width,
                height: Get.height / 2,
                child: NaverMap(
                  initialCameraPosition: CameraPosition(
                    target: controller.selectCoord.value.latitude == null
                        ? const LatLng(37.566570, 126.978442)
                        : LatLng(controller.selectCoord.value.latitude!, controller.selectCoord.value.longitude!),
                    zoom: 17,
                  ),
                  locationButtonEnable: true,
                  indoorEnable: true,
                  maxZoom: 18,
                  minZoom: 11,
                  onMapCreated: (controller) {
                    naverMapController = controller;
                  },
                  useSurface: kReleaseMode,
                  logoClickEnabled: false,
                  circles: controller.selectLocationOverlay,
                ),
              ),

              /// 가운데 핀
              const Padding(
                padding: EdgeInsets.only(bottom: 50.0),
                child: Icon(Icons.location_on, size: 50, color: MyColors.primary),
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: GestureDetector(
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(100)),
                          color: Colors.white,
                          border: Border.all(color: Colors.grey, width: 0.5)),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                        child: Text("현재 위치 지정", style: TextStyle(color: MyColors.primary, fontSize: 13)),
                      ),
                    ),
                    onTap: () async {
                      /// 현재 위치 지정 바튼 클릭
                      var position = await naverMapController!.getCameraPosition();
                      var circleOverlay = CircleOverlay(
                        radius: controller.selectRadius.value.toDouble(),
                        color: Colors.black12,
                        center: position.target,
                        overlayId: '1212',
                      );
                      controller.selectLocationOverlay([circleOverlay]);
                      var zoom = 17.0;
                      switch (controller.selectRadius.value) {
                        case 25:
                          zoom = 17;
                          break;
                        case 50:
                          zoom = 16.5;
                          break;
                        case 75:
                          zoom = 16;
                          break;
                        case 100:
                          zoom = 15.5;
                          break;
                        case 150:
                          zoom = 15;
                          break;
                      }
                      var cameraUpdate = CameraUpdate.zoomTo(zoom);
                      naverMapController?.moveCamera(cameraUpdate, animationDuration: 300);
                    },
                  ),
                ),
              ),
            ]),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('출퇴근 가능 범위(반지름)', style: TextStyle(fontSize: 14)),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black), borderRadius: BorderRadius.circular(4)),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SizedBox(
                          child: Obx(
                            () => DropdownButton<int>(
                                isDense: true,
                                elevation: 1,
                                underline: Container(),
                                style: const TextStyle(color: Colors.black),
                                value: controller.selectRadius.value,
                                items: radiusList.map((e) {
                                  return DropdownMenuItem(value: e, child: Text('${e}m'));
                                }).toList(),
                                onChanged: (value) {
                                  controller.selectRadius(value);
                                }),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          Expanded(child: Container()),
          Center(
            child: GestureDetector(
              /// 지정 취소 버튼
              child: const Text('지정 취소', style: TextStyle(fontSize: 13, color: Colors.red)),
              onTap: () {
                controller.selectCoord.value = CoordinateModel(null, null);
                controller.isCommuteRangeSet(false);
                controller.selectLocationOverlay([]);
                Get.back();
              },
            ),
          ),
          // todo 위치 선택 안 했을때 스낵바 띄우기 ㄲ
          Obx(() {
            var buttonColor = controller.selectLocationOverlay.isNotEmpty ? MyColors.primary : Colors.black26;

            return GestureDetector(
              /// 지정 완료 버튼
              child: Container(
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.all(15),
                width: Get.width,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                  color: buttonColor,
                ),
                child: const Center(
                  child:
                      Text("지정 완료", style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
              onTap: () async {
                if (controller.selectLocationOverlay.isNotEmpty) {
                  var position = await naverMapController!.getCameraPosition();
                  controller.selectCoord.value = CoordinateModel(position.target.latitude, position.target.longitude);
                  controller.isCommuteRangeSet(true);
                  Get.back();
                }
              },
            );
          })
        ],
      ),
    );
  }
}
