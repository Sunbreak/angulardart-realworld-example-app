import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';

import '../shared.dart';

@Component(
  selector: 'layout-header',
  templateUrl: 'header_component.html',
  directives: [routerDirectives, ShowAuthedDirective],
)
class HeaderComponent {}
