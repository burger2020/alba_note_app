import 'package:albanote_project/domain/model/page_request_model.dart';
import 'package:albanote_project/domain/repository/remote/workplace_repository.dart';
import 'package:albanote_project/etc/custom_class/BaseController.dart';
import 'package:get/get.dart';

/// 일터 근무 기록 리스트
class BossWorkplaceWorkHistoryListViewModel extends BaseViewModel {
  BossWorkplaceWorkHistoryListViewModel(this._workplaceOfBossRepository);

  final WorkplaceOfBossRepository _workplaceOfBossRepository;

  RxInt workplaceWorkHistory = 1.obs;
  PageRequestModel pageRequest = PageRequestModel();
}
