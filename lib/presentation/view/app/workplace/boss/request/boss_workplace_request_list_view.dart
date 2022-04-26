import 'dart:ui';

import 'package:albanote_project/data/entity/response/workplace_of_boss/workplace_request_simple_response_dto.dart';
import 'package:albanote_project/etc/colors.dart';
import 'package:albanote_project/etc/custom_class/base_view.dart';
import 'package:albanote_project/presentation/component/avatar_widget.dart';
import 'package:albanote_project/presentation/view_model/app/workplace/boss/request/boss_workplace_request_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

/// 요청 전체 목록 화면
/// todo 요청 미승인만 보기 체크박스 ㄲ
class BossWorkplaceRequestListView extends BaseView<BossWorkplaceRequestViewModel> {
  const BossWorkplaceRequestListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// 초기 데이터 조회
    controller.workplaceId = (Get.arguments as Map<String, int>)['workplaceId']!;
    controller.getWorkplaceRequestList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildBaseAppBar(title: "전체 요청"),
      body: progressWidget(
        child: Container(
          decoration: const BoxDecoration(border: Border(top: BorderSide(color: Colors.black12))),
          child: Obx(
            () => controller.pageRequest.value.isLoading
                ? const Center(child: Text('받은 요청이 없습니다.'))
                : disallowIndicatorScrollView(
                    controller: controller.scrollController,
                    padding: const EdgeInsets.only(bottom: 50),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Obx(
                        () => Padding(
                          padding: const EdgeInsets.only(top: 10, right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 30,
                                height: 30,
                                child: Radio(
                                  onChanged: (value) => controller.onFilterChange(value as bool),
                                  groupValue: controller.isOnlyIncomplete.value,
                                  value: false,
                                ),
                              ),
                              const Text('전체 요청'),
                              const SizedBox(width: 10),
                              SizedBox(
                                width: 30,
                                height: 30,
                                child: Radio(
                                  onChanged: (value) => controller.onFilterChange(value as bool),
                                  groupValue: controller.isOnlyIncomplete.value,
                                  value: true,
                                ),
                              ),
                              const Text('대기 요청')
                            ],
                          ),
                        ),
                      ),
                      ..._buildAllRequest(),
                    ])),
          ),
        ),
      ),
    );
  }

  /// 전체 요청
  List<Widget> _buildAllRequest() {
    if (controller.workplaceRequests.isEmpty) return [];
    var requests = controller.workplaceRequests;
    var dateFormat = DateFormat('yyyy. MM. dd EE');

    var date = dateFormat.format(DateTime.parse(requests[0].createdDate ?? DateTime.now().toString()));
    List<Widget> widgets = [_buildDateFormatWidget(date), _buildRequestItem(requests[0])];

    for (var i = 1; i < requests.length; i++) {
      var before = DateTime.parse(requests[i - 1].createdDate!);
      var after = DateTime.parse(requests[i].createdDate!);
      // 이전과 이후 요청 날짜 다를 경우 날찌 경계 추가
      if (before.year != after.year || before.month != after.month || before.day != after.day) {
        widgets.add(_buildDateFormatWidget(dateFormat.format(after)));
      }
      widgets.add(_buildRequestItem(requests[i]));
    }
    return widgets;
  }

  /// 날짜 구분 위젯
  Widget _buildDateFormatWidget(String date) {
    var dateText = date
        .replaceFirst('Mon', '월')
        .replaceFirst('Tue', '화')
        .replaceFirst('Wed', '수')
        .replaceFirst('Thu', '목')
        .replaceFirst('Fri', '금')
        .replaceFirst('Sat', '토')
        .replaceFirst('Sun', '일');
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20, top: 30, bottom: 10),
      child: Text(dateText, style: const TextStyle(fontSize: 13, color: Colors.grey)),
    );
  }

  /// 요청 리스트 아이템
  Widget _buildRequestItem(WorkplaceRequestSimpleResponseDTO request) {
    var avatar = AvatarWidget(thumbPath: request.requestMember!.imageUrl, type: AvatarType.type1, size: 30);
    var nameAndRank = Text("${request.requestMember!.name ?? ''}(${request.requestMember!.rankName ?? ''})");
    var requestStatus =
        Text((request.requestType?.getRequestTypeText() ?? '') + ' - ' + request.getCompleteStatusText(),
            style: TextStyle(
                color: request.isCompleted == null
                    ? Colors.black
                    : request.isCompleted == true
                        ? MyColors.primary.withAlpha(127)
                        : Colors.black26));

    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Row(children: [
            avatar,
            const SizedBox(width: 10),
            nameAndRank,
          ]),
          requestStatus
        ]),
      ),

      /// 요청 상세 화면
      onTap: () => controller.startRequestDetailView(request.requestId!),
    );
  }
}
