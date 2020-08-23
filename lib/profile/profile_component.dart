import 'package:angdart_conduit/shared/services/profiles_service.dart';
import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';

import '../shared/shared.dart';

@Component(
  selector: 'profile-page',
  templateUrl: 'profile_component.html',
  directives: [coreDirectives, routerDirectives],
)
class ProfileComponent implements OnInit, OnActivate {
  UserService _userService;

  ProfilesService _profilesService;

  Router _router;

  ProfileComponent(this._userService, this._profilesService, this._router);

  Profile profile;
  User currentUser;
  bool isUser;

  @override
  void ngOnInit() {
    _userService.currentUser.listen((userData) {
      currentUser = userData;
    });
  }

  @override
  void onActivate(RouterState previous, RouterState current) async {
    var username = current.parameters['username'];
    try {
      profile = await _profilesService.get(username).first;
      isUser = currentUser.username == profile.username;
    } catch (e) {
      _router.navigateByUrl('/');
    }
  }
}
