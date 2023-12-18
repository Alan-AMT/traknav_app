import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:traknav_app/ui/config/toasts/main.dart';
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
  Future<void> finishPlanDeViaje({required String id});
  Future<void> deletePlanDeViaje({required String id});
  Future<void> updatePlaceVisitedStatus(
      {required bool status,
      required int dayNumber,
      required List<Map<String, dynamic>> oldInfo,
      required int placeIndex,
      required String docId});
}

class PlanDeViajeCubit extends Cubit<PlanDeViajeState>
    implements IPlanDeViajeCubit {
  PlanDeViajeCubit() : super(const PlanDeViajeState.initial());

  @override
  Future<void> fetchCurrentPlanes() async {
    emit(state.copyWith(isLoadinggPlanesDeViaje: true));
    try {
      final QuerySnapshot<Map<String, dynamic>> response =
          await PlanDeViajeDataSource.fetchCurrentPlanes();
      final plans = <PlanDeViaje>[];
      for (final plan in response.docs) {
        plans.add(PlanDeViaje.fromJson({...plan.data(), "id": plan.id}));
      }
      final filtered = plans.where((plan) => !plan.completed).toList();
      emit(state.copyWith(isLoadinggPlanesDeViaje: false, planes: filtered));
    } catch (e) {
      ToastApp.error(
          "No pudimos obtener tus planes de viaje. Intenta de nuevo");
      emit(state.copyWith(isLoadinggPlanesDeViaje: false, planes: []));
    }
  }

  @override
  Future<void> fetchExpiredPlanes() async {
    emit(state.copyWith(isLoadinggPlanesDeViaje: true));
    try {
      final QuerySnapshot<Map<String, dynamic>> response =
          await PlanDeViajeDataSource.fetchExpiredPlanes();
      final plans = <PlanDeViaje>[];
      for (final plan in response.docs) {
        plans.add(PlanDeViaje.fromJson({...plan.data(), "id": plan.id}));
      }
      emit(
          state.copyWith(isLoadinggPlanesDeViaje: false, expiredPlanes: plans));
    } catch (e) {
      ToastApp.error(
          "No pudimos obtener tus planes de viaje. Intenta de nuevo");
      emit(state.copyWith(isLoadinggPlanesDeViaje: false, expiredPlanes: []));
    }
  }

  @override
  Future<void> createPlanDeViaje(
      {required DateTime startDate,
      required String name,
      required Map<String, List<Map<String, dynamic>>> tripDaysData}) async {
    emit(state.copyWith(isCreatingPlanDeViaje: true));
    final endDate = startDate.add(Duration(days: tripDaysData.length - 1));
    try {
      await PlanDeViajeDataSource.createPlanDeViaje({
        "completed": false,
        "endDate": endDate.millisecondsSinceEpoch,
        "startDate": startDate.millisecondsSinceEpoch,
        "name": name,
        "days": tripDaysData
      });
    } catch (e) {
      ToastApp.error("No pudimos crear tu plan de viaje. Intenta de nuevo");
    }
    emit(state.copyWith(isCreatingPlanDeViaje: false));
  }

  @override
  Future<void> updatePlanDeViaje(
      {required DateTime startDate,
      required String name,
      required String id,
      required Map<String, List<Map<String, dynamic>>> tripDaysData}) async {
    final endDate = startDate.add(Duration(days: tripDaysData.length - 1));
    try {
      await PlanDeViajeDataSource.updatePlanDeViaje(data: {
        "completed": false,
        "endDate": endDate.millisecondsSinceEpoch,
        "startDate": startDate.millisecondsSinceEpoch,
        "name": name,
        "days": tripDaysData
      }, id: id);
    } catch (e) {
      ToastApp.error(
          "No pudimos actualizar tu plan de viaje. Intenta de nuevo");
    }
  }

  @override
  Future<void> finishPlanDeViaje({required String id}) async {
    try {
      await PlanDeViajeDataSource.finishPlanDeViaje(id: id);
    } catch (e) {
      ToastApp.error("No pudimos finalizar tu plan de viaje. Intenta de nuevo");
    }
  }

  @override
  Future<void> deletePlanDeViaje({required String id}) async {
    try {
      await PlanDeViajeDataSource.deletePlanDeViaje(id: id);
    } catch (e) {
      ToastApp.error("No pudimos eliminar tu plan de viaje. Intenta de nuevo");
    }
  }

  @override
  Future<void> updatePlaceVisitedStatus(
      {required bool status,
      required int dayNumber,
      required String docId,
      required List<Map<String, dynamic>> oldInfo,
      required int placeIndex}) async {
    List<Map<String, dynamic>> newInfo = [...oldInfo];
    newInfo[placeIndex]["visited"] = status;
    await PlanDeViajeDataSource.updatePlaceVisitedStatus(
        id: docId, arrayInfo: newInfo, dayNumber: dayNumber);
  }
}
