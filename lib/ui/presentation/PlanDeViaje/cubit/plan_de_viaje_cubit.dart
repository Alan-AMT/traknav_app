import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:traknav_app/ui/config/toasts/main.dart';
import 'package:traknav_app/ui/core/data/plan_de_viaje.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

part 'plan_de_viaje_state.dart';
part 'plan_de_viaje_cubit.freezed.dart';

abstract class IPlanDeViajeCubit {
  Future<void> fetchCurrentPlanes({required BuildContext context});
  Future<void> createPlanDeViaje(
      {required DateTime startDate,
      required String name,
      required String city,
      required Map<String, List<Map<String, dynamic>>> tripDaysData});
  Future<void> updatePlanDeViaje(
      {required DateTime startDate,
      required String name,
      required String city,
      required String id,
      required Map<String, List<Map<String, dynamic>>> tripDaysData});
  Future<void> fetchExpiredPlanes({required BuildContext context});
  Future<void> finishPlanDeViaje({required String id});
  Future<void> deletePlanDeViaje({required String id});
  Future<void> fetchPopularPlans({required String city});
  Future<void> copyPlanDeViaje({required PlanDeViaje plan});
  void refreshPopularPlanes();
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
  Future<void> fetchCurrentPlanes({required BuildContext context}) async {
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
      ToastApp.error(AppLocalizations.of(context)!.failedFetchPlans);
      emit(state.copyWith(isLoadinggPlanesDeViaje: false, planes: []));
    }
  }

  @override
  Future<void> fetchExpiredPlanes({required BuildContext context}) async {
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
      ToastApp.error(AppLocalizations.of(context)!.failedFetchPlans);
      emit(state.copyWith(isLoadinggPlanesDeViaje: false, expiredPlanes: []));
    }
  }

  @override
  Future<void> createPlanDeViaje(
      {required DateTime startDate,
      required String name,
      required String city,
      required Map<String, List<Map<String, dynamic>>> tripDaysData}) async {
    emit(state.copyWith(isCreatingPlanDeViaje: true));
    final endDate = startDate.add(Duration(days: tripDaysData.length - 1));
    try {
      await PlanDeViajeDataSource.createPlanDeViaje({
        "completed": false,
        "endDate": endDate.millisecondsSinceEpoch,
        "startDate": startDate.millisecondsSinceEpoch,
        "name": name,
        "city": city,
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
      required String city,
      required String id,
      required Map<String, List<Map<String, dynamic>>> tripDaysData}) async {
    final endDate = startDate.add(Duration(days: tripDaysData.length - 1));
    try {
      await PlanDeViajeDataSource.updatePlanDeViaje(data: {
        "completed": false,
        "endDate": endDate.millisecondsSinceEpoch,
        "startDate": startDate.millisecondsSinceEpoch,
        "name": name,
        "city": city,
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

  @override
  Future<void> fetchPopularPlans({required String city}) async {
    try {
      final QuerySnapshot<Map<String, dynamic>> response =
          await PlanDeViajeDataSource.fetchPopularPlans(city: city);
      final plans = <PlanDeViaje>[];
      for (final plan in response.docs) {
        plans.add(PlanDeViaje.fromJson({...plan.data(), "id": plan.id}));
      }
      emit(state.copyWith(popularPlans: plans));
    } catch (e) {
      ToastApp.error(
          "No pudimos obtener los planes de viaje. Intenta de nuevo");
      emit(state.copyWith(popularPlans: []));
    }
  }

  @override
  Future<void> copyPlanDeViaje({required PlanDeViaje plan}) async {
    final endDate = DateTime.now().add(Duration(days: plan.days.length - 1));
    //Reset visited days to false
    Map<String, List<Map<String, dynamic>>> resetedDays = {};
    plan.days.keys.forEach((dayNumber) => resetedDays[dayNumber.toString()] =
        plan.days[dayNumber]!
            .map((place) => {...place, "visited": false})
            .toList());
    try {
      await PlanDeViajeDataSource.createPlanDeViaje({
        "completed": false,
        "endDate": endDate.millisecondsSinceEpoch,
        "startDate": DateTime.now().millisecondsSinceEpoch,
        "name": "Copia de ${plan.name}",
        "city": plan.city,
        "days": resetedDays,
      });
      ToastApp.success("Plan de viaje copiado con éxito");
    } catch (e) {
      ToastApp.error("No pudimos crear tu plan de viaje. Intenta de nuevo");
    }
    emit(state.copyWith(isCreatingPlanDeViaje: false));
  }

  @override
  void refreshPopularPlanes() {
    emit(state.copyWith(popularPlans: []));
  }
}
