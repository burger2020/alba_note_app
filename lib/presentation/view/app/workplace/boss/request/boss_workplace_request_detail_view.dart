import 'package:albanote_project/etc/custom_class/base_view.dart';
import 'package:albanote_project/presentation/view_model/app/workplace/boss/request/boss_workplace_request_detail_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// 요청 상세 화면
class BossWorkplaceRequestDetailView extends BaseView<BossWorkplaceRequestDetailViewModel> {
  const BossWorkplaceRequestDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: buildBaseAppBar(title: "요청 상세"),
        //todo 상세화면 ㄲㄲ
        body: Container());
  }
}
