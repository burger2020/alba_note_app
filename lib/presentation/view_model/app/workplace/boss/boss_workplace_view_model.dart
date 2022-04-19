import 'package:albanote_project/data/entity/workplace_of_boss/workplace_info_of_boss_response_dto.dart';
import 'package:albanote_project/domain/repository/remote/workplace_repository.dart';
import 'package:albanote_project/etc/custom_class/BaseController.dart';
import 'package:albanote_project/presentation/view/app/workplace/boss/boss_workplace_request_list_view.dart';
import 'package:get/get.dart';

import 'boss_workplace_request_list_view_model.dart';

class BossWorkplaceViewModel extends BaseViewModel {
  BossWorkplaceViewModel(this._workplaceOfBossRepository);

  final WorkplaceOfBossRepository _workplaceOfBossRepository;

  Rx<WorkplaceInfoOfBossResponseDTO> workplace = WorkplaceInfoOfBossResponseDTO().obs;

  @override
  void onInit() {
    super.onInit();
    _getWorkplaceInfoOfBoss(null);
  }

  /// 사장님 일터 조회
  Future _getWorkplaceInfoOfBoss(int? workplaceId) async {
    var result = await _workplaceOfBossRepository.getWorkplaceInfoOfBoss(workplaceId);
    result.when(success: (data) {
      workplace(data);
    }, error: (e) {
      print("${e.message}");
    });
  }

  void startRequestView() {
    Get.to(const BossWorkplaceRequestListView(),
        binding: BindingsBuilder(() {
          Get.put(BossWorkplaceRequestViewModel(_workplaceOfBossRepository, workplace.value.workplaceId!));
        })
    );
  }
}
