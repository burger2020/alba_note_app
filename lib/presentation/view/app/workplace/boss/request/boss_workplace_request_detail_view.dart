import 'package:albanote_project/binding/init_binding.dart';
import 'package:albanote_project/data/entity/response/workplace_of_boss/employee_member_simple_response_dto.dart';
import 'package:albanote_project/data/entity/response/workplace_of_boss/workplace_request_detail_response_dto.dart';
import 'package:albanote_project/data/entity/response/workplace_of_boss/workplace_request_simple_response_dto.dart';
import 'package:albanote_project/etc/colors.dart';
import 'package:albanote_project/etc/custom_class/base_view.dart';
import 'package:albanote_project/etc/util.dart';
import 'package:albanote_project/presentation/component/avatar_widget.dart';
import 'package:albanote_project/presentation/view_model/app/workplace/boss/request/boss_workplace_request_detail_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// 요청 상세 화면
class BossWorkplaceRequestDetailView extends BaseView<BossWorkplaceRequestDetailViewModel> {
  const BossWorkplaceRequestDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return progressWidget(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: buildBaseAppBar(title: "요청 상세"),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Obx(() {
            var request = controller.requestDetail.value;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// 프로필 및 요청 시간
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AvatarWidget(
                      thumbPath: request.requestMember?.imageUrl,
                      size: 30,
                      type: AvatarType.type3,
                      nickname: request.requestMember?.getNameNRankName(),
                      textSize: 14,
                    ),
                    Text(
                      Util.convertDateToAgoTime(request.createdDate),
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    )
                  ],
                ),
                const SizedBox(height: 30),

                /// 요청 제목
                _buildRequestTitle(),
                const SizedBox(height: 30),

                /// 요청 내용
                Text(request.requestContent ?? ''),
                const SizedBox(height: 30),
                Container(width: Get.width, height: 1, color: Colors.black12),
                const SizedBox(height: 30),

                /// 근무 내역
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  const Text('근무 날짜'),
                  Text(Util.convertDateToYYYYMMDDEE(request.requestWorkDate)),
                ]),
                const SizedBox(height: 30),

                /// 요청 타입별 출퇴근 요청 시간
                _buildRequestCommuteTime(request),
                const SizedBox(height: 30),
                Container(width: Get.width, height: 1, color: Colors.black12),
                const SizedBox(height: 30),

                /// 메모
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('메모'),
                    Container(
                      constraints: BoxConstraints(maxWidth: Get.width / 2),
                      alignment: Alignment.topRight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(request.memo ?? '메모를 남겨보세요.', style: const TextStyle(color: Colors.grey)),
                          const SizedBox(width: 5),
                          const Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 15,
                            color: Colors.grey,
                          )
                        ],
                      ),
                    )
                  ],
                )
              ],
            );
          }),
        ),
      ),
    );
  }

  /// 요청 제목
  Widget _buildRequestTitle() {
    var request = controller.requestDetail.value;
    var requestType = (request.requestType?.getRequestTypeText() ?? '');
    var isComplete = WorkplaceRequestSimpleResponseDTOExtension.getCompleteStatusText(request.isComplete);
    var textColor = Colors.black;
    if (request.isComplete == true) {
      textColor = MyColors.primary.withAlpha(190);
    } else if (request.isComplete == false) {
      textColor = Colors.black38;
    }
    return Text(
      requestType + ' - ' + isComplete,
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: textColor),
    );
  }

  /// 요청 타입별 출퇴근 요청 시간
  Widget _buildRequestCommuteTime(WorkplaceRequestDetailResponseDTO request) {
    var requestOfficeGoingTime = Util.convertTimeStampToHourNMinute(request.requestOfficeGoingTime, short: true);
    var requestQuittingTime = Util.convertTimeStampToHourNMinute(request.requestQuittingTime, short: true);
    switch (request.requestType) {
      case WorkplaceRequestType.COMMUTE_REGISTRATION:
        return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [const Text('요청 출퇴근 시간'), Text(requestOfficeGoingTime + ' ~ ' + requestQuittingTime)]);
      case WorkplaceRequestType.COMMUTE_CORRECTION:
        var existingOfficeGoingTime = Util.convertTimeStampToHourNMinute(request.existingOfficeGoingTime, short: true);
        var existingQuittingTime = Util.convertTimeStampToHourNMinute(request.existingQuittingTime, short: true);
        return Column(
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [const Text('기존 출퇴근 시간'), Text(existingOfficeGoingTime + ' ~ ' + existingQuittingTime)]),
            const SizedBox(height: 30),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [const Text('변경 출퇴근 시간'), Text(requestOfficeGoingTime + ' ~ ' + requestQuittingTime)]),
          ],
        );
      default:
        return Container();
    }
  }
}
