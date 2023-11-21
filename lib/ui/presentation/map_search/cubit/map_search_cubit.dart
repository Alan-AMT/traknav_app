import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:location/location.dart';

part 'map_search_state.dart';
part 'map_search_cubit.freezed.dart';

abstract class IMapSearchCubit {
  Future<void> getLocation({required Location location});
}

class MapSearchCubit extends Cubit<MapSearchState> implements IMapSearchCubit {
  MapSearchCubit() : super(MapSearchState.initial());

  @override
  Future<void> getLocation({required Location location}) async {
    LocationData locationData = await location.getLocation();
    emit(state.copyWith(location: locationData));
  }
}
