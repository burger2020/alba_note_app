import 'package:albanote_project/domain/repository/remote/workplace_repository.dart';
import 'package:albanote_project/etc/custom_class/BaseController.dart';

class BossWorkplaceRequestDetailViewModel extends BaseViewModel {
  BossWorkplaceRequestDetailViewModel(this._workplaceOfBossRepository, this.requestId);

  final WorkplaceOfBossRepository _workplaceOfBossRepository;
  final int requestId;
}
