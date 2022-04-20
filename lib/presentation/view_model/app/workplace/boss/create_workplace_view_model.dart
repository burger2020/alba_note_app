import 'package:albanote_project/etc/custom_class/BaseController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateWorkplaceViewModel extends BaseViewModel {
  var workplaceName = ''.obs;
  var address = ''.obs;
  var addressController = TextEditingController();
  var detailAddress = ''.obs;
  var bossName = ''.obs;
  var bossRankName = ''.obs;
  var bossPhoneNumber = ''.obs;
}
