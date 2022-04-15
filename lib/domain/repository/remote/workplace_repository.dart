abstract class WorkplaceOfBossRepository {
  /// 일터 정보 조회
  Future getWorkplaceInfo(int memberId, int? workplaceId);

  /// 일터 목록 조회
  Future getWorkplaceList(int memberId);
}
