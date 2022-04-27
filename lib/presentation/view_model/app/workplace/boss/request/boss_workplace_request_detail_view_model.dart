import 'package:albanote_project/data/entity/response/workplace_of_boss/workplace_request_detail_response_dto.dart';
import 'package:albanote_project/domain/repository/remote/workplace_repository.dart';
import 'package:albanote_project/etc/custom_class/BaseController.dart';
import 'package:get/get.dart';

class BossWorkplaceRequestDetailViewModel extends BaseViewModel {
  BossWorkplaceRequestDetailViewModel(this._workplaceOfBossRepository, this.requestId);

  final WorkplaceOfBossRepository _workplaceOfBossRepository;
  final int requestId;

  var requestDetail = WorkplaceRequestDetailResponseDTO().obs;

  @override
  void onInit() async {
    super.onInit();
    getWorkplaceRequestDetail();
  }

  /// 일터 요청 상세 조회
  Future getWorkplaceRequestDetail() async {
    showProgress(true);
    var result = await _workplaceOfBossRepository.getWorkplaceRequestDetail(requestId);
    result.when(success: (data) {
      showProgress(false);
      requestDetail(data);
    }, error: (e) {
      showProgress(false);
      showSnackBarByMessage();
    });
  }
}
