import 'package:angular_router/angular_router.dart';

import '../shared/shared.dart';

abstract class NoAuthGuard implements CanActivate {
  UserService get userService;

  @override
  Future<bool> canActivate(RouterState current, RouterState next) {
    return userService.isAuthenticated.take(1).map((value) => !value).first;
  }
}
