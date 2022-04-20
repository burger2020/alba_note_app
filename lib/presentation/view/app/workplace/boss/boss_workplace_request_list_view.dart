import 'package:albanote_project/data/entity/workplace_of_boss/workplace_request_simple_response_dto.dart';
import 'package:albanote_project/etc/custom_class/base_view.dart';
import 'package:albanote_project/presentation/component/avatar_widget.dart';
import 'package:albanote_project/presentation/view_model/app/workplace/boss/boss_workplace_request_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

/// 요청 전체 목록 화면
/// todo 요청 미승인만 보기 체크박스 ㄲ
class BossWorkplaceRequestListView extends BaseView<BossWorkplaceRequestViewModel> {
  const BossWorkplaceRequestListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildBaseAppBar(title: "전체 요청"),
      body: Container(
        decoration: const BoxDecoration(border: Border(top: BorderSide(color: Colors.black12))),
        child: disallowIndicatorWidget(
          child: SingleChildScrollView(
              child: Obx(() => Column(crossAxisAlignment: CrossAxisAlignment.start, children: _buildAllRequest()))),
        ),
      ),
    );
  }

  /// 전체 요청
  List<Widget> _buildAllRequest() {
    if (controller.workplaceRequests.isEmpty) return [];
    controller.workplaceRequests.sort((a, b) => a.createdDate!.compareTo(b.createdDate!));
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
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20, top: 20, bottom: 8),
      child: Text(date, style: const TextStyle(fontSize: 13, color: Colors.grey)),
    );
  }

  /// 요청 아이템
  Widget _buildRequestItem(WorkplaceRequestSimpleResponseDTO request) {
    var avatar = AvatarWidget(thumbPath: request.requestMember!.imageUrl, type: AvatarType.type1, size: 30);
    var nameAndRank = Text("${request.requestMember!.name ?? ''}(${request.requestMember!.rankName ?? ''})");
    var requestStatus =
        Text((request.requestType?.getRequestTypeText() ?? '') + ' - ' + request.getCompleteStatusText());

    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 7),
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
