import 'package:angular_router/angular_router.dart';

import 'auth/auth_component.template.dart' as auth_template;
import 'editor/editor_component.template.dart' as editor_template;
import 'home/home_component.template.dart' as home_template;
import 'profile/profile_component.template.dart' as profile_template;
import 'settings/settings_component.template.dart' as settings_template;

class Routes {
  static final all = <RouteDefinition>[
    login,
    register,
    home,
    settings,
    profile,
    editorNew,
    editorEdit,
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

  static final profile = RouteDefinition(
    routePath: RoutePath(path: 'profile/:username'),
    component: profile_template.ProfileComponentNgFactory,
  );

  static final editorNew = RouteDefinition(
    routePath: RoutePath(path: 'editor/'),
    component: editor_template.EditorComponentNgFactory,
  );

  static final editorEdit = RouteDefinition(
    routePath: RoutePath(path: 'editor/:slug'),
    component: editor_template.EditorComponentNgFactory,
  );
}
