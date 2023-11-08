import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';
part 'home_cubit.freezed.dart';

abstract class IHomeCubit {
  void changeThemeMode();
}

class HomeCubit extends Cubit<HomeState> implements IHomeCubit {
  HomeCubit() : super(const HomeState.initial());

  @override
  void changeThemeMode() {
    final isLightTheme = state.isLightTheme;
    emit(state.copyWith(isLightTheme: !isLightTheme));
    // emit(state.copyWith(isLoadingExpenses: true, expensesFilterDay: date));
  }
}
