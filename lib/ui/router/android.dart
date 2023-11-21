import 'package:auto_route/auto_route.dart';
import 'package:traknav_app/ui/presentation/Favoritos/main.dart';

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
        AutoRoute(page: FavoritosRoute.page),

        AutoRoute(page: EditarFavoritosRoute.page),
        AutoRoute(page: MyProfileRoute.page),
        AutoRoute(page: SearchPlacesRoute.page),
        AutoRoute(page: AcercaDe.page),
        // AutoRoute(page: SignUpRoute.page),
      ];
}

