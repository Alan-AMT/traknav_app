import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:traknav_app/ui/core/data/plan_de_viaje.dart';

part 'plan_de_viaje_state.dart';
part 'plan_de_viaje_cubit.freezed.dart';

abstract class IPlanDeViajeCubit {
  void fetchCurrentPlanes();
  void fetchDonePlanes();
  void createPlanDeViaje();
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
      plans.add(PlanDeViaje.fromJson(plan.data()));
    }
    emit(state.copyWith(isLoadinggPlanesDeViaje: false, planes: plans));
  }

  @override
  Future<void> fetchDonePlanes() async {
    emit(state.copyWith(isLoadinggPlanesDeViaje: true));
    emit(state.copyWith(isLoadinggPlanesDeViaje: false));
  }

  @override
  Future<void> createPlanDeViaje() async {
    emit(state.copyWith(isCreatingPlanDeViaje: true));
    emit(state.copyWith(isCreatingPlanDeViaje: false));
  }
}
