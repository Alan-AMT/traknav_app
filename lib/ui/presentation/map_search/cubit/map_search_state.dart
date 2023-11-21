part of 'map_search_cubit.dart';

@freezed
class MapSearchState with _$MapSearchState {
  const factory MapSearchState.initial(
      {@Default(null) LocationData? location}) = _Initial;
}
