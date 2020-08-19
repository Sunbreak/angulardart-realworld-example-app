import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';

import 'routes.dart';
import 'shared/shared.dart';

@Component(
  selector: 'app-root',
  templateUrl: 'app_component.html',
  directives: [routerDirectives, FooterComponent, HeaderComponent],
  providers: [ClassProvider(ApiService), ClassProvider(UserService)],
  exports: [Routes],
)
class AppComponent {}
