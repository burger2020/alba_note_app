import 'package:albanote_project/etc/custom_class/base_view.dart';
import 'package:albanote_project/presentation/view_model/app/workplace/boss/work_history/boss_workplace_todo_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BossWorkplaceWorkHistoryListView extends BaseView<BossWorkplaceWorkHistoryListViewModel> {
  const BossWorkplaceWorkHistoryListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.workplaceId = (Get.arguments as Map<String, int>)['workplaceId']!;
    controller.getWorkRecordsByDate();

    return Scaffold(appBar: buildBaseAppBar(title: '근무 관리'), body: disallowIndicatorScrollView(child: Container()));
  }
}
