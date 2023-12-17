import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:traknav_app/ui/core/data/plan_de_viaje.dart';

part 'plan_de_viaje_state.dart';
part 'plan_de_viaje_cubit.freezed.dart';

abstract class IPlanDeViajeCubit {
  Future<void> fetchCurrentPlanes();
  Future<void> createPlanDeViaje(
      {required DateTime startDate,
      required String name,
      required Map<String, List<Map<String, dynamic>>> tripDaysData});
  Future<void> updatePlanDeViaje(
      {required DateTime startDate,
      required String name,
      required String id,
      required Map<String, List<Map<String, dynamic>>> tripDaysData});
  Future<void> fetchExpiredPlanes();
}

class PlanDeViajeCubit extends Cubit<PlanDeViajeState>
    implements IPlanDeViajeCubit {
  PlanDeViajeCubit() : super(const PlanDeViajeState.initial());

  @override
  Future<void> fetchCurrentPlanes() async {
    emit(state.copyWith(isLoadinggPlanesDeViaje: true));
    final QuerySnapshot<Map<String, dynamic>> response =
        await PlanDeViajeDataSource.fetchCurrentPlanes();
    final plans = <PlanDeViaje>[];
    for (final plan in response.docs) {
      plans.add(PlanDeViaje.fromJson({...plan.data(), "id": plan.id}));
    }
    final filtered = plans.where((plan) => !plan.completed).toList();
    emit(state.copyWith(isLoadinggPlanesDeViaje: false, planes: filtered));
  }

  @override
  Future<void> fetchExpiredPlanes() async {
    emit(state.copyWith(isLoadinggPlanesDeViaje: true));
    final QuerySnapshot<Map<String, dynamic>> response =
        await PlanDeViajeDataSource.fetchExpiredPlanes();
    final plans = <PlanDeViaje>[];
    for (final plan in response.docs) {
      plans.add(PlanDeViaje.fromJson({...plan.data(), "id": plan.id}));
    }
    emit(state.copyWith(isLoadinggPlanesDeViaje: false, expiredPlanes: plans));
  }

  @override
  Future<void> createPlanDeViaje(
      {required DateTime startDate,
      required String name,
      required Map<String, List<Map<String, dynamic>>> tripDaysData}) async {
    emit(state.copyWith(isCreatingPlanDeViaje: true));
    final endDate = startDate.add(Duration(days: tripDaysData.length - 1));
    await PlanDeViajeDataSource.createPlanDeViaje({
      "completed": false,
      "endDate": endDate.millisecondsSinceEpoch,
      "startDate": startDate.millisecondsSinceEpoch,
      "name": name,
      "days": tripDaysData
    });
    emit(state.copyWith(isCreatingPlanDeViaje: false));
  }

  @override
  Future<void> updatePlanDeViaje(
      {required DateTime startDate,
      required String name,
      required String id,
      required Map<String, List<Map<String, dynamic>>> tripDaysData}) async {
    emit(state.copyWith(isCreatingPlanDeViaje: true));
    final endDate = startDate.add(Duration(days: tripDaysData.length - 1));
    await PlanDeViajeDataSource.updatePlanDeViaje(data: {
      "completed": false,
      "endDate": endDate.millisecondsSinceEpoch,
      "startDate": startDate.millisecondsSinceEpoch,
      "name": name,
      "days": tripDaysData
    }, id: id);
    emit(state.copyWith(isCreatingPlanDeViaje: false));
  }
}
