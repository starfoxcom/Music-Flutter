import 'package:auto_route/annotations.dart';
import 'package:music_flutter/views/dashboard_view.dart';

@AdaptiveAutoRouter(
  routes: <AutoRoute>[
    AutoRoute(path: "/dashboard", page: DashboardView, initial: true),
  ],
)
class $AppRouter {}
