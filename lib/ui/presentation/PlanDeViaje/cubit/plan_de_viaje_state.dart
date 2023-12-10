part of 'plan_de_viaje_cubit.dart';

@freezed
class PlanDeViajeState with _$PlanDeViajeState {
  const factory PlanDeViajeState.initial({
    @Default([]) List<PlanDeViaje> planes,
    @Default(0) int startDate,
    @Default(0) int endDate,
    @Default("Plan de viaje") String name,
    @Default({}) Map<int, List<String>> days,
    @Default(false) bool isLoadinggPlanesDeViaje,
    @Default(false) bool isCreatingPlanDeViaje,
  }) = _Initial;
}
