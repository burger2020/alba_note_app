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
    final List<int> radiusList = [10, 50, 100, 500, 1000];

    return Scaffold(
      appBar: buildBaseAppBar(title: '출퇴근 위치 지정'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(alignment: Alignment.center, children: [
            SizedBox(
              width: Get.width,
              height: Get.height / 2,
              child: NaverMap(
                initialCameraPosition: const CameraPosition(
                  target: LatLng(37.566570, 126.978442),
                  zoom: 17,
                ),
                locationButtonEnable: true,
                indoorEnable: true,
                maxZoom: 17,
                minZoom: 12,
                useSurface: kReleaseMode,
                logoClickEnabled: true,
                circles: [CircleOverlay(overlayId: "1", center: const LatLng(37.566570, 126.978442), radius: 50.0)],
              ),
            ),

            /// 가운데 핀
            const Padding(
              padding: EdgeInsets.only(bottom: 50.0),
              child: Icon(Icons.location_on, size: 50, color: MyColors.primary),
            )
          ]),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('출퇴근 가능 범위', style: TextStyle(fontSize: 14)),
                Container(
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black), borderRadius: BorderRadius.circular(4)),
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
                ) //todo 위치 지정 버튼 및 주소 표시해주기 ㄲㄲ
              ],
            ),
          ),
        ],
      ),
    );
  }
}
