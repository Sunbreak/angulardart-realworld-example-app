import 'package:angular_router/angular_router.dart';

import '../shared.dart';

abstract class AuthGuard implements CanActivate {
  UserService get userService;

  @override
  Future<bool> canActivate(RouterState current, RouterState next) {
    return userService.isAuthenticated.take(1).first;
  }
}
