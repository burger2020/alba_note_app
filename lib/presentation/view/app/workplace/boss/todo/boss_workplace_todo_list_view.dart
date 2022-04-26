import 'package:albanote_project/etc/custom_class/base_view.dart';
import 'package:albanote_project/presentation/view_model/app/workplace/boss/work_history/boss_workplace_todo_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BossWorkplaceTodoListView extends BaseView<BossWorkplaceWorkHistoryListViewModel> {
  const BossWorkplaceTodoListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildBaseAppBar(title: "전체 요청"),
      body: Container(
        decoration: const BoxDecoration(border: Border(top: BorderSide(color: Colors.black12))),
        child: Obx(
          () => controller.workplaceWorkHistory.value == 1
              ? const Center(child: Text('이 날에 등록된 할 일이 없습니다.'))
              : disallowIndicatorWidget(
                  child: SingleChildScrollView(
                      child: Obx(() => Column(crossAxisAlignment: CrossAxisAlignment.start, children: _buildTodo()))),
                ),
        ),
      ),
    );
  }

  List<Widget> _buildTodo() {
    return [Container()];
  }
}
