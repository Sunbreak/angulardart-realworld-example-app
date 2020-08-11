import 'package:angular_router/angular_router.dart';

import 'home/home_component.template.dart' as home_template;

class Routes {
  static final all = <RouteDefinition>[
    home,
  ];

  static final home = RouteDefinition(
    routePath: RoutePath(path: ''),
    component: home_template.HomeComponentNgFactory,
  );
}
