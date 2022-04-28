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
import 'package:intl/intl.dart';

/// 요청 상세 화면
class BossWorkplaceRequestDetailView extends BaseView<BossWorkplaceRequestDetailViewModel> {
  const BossWorkplaceRequestDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        controller.backPress();
        return true;
      },
      child: progressWidget(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: buildBaseAppBar(title: "요청 상세", onBackPress: () => controller.backPress()),
          body: disallowIndicatorScrollView(
            child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Obx(
                  () {
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
                        request.requestType == WorkplaceRequestType.COMMUTE_REGISTRATION
                            ? _buildCommuteRegistrationWidget(request)
                            : Column(children: [
                                _buildCommuteCorrectionWidget(request),
                                const SizedBox(height: 30),
                                _buildCommuteRegistrationWidget(request),
                              ]),
                        const SizedBox(height: 30),
                        Container(width: Get.width, height: 1, color: Colors.black12),
                        const SizedBox(height: 30),

                        /// 메모
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('메모', style: TextStyle(fontWeight: FontWeight.bold)),
                            GestureDetector(
                              child: Container(
                                constraints: BoxConstraints(maxWidth: Get.width / 3 * 2),
                                alignment: Alignment.topRight,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Flexible(
                                      child: Text(controller.requestDetail.value.memo ?? '메모를 남겨보세요.',
                                          style: TextStyle(
                                            color: controller.requestDetail.value.memo != null
                                                ? Colors.black
                                                : Colors.grey,
                                          )),
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

                              /// 클릭 시 메모 다이얼로그
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
                                                controller: controller.memoController,
                                                maxLines: 10,
                                                style: const TextStyle(fontSize: 14),
                                                decoration: const InputDecoration(
                                                  isCollapsed: true,
                                                  hintText: '메모를 입력하세요.',
                                                  contentPadding: EdgeInsets.only(bottom: 10),
                                                  hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
                                                ),
                                                onChanged: (text) {
                                                  controller.onChangedMemo(text); // 메모 변경
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
                                              controller.onChangedMemo(controller.requestDetail.value.memo ?? '');
                                              Get.back();
                                            },
                                          ),
                                          TextButton(
                                            child: const Text('왼료', style: TextStyle(color: MyColors.primary)),
                                            onPressed: () {
                                              controller.setMemoText();
                                              Get.back();
                                            },
                                          ),
                                        ],
                                      );
                                    });
                              },
                            )
                          ],
                        ),
                        controller.requestDetail.value.isComplete != null
                            ? const SizedBox(height: 50)
                            : Column(
                                children: [
                                  const SizedBox(height: 50),
                                  buildBottomButton(
                                      text: "요청 수락하기",
                                      isEnable: true,
                                      negativeButtonText: "요청 거절하기",
                                      onPositiveTab: () {
                                        showAlertDialog(
                                            title: '요청 수락',
                                            content: '요청을 수락하면 수정할 수 없어요.\n수락 하시겠어요?',
                                            positiveButtonText: '수락',
                                            setOnPositiveListener: () => controller.putRequestResponse(true));
                                      },
                                      onNegativeTab: () {
                                        showAlertDialog(
                                            title: '요청 거절',
                                            content: '요청을 거절하면 수정할 수 없어요.\n거절 하시겠어요?',
                                            positiveButtonText: '거절',
                                            positiveButtonColor: Colors.red,
                                            setOnPositiveListener: () => controller.putRequestResponse(false));
                                      })
                                ],
                              )
                      ],
                    );
                  },
                )),
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

  /// 요청 위젯 생성
  Widget _buildCommuteRegistrationWidget(WorkplaceRequestDetailResponseDTO request) {
    var style = const TextStyle(fontSize: 14, color: Colors.black);
    var requestOfficeGoingTime = Util.convertTimeStampToHourNMinute(request.requestOfficeGoingTime, short: true);
    var requestQuittingTime = Util.convertTimeStampToHourNMinute(request.requestQuittingTime, short: true);
    return Column(
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text('요청 출퇴근 시간', style: style.copyWith(fontWeight: FontWeight.bold)),
          Text(requestOfficeGoingTime + ' ~ ' + requestQuittingTime, style: style)
        ]),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("요청 근무 시간", style: TextStyle(fontWeight: FontWeight.bold)),
            Text(Util.diffTimeToTime(request.requestOfficeGoingTime, request.requestQuittingTime,
                request.requestBreakTime, request.requestNightBreakTime)),
          ],
        ),
        _buildRequestWorkRecord(request)
      ],
    );
  }

  /// 요청 근무 기록
  Widget _buildRequestWorkRecord(WorkplaceRequestDetailResponseDTO request) {
    return Column(
      children: [
        request.employeeRankInfo?.isHolidayAllowance == true
            ? _buildAllowanceInfo(AllowanceType.HOLIDAY, request.requestOfficeGoingTime, request.requestOfficeGoingTime,
                request.requestBreakTime, request.requestNightBreakTime)
            : Container(),
        request.employeeRankInfo?.isNightAllowance == true
            ? _buildAllowanceInfo(AllowanceType.NIGHT, request.requestOfficeGoingTime, request.requestOfficeGoingTime,
                request.requestBreakTime, request.requestNightBreakTime)
            : Container(),
        request.employeeRankInfo?.isOvertimeAllowance == true
            ? _buildAllowanceInfo(AllowanceType.OVER, request.requestOfficeGoingTime, request.requestOfficeGoingTime,
                request.requestBreakTime, request.requestNightBreakTime)
            : Container(),
        request.requestBreakTime != null
            ? _buildAllowanceInfo(AllowanceType.BREAK, '00:00:00', request.requestBreakTime, null, null)
            : Container(),
        request.requestNightBreakTime != null
            ? _buildAllowanceInfo(AllowanceType.NIGHT_BREAK, '00:00:00', request.requestNightBreakTime, null, null)
            : Container(),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("요청한 총 급여", style: TextStyle(fontWeight: FontWeight.bold)),
            Text(NumberFormat('###,###,###,###원').format(request.requestTotalSalary ?? 0)),
          ],
        ),
      ],
    );
  }

  /// 출퇴근 수정 위젯
  Widget _buildCommuteCorrectionWidget(WorkplaceRequestDetailResponseDTO request) {
    var style = const TextStyle(fontSize: 14, color: Colors.black);
    var existingOfficeGoingTime = Util.convertTimeStampToHourNMinute(request.existingOfficeGoingTime, short: true);
    var existingQuittingTime = Util.convertTimeStampToHourNMinute(request.existingQuittingTime, short: true);
    return Column(
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text('기존 출퇴근 시간', style: style.copyWith(fontWeight: FontWeight.bold)),
          Text(existingOfficeGoingTime + ' ~ ' + existingQuittingTime, style: style)
        ]),
        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("기존 근무 시간", style: TextStyle(fontWeight: FontWeight.bold)),
            Text(Util.diffTimeToTime(request.existingOfficeGoingTime, request.existingQuittingTime,
                request.existingBreakTime, request.existingNightBreakTime)),
          ],
        ),
        _buildExistingWorkRecord(request)
      ],
    );
  }

  /// 기존 근무 기록
  Widget _buildExistingWorkRecord(WorkplaceRequestDetailResponseDTO request) {
    return Column(
      children: [
        request.employeeRankInfo?.isHolidayAllowance == true
            ? _buildAllowanceInfo(AllowanceType.HOLIDAY, request.existingOfficeGoingTime, request.existingQuittingTime,
                request.existingBreakTime, request.existingNightBreakTime)
            : Container(),
        request.employeeRankInfo?.isNightAllowance == true
            ? _buildAllowanceInfo(AllowanceType.NIGHT, request.existingOfficeGoingTime, request.existingQuittingTime,
                request.existingBreakTime, request.existingNightBreakTime)
            : Container(),
        request.employeeRankInfo?.isOvertimeAllowance == true
            ? _buildAllowanceInfo(AllowanceType.OVER, request.existingOfficeGoingTime, request.existingQuittingTime,
                request.existingBreakTime, request.existingNightBreakTime)
            : Container(),
        request.existingBreakTime != null
            ? _buildAllowanceInfo(AllowanceType.BREAK, '00:00:00', request.existingBreakTime, null, null)
            : Container(),
        request.existingBreakTime != null
            ? _buildAllowanceInfo(AllowanceType.NIGHT_BREAK, '00:00:00', request.existingNightBreakTime, null, null)
            : Container(),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("기존 총 급여", style: TextStyle(fontWeight: FontWeight.bold)),
            Text(NumberFormat('###,###,###,###원').format(request.existingTotalSalary ?? 0)),
          ],
        ),
      ],
    );
  }

  /// 근무 수당 시간 정보
  Widget _buildAllowanceInfo(AllowanceType type, String? s, String? e, String? b, String? nb) {
    var typeName = "휴일 근무 시간";
    var workedTime = Util.diffTimeToTime(s, e, b, nb, type: type);
    if (workedTime == '00시간 00분') return Container();
    if (type == AllowanceType.OVER) {
      typeName = "초과 근무 시간";
    } else if (type == AllowanceType.NIGHT) {
      typeName = "야간 근무 시간";
    } else if (type == AllowanceType.BREAK) {
      typeName = '휴게 시간';
    } else if (type == AllowanceType.NIGHT_BREAK) {
      typeName = '야간 휴게 시간';
    }

    var style = const TextStyle(fontSize: 12, color: Colors.black54);
    return Column(
      children: [
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text(typeName, style: style), Text(workedTime, style: style)],
        ),
      ],
    );
  }
}

enum AllowanceType { NIGHT, OVER, HOLIDAY, NORMAL, BREAK, NIGHT_BREAK }
