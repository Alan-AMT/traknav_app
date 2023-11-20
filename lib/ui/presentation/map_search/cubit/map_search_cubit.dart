import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'map_search_state.dart';
part 'map_search_cubit.freezed.dart';

class MapSearchCubit extends Cubit<MapSearchState> {
  MapSearchCubit() : super(MapSearchState.initial());
}
