part of 'home_cubit.dart';

// @freezed
// sealed class HomeState {
//   final int hola = 2;
// }

// final class HomeInitial extends HomeState {}

@freezed
class HomeState with _$HomeState {
  const factory HomeState.initial({
    @Default(false) bool isLightTheme,
  }) = _Initial;
}
