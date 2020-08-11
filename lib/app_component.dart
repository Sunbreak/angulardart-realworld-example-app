import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';

import 'routes.dart';
import 'shared/shared.dart';

@Component(
  selector: 'app-root',
  templateUrl: 'app_component.html',
  directives: [routerDirectives, FooterComponent, HeaderComponent],
  exports: [Routes],
)
class AppComponent {}
