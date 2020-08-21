import 'package:angular_router/angular_router.dart';

import 'auth/auth_component.template.dart' as auth_template;
import 'home/home_component.template.dart' as home_template;
import 'settings/settings_component.template.dart' as settings_template;

class Routes {
  static final all = <RouteDefinition>[
    login,
    register,
    home,
    settings,
  ];

  static final login = RouteDefinition(
    routePath: RoutePath(path: 'login'),
    component: auth_template.AuthComponentNgFactory,
  );

  static final register = RouteDefinition(
    routePath: RoutePath(path: 'register'),
    component: auth_template.AuthComponentNgFactory,
  );

  static final home = RouteDefinition(
    routePath: RoutePath(path: ''),
    component: home_template.HomeComponentNgFactory,
  );

  static final settings = RouteDefinition(
    routePath: RoutePath(path: 'settings'),
    component: settings_template.SettingsComponentNgFactory,
  );
}
