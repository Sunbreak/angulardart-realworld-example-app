import 'package:angular_router/angular_router.dart';

import 'profile_articles_component.template.dart' as profile_articles_template;
import 'profile_favorites_component.template.dart'
    as profile_favorites_template;

const usernameParam = 'username';
final parent = RoutePath(path: 'profile/:$usernameParam');

class ProfileRoutes {
  static final profileArticles = RouteDefinition(
    routePath: RoutePath(
      path: '',
      parent: parent,
    ),
    component: profile_articles_template.ProfileArticlesComponentNgFactory,
  );

  static final profileFavorites = RouteDefinition(
    routePath: RoutePath(
      path: 'favorites',
      parent: parent,
    ),
    component: profile_favorites_template.ProfileFavoritesComponentNgFactory,
    useAsDefault: true,
  );

  static final all = <RouteDefinition>[
    profileArticles,
    profileFavorites,
  ];
}
