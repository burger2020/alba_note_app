import 'package:albanote_project/data/entity/response/workplace_of_boss/todo_record_response_dto.dart';
import 'package:albanote_project/data/entity/response/workplace_of_boss/work_record_response_dto.dart';
import 'package:albanote_project/data/entity/response/workplace_of_boss/workplace_request_simple_response_dto.dart';
import 'package:albanote_project/etc/custom_class/base_view.dart';
import 'package:albanote_project/etc/util.dart';
import 'package:albanote_project/presentation/component/avatar_widget.dart';
import 'package:albanote_project/presentation/view_model/app/workplace/boss/boss_workplace_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BossWorkplaceMainView extends BaseView<BossWorkplaceMainViewModel> {
  const BossWorkplaceMainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 30),
              _tabView(),
              const SizedBox(height: 30),
              // 새로운 요청
              _buildSectionCommonWidget(
                  title: "새로운 요청 ${controller.workplace.value.workplaceRequest?.length ?? 0}개",
                  list: List.generate(controller.workplace.value.workplaceRequest?.length ?? 0,
                      (index) => _buildRequestView(controller.workplace.value.workplaceRequest![index])),
                  emptyText: '새로운 요청이 없어요.',
                  allView: () => controller.startRequestListView()),
              const SizedBox(height: 40),
              // 현재 근무자
              _buildSectionCommonWidget(
                  title:
                      "현재 근무자 ${controller.workplace.value.currentEmployees?.length ?? 0}/${controller.workplace.value.totalEmployeeCount}명",
                  list: List.generate(controller.workplace.value.currentEmployees?.length ?? 0,
                      (index) => _buildCurrentWorkingEmployeeView(controller.workplace.value.currentEmployees![index])),
                  emptyText: '현재 근무자가 없어요.',
                  allView: () {
                    print("현재 근무자 전체보기");
                  }),
              const SizedBox(height: 40),
              _buildSectionCommonWidget(
                  title:
                      "오늘 완료된 할 일 ${controller.workplace.value.completedTodos?.length ?? 0}/${controller.workplace.value.totalTodoCount}",
                  list: List.generate(controller.workplace.value.completedTodos?.length ?? 0,
                      (index) => _buildCompletedTodo(controller.workplace.value.completedTodos![index])),
                  emptyText: '완료된 할 일이 없어요.',
                  allView: () {}),
              const SizedBox(height: 40),
            ],
          ),
        ));
  }

  /// 메뉴 아이콘 그리드뷰
  Widget _tabView() {
    var iconList = [
      _buildMenuIconTab(Icons.check_box, const Color(0xff6579C1), "할 일 관리", () => controller.startTodoListView()),
      _buildMenuIconTab(
          Icons.watch_later, const Color(0xffE36D78), "근무 관리", () => controller.startWorkHistoryListView()),
      _buildMenuIconTab(Icons.notification_important_rounded, const Color(0xff2E85F9), "요청 관리",
          () => controller.startRequestListView()),
      _buildMenuIconTab(Icons.settings, const Color(0xff1FBCC3), "일터 관리", () {}),
      _buildMenuIconTab(Icons.people, const Color(0xffC764D5), "직원 관리", () {}),
      _buildMenuIconTab(Icons.person, const Color(0xff886DE5), "프로필 관리", () {})
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: iconList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, childAspectRatio: 1.3, mainAxisSpacing: 0, crossAxisSpacing: 0),
        itemBuilder: (context, index) {
          return iconList[index];
        },
      ),
    );
  }

  /// 메뉴 아이콘 생성
  Widget _buildMenuIconTab(IconData icon, Color iconColor, String title, Function onTap) {
    return GestureDetector(
      child: Column(children: [
        Icon(icon, color: iconColor, size: 45),
        const SizedBox(height: 10),
        Text(title, style: const TextStyle(fontSize: 15))
      ]),
      onTap: () => onTap(),
    );
  }

  /// 섹션 공통 위젯
  _buildSectionCommonWidget({
    required String title,
    required Function allView,
    required String emptyText,
    required List<Widget> list,
  }) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title),
            GestureDetector(
              child: const Text("전체보기", style: TextStyle(color: Colors.black26, fontSize: 13)),
              onTap: () => allView(),
            ),
          ],
        ),
      ),
      const SizedBox(height: 10),
      list.isEmpty
          ? Container(
              padding: const EdgeInsets.only(top: 10),
              child: Text(emptyText, style: const TextStyle(color: Colors.grey)))
          : SizedBox(
              width: double.infinity,
              child: disallowIndicatorScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [const SizedBox(width: 15), ...list, const SizedBox(width: 15)],
                ),
              ),
            )
    ]);
  }

  /// 새로운 요청 아이템
  Widget _buildRequestView(WorkplaceRequestSimpleResponseDTO request) {
    var title = request.requestType?.getRequestTypeText() ?? '';
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            border: Border.fromBorderSide(BorderSide(color: Colors.black26))),
        child: Container(
          margin: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  AvatarWidget(thumbPath: request.requestMember!.imageUrl, type: AvatarType.type1, size: 25),
                  const SizedBox(width: 10),
                  Text('${request.requestMember!.name}(${request.requestMember!.rankName})'),
                  const SizedBox(width: 10)
                ],
              ),
              const SizedBox(height: 10),
              Text(title),
            ],
          ),
        ),
      ),
    );
  }

  /// 현재 근무자
  Widget _buildCurrentWorkingEmployeeView(WorkRecordResponseDTO employee) {
    var title = "${Util.convertTimeStampToHourNMinute(employee.officeGoingTime)} 출근";
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            border: Border.fromBorderSide(BorderSide(color: Colors.black26))),
        child: Container(
          margin: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  AvatarWidget(thumbPath: employee.currentEmployee!.imageUrl, type: AvatarType.type1, size: 25),
                  const SizedBox(width: 10),
                  Text('${employee.currentEmployee!.name}(${employee.currentEmployee!.rankName})'),
                  const SizedBox(width: 10)
                ],
              ),
              const SizedBox(height: 10),
              Text(title),
            ],
          ),
        ),
      ),
    );
  }

  /// 완료된 할 일
  Widget _buildCompletedTodo(TodoRecordResponseDTO todo) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            border: Border.fromBorderSide(BorderSide(color: Colors.black26))),
        child: Container(
          margin: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  AvatarWidget(thumbPath: todo.completedMember!.imageUrl, type: AvatarType.type1, size: 25),
                  const SizedBox(width: 10),
                  Text('${todo.completedMember!.name}(${todo.completedMember!.rankName})'),
                  const SizedBox(width: 10)
                ],
              ),
              const SizedBox(height: 10),
              Text(todo.todoTitle ?? ''),
            ],
          ),
        ),
      ),
    );
  }
}
