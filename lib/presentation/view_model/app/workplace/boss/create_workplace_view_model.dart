import 'package:albanote_project/domain/model/coordinate_model.dart';
import 'package:albanote_project/etc/custom_class/BaseController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:get/get.dart';

class CreateWorkplaceViewModel extends BaseViewModel {
  var workplaceName = ''.obs;
  var workplaceAddress = ''.obs;
  var addressController = TextEditingController();
  var workplaceDetailAddress = ''.obs;
  var bossName = ''.obs;
  var bossRankName = ''.obs;
  var bossPhoneNumber = ''.obs;

  RxBool isCommuteRangeSet = false.obs;
  RxInt selectRadius = 25.obs;
  Rx<CoordinateModel> selectCoordinate = CoordinateModel(null, null).obs;
  RxList<CircleOverlay> selectLocationOverlay = RxList<CircleOverlay>();
}
