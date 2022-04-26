import 'package:albanote_project/domain/repository/remote/workplace_repository.dart';
import 'package:albanote_project/etc/custom_class/BaseController.dart';

/// 일터 할 일 리스트
class BossWorkplaceTodoListViewModel extends BaseViewModel {
  BossWorkplaceTodoListViewModel(this._workplaceOfBossRepository);

  final WorkplaceOfBossRepository _workplaceOfBossRepository;

}