part of 'home_cubit.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState.initial({
    @Default(true) bool isLightTheme,
    @Default(Locale("es")) Locale locale,
  }) = _Initial;
}
