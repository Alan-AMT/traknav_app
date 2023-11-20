import 'package:google_maps_webservice/places.dart';

class GooglePlacesService {
  final GoogleMapsPlaces _placesApi;

  GooglePlacesService(String apiKey)
      : _placesApi = GoogleMapsPlaces(apiKey: '#########');

  Future<List<PlacesSearchResult>> searchPlaces(String searchTerm) async {
    final response = await _placesApi.searchByText(searchTerm);
    if (response.isOkay) {
      return response.results;
    } else {
      // Situación en la que la API no devolvió un resultado.
      // Lanzar una excepción o devolver una lista vacía.
      throw Exception('Failed to fetch places: ${response.errorMessage}');
    }
  }
}