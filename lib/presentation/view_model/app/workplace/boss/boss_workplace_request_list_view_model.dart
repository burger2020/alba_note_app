import 'package:albanote_project/data/entity/workplace_of_boss/workplace_request_simple_response_dto.dart';
import 'package:albanote_project/domain/model/page_request_model.dart';
import 'package:albanote_project/domain/repository/remote/workplace_repository.dart';
import 'package:albanote_project/etc/custom_class/BaseController.dart';
import 'package:albanote_project/presentation/view/app/workplace/boss/boss_workplace_request_detail_view.dart';
import 'package:albanote_project/presentation/view_model/app/workplace/boss/boss_workplace_request_detail_view_model.dart';
import 'package:get/get.dart';

class BossWorkplaceRequestViewModel extends BaseViewModel {
  BossWorkplaceRequestViewModel(this._workplaceOfBossRepository, this.workplaceId);

  final WorkplaceOfBossRepository _workplaceOfBossRepository;
  final int workplaceId;

  PageRequestModel pageRequest = PageRequestModel();
  RxList<WorkplaceRequestSimpleResponseDTO> workplaceRequests = RxList<WorkplaceRequestSimpleResponseDTO>();

  @override
  void onInit() {
    super.onInit();
    _getWorkplaceRequestList();
  }

  /// 일터 요청 조회
  Future _getWorkplaceRequestList() async {
    var response = await _workplaceOfBossRepository.getWorkplaceRequestList(workplaceId, pageRequest, false);
    response.when(
        success: (data) {
          workplaceRequests.addAll(data);
          pageRequest.setResult(data);
        },
        error: (e) {});
  }

  /// 요청 상세화면 전환
  void startRequestDetailView(int requestId) {
    Get.to(const BossWorkplaceRequestDetailView(), binding: BindingsBuilder((() {
      BossWorkplaceRequestDetailViewModel(_workplaceOfBossRepository, requestId);
    })));
  }
}
