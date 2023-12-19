import 'package:auto_route/auto_route.dart';

import 'android.gr.dart';

@AutoRouterConfig()
class AndroidRouter extends $AndroidRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: HomeRoute.page, initial: true),
        AutoRoute(page: SignInRoute.page),
        AutoRoute(page: RecommendationsRoute.page),
        AutoRoute(page: TripPlanRoute.page),
        AutoRoute(page: CreateTripPlanRoute.page),
        AutoRoute(page: TripPlanHistoryRoute.page),
        AutoRoute(page: TripPlanListRoute.page),
        AutoRoute(page: TripPlanCreatedRoute.page),
        AutoRoute(page: FavoritosRoute.page),
        AutoRoute(page: MyProfileRoute.page),
        AutoRoute(page: SearchPlacesRoute.page),
        AutoRoute(page: AcercaDe.page),
        AutoRoute(page: FAQsRoute.page),
        AutoRoute(page: CuerpoRoute.page),
        AutoRoute(page: PerfilUsuarioRoute.page),
        AutoRoute(page: InformacionGeneralRoute.page),
        AutoRoute(page: ProblemasTecnicosRoute.page),
        AutoRoute(page: PoliticasRoute.page),
        AutoRoute(page: MapSearchRoute.page),
        AutoRoute(page: ClimaRoute.page),
        AutoRoute(page: EditTripPlanRoute.page),
        AutoRoute(page: MultiUserRoute.page),
        AutoRoute(page: MapDirectionsRoute.page),
        AutoRoute(page: EditProfileRoute.page),
        AutoRoute(page: ProfileRoute.page),
        AutoRoute(page: MultiUserRoute.page),
        AutoRoute(page: MapDirectionsRoute.page),
        AutoRoute(page: ExplorePlansRoute.page),
      ];
}
