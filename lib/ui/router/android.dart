import 'package:auto_route/auto_route.dart';
import 'package:traknav_app/ui/presentation/trip_plan_created/main.dart';

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
        AutoRoute(page: EditarFavoritosRoute.page),
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
        // AutoRoute(page: SignUpRoute.page),
      ];
}
