import 'package:get/get.dart';

class BaseViewModel extends GetxController {
  bool get isProgress => _isProgress.value;
  RxBool _isProgress = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  void showProgress(bool progress){
    _isProgress(progress);
  }


}
