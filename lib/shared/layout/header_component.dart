import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';

import '../shared.dart';

@Component(
  selector: 'layout-header',
  templateUrl: 'header_component.html',
  directives: [coreDirectives, routerDirectives, ShowAuthedDirective],
)
class HeaderComponent implements OnInit {
  UserService _userService;

  HeaderComponent(this._userService);

  User currentUser;

  @override
  void ngOnInit() {
    _userService.currentUser.listen((userData) {
      currentUser = userData;
    });
  }
}
