part of 'plan_de_viaje_cubit.dart';

@freezed
class PlanDeViajeState with _$PlanDeViajeState {
  const factory PlanDeViajeState.initial({
    @Default([]) List<PlanDeViaje> planes,
    @Default([]) List<PlanDeViaje> expiredPlanes,
    @Default([]) List<PlanDeViaje> popularPlans,
    @Default(0) int startDate,
    @Default(0) int endDate,
    @Default("Plan de viaje") String name,
    @Default({}) Map<int, List<Map<String, bool>>> days,
    @Default(false) bool isLoadinggPlanesDeViaje,
    @Default(false) bool isCreatingPlanDeViaje,
    @Default(0) int createAmountDays,
    @Default("") String createName,
    @Default({}) Map<int, List<Map<String, bool>>> createDaysPlaces,
  }) = _Initial;
}
