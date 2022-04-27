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
        body: disallowIndicatorScrollView(
          child: Padding(
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
                    const Text('근무 날짜', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(Util.convertDateToYYYYMMDDEE(request.requestWorkDate)),
                  ]),
                  const SizedBox(height: 30),

                  /// 요청 타입별 출퇴근 요청 시간
                  _buildRequestCommuteTime(request),
                  const SizedBox(height: 30),
                  _buildWorkTimeInfo(request),
                  const SizedBox(height: 30),
                  Container(width: Get.width, height: 1, color: Colors.black12),
                  const SizedBox(height: 30),

                  /// 메모
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('메모', style: TextStyle(fontWeight: FontWeight.bold)),
                      GestureDetector(
                        child: Container(
                          constraints: BoxConstraints(maxWidth: Get.width / 2),
                          alignment: Alignment.topRight,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                request.memo ?? '메모를 남겨보세요.',
                                style: TextStyle(color: request.memo != null ? Colors.black : Colors.grey),
                              ),
                              const SizedBox(width: 5),
                              const Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 15,
                                color: Colors.grey,
                              )
                            ],
                          ),
                        ),
                        onTap: () {
                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  // RoundedRectangleBorder - Dialog 화면 모서리 둥글게 조절
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                                  //Dialog Main Title
                                  title: const Center(
                                      child: Text('직원들이 볼 수 없는 메모에요.',
                                          style: TextStyle(color: Colors.grey, fontSize: 13))),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.only(top: 10),
                                        width: Get.width,
                                        constraints: const BoxConstraints(maxHeight: 150),
                                        child: TextField(
                                          keyboardType: TextInputType.multiline,
                                          maxLength: 50,
                                          minLines: 1,
                                          maxLines: 10,
                                          style: const TextStyle(fontSize: 14),
                                          decoration: const InputDecoration(
                                            isCollapsed: true,
                                            hintText: '메모를 입력하세요.',
                                            contentPadding: EdgeInsets.only(bottom: 10),
                                            hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
                                          ),
                                          onChanged: (text) {
                                            //todo 초기 텍스트 controller 연결해서 값 넣기 ㄲ
                                          },
                                        ),
                                      ),
                                      const SizedBox(height: 10)
                                    ],
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      child: const Text('취소', style: TextStyle(color: Colors.grey)),
                                      onPressed: () {
                                        Get.back();
                                      },
                                    ),
                                    TextButton(
                                      child: const Text('왼료', style: TextStyle(color: MyColors.primary)),
                                      onPressed: () {
                                        Get.back();
                                      },
                                    ),
                                  ],
                                );
                              });
                        },
                      )
                    ],
                  )
                ],
              );
            }),
          ),
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
    var style = const TextStyle(fontSize: 14, color: Colors.black);
    var requestOfficeGoingTime = Util.convertTimeStampToHourNMinute(request.requestOfficeGoingTime, short: true);
    var requestQuittingTime = Util.convertTimeStampToHourNMinute(request.requestQuittingTime, short: true);
    switch (request.requestType) {
      case WorkplaceRequestType.COMMUTE_REGISTRATION:
        return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text('요청 출퇴근 시간', style: style.copyWith(fontWeight: FontWeight.bold)),
          Text(
            requestOfficeGoingTime + ' ~ ' + requestQuittingTime,
            style: style,
          )
        ]);
      case WorkplaceRequestType.COMMUTE_CORRECTION:
        var existingOfficeGoingTime = Util.convertTimeStampToHourNMinute(request.existingOfficeGoingTime, short: true);
        var existingQuittingTime = Util.convertTimeStampToHourNMinute(request.existingQuittingTime, short: true);
        return Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text('기존 출퇴근 시간', style: style.copyWith(fontWeight: FontWeight.bold)),
              Text(existingOfficeGoingTime + ' ~ ' + existingQuittingTime, style: style)
            ]),
            const SizedBox(height: 30),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text('변경 출퇴근 시간', style: style.copyWith(fontWeight: FontWeight.bold)),
              Text(requestOfficeGoingTime + ' ~ ' + requestQuittingTime, style: style),
            ]),
          ],
        );
      default:
        return Container();
    }
  }

  /// 근무 시간 정보
  Widget _buildWorkTimeInfo(WorkplaceRequestDetailResponseDTO request) {
    switch (request.requestType) {
      case WorkplaceRequestType.COMMUTE_REGISTRATION:
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("총 근무 시간", style: TextStyle(fontWeight: FontWeight.bold)),
            Text(Util.diffDateToDate(request.requestOfficeGoingTime, request.requestQuittingTime)),
          ],
        );
      case WorkplaceRequestType.COMMUTE_CORRECTION:
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("기존 근무 시간", style: TextStyle(fontWeight: FontWeight.bold)),
                Text(Util.diffDateToDate(request.existingOfficeGoingTime, request.existingQuittingTime)),
              ],
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("변경 근무 시간", style: TextStyle(fontWeight: FontWeight.bold)),
                Text(Util.diffDateToDate(request.requestOfficeGoingTime, request.requestQuittingTime)),
              ],
            )
          ],
        );
      default:
        return Container();
    }
  }
}
