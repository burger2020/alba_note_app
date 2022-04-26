import 'package:albanote_project/etc/colors.dart';
import 'package:albanote_project/etc/custom_class/base_view.dart';
import 'package:albanote_project/presentation/view/app/workplace/boss/boss_workplace_main_view.dart';
import 'package:albanote_project/presentation/view_model/app/workplace/boss/boss_workplace_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BossWorkplaceContainerView extends BaseView<BossWorkplaceMainViewModel> {
  const BossWorkplaceContainerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isEmpty.value
          ? Scaffold(
              backgroundColor: Colors.white,
              appBar: buildBaseAppBar(
                leadIcon: null,
                title: '알바노트',
                textStyle: const TextStyle(fontWeight: FontWeight.bold, color: MyColors.primary, fontSize: 15),
              ),
              body: Container(
                decoration: const BoxDecoration(border: Border(top: BorderSide(color: Colors.black12))),
                child: Center(
                  child: GestureDetector(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white,
                          border: Border.all(color: MyColors.primary)),
                      child: const Text("등록된 일터가 없습니다.\n일터를 추가해보세요.",
                          style: TextStyle(fontSize: 15, color: MyColors.primary)),
                    ),
                    onTap: () => controller.startCreateWorkplaceView(),
                  ),
                ),
              ),
            ) // todo 일터 없는 화면...
          : DefaultTabController(
              length: 3,
              child: Scaffold(
                appBar: AppBar(
                    backgroundColor: Colors.white,
                    elevation: 0,
                    title: Row(
                      children: [
                        Text(
                          controller.workplace.value.workplaceTitle ?? '',
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: Colors.black),
                        ),
                        const SizedBox(width: 10),
                        const Icon(Icons.expand_more_rounded, color: Colors.black)
                      ],
                    ),
                    bottom: PreferredSize(
                      preferredSize: const Size.fromHeight(30),
                      child: Container(
                        decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black12))),
                        height: 30,
                        child: const TabBar(
                          labelPadding: EdgeInsets.all(0),
                          tabs: [
                            Tab(
                                child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 15),
                                    child: Text("일터", style: TextStyle(fontSize: 14)))),
                            Tab(
                                child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 15),
                                    child: Text("공지", style: TextStyle(fontSize: 14)))),
                            Tab(
                                child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 10),
                                    child: Text("자유게시판", style: TextStyle(fontSize: 14))))
                          ],
                          indicatorColor: MyColors.primary,
                          labelColor: MyColors.primary,
                          unselectedLabelColor: Colors.black26,
                          indicatorSize: TabBarIndicatorSize.label,
                        ),
                      ),
                    )),
                body: Container(
                  color: Colors.white,
                  child: disallowIndicatorWidget(
                      child: const TabBarView(children: [BossWorkplaceMainView(), Text("공지"), Text("자유게시판")])),
                ),
              ),
            ),
    );
  }
}
