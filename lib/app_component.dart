import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';

import 'routes.dart';
import 'shared/shared.dart';

@Component(
  selector: 'app-root',
  templateUrl: 'app_component.html',
  directives: [routerDirectives, FooterComponent, HeaderComponent],
  providers: [
    ClassProvider(ApiService),
    ClassProvider(JwtService),
    ClassProvider(UserService),
    ClassProvider(ProfilesService),
  ],
  exports: [Routes],
)
class AppComponent implements OnInit {
  UserService _userService;

  AppComponent(this._userService);

  @override
  void ngOnInit() {
    _userService.populate();
  }
}
