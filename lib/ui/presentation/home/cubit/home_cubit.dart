import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_state.dart';
part 'home_cubit.freezed.dart';

abstract class IHomeCubit {
  void changeThemeMode();
  void changeLanguage({required String lang});
}

class HomeCubit extends Cubit<HomeState> implements IHomeCubit {
  HomeCubit() : super(const HomeState.initial());

  @override
  void changeThemeMode() {
    final isLightTheme = state.isLightTheme;
    emit(state.copyWith(isLightTheme: !isLightTheme));
  }

  @override
  void changeLanguage({required String lang}) {
    final locale = Locale(lang);
    if (state.locale == locale) return;
    emit(state.copyWith(locale: locale));
  }
}
