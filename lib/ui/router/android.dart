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
        // AutoRoute(page: SignUpRoute.page),
      ];
}
