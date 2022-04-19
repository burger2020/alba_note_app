import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// 요청 상세 화면
class BossWorkplaceRequestDetailView extends StatelessWidget {
  const BossWorkplaceRequestDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: GestureDetector(child: const Icon(Icons.close, color: Colors.black), onTap: () => Get.back()),
          title: const Text("요청 상세", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          centerTitle: true,
        ),
        //todo 상세화면 ㄲㄲ
        body: Container());
  }
}
