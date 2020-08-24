import 'dart:async';

import 'package:angdart_conduit/shared/services/services.dart';
import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';

import '../shared.dart';

@Component(
  selector: 'follow-button',
  templateUrl: 'follow_button_component.html',
  directives: [coreDirectives],
)
class FollowButtonComponent {
  UserService _userService;

  ProfilesService _profilesService;

  Router _router;

  FollowButtonComponent(this._userService, this._profilesService, this._router);

  Profile _profile;

  Profile get profile => _profile;

  @Input()
  set profile(Profile profile) {
    _profile = profile;
    setCurrentClasses();
  }

  final _onToggle = StreamController<bool>();

  @Output()
  Stream<bool> get onToggle => _onToggle.stream;

  bool _isSubmitting = false;

  bool get isSubmitting => _isSubmitting;

  set isSubmitting(bool isSubmitting) {
    _isSubmitting = isSubmitting;
    setCurrentClasses();
  }

  Map<String, bool> currentClasses = <String, bool>{};

  void setCurrentClasses() {
    currentClasses = <String, bool>{
      'disabled': isSubmitting,
      'btn-outline-secondary': !profile.following,
      'btn-secondary': profile.following,
    };
  }

  void toggleFollowing() async {
    isSubmitting = true;

    var authenticated = await _userService.isAuthenticated.first;
    if (!authenticated) {
      _router.navigateByUrl('/login');
      return;
    }

    try {
      if (!profile.following) {
        await _profilesService.follow(profile.username).first;
      } else {
        await _profilesService.unfollow(profile.username).first;
      }
      _onToggle.add(!profile.following);
    } catch (e) {
      // nothing
    } finally {
      isSubmitting = false;
    }
  }
}
