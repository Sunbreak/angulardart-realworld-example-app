import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';

import '../shared/shared.dart';

@Component(
  selector: 'settings-page',
  templateUrl: 'settings_component.html',
  directives: [formDirectives, ListErrorsComponent],
)
class SettingsComponent with AuthGuard implements OnInit {
  User user = User();
  ControlGroup settingsForm;
  Errors errors = Errors();
  bool isSubmitting = false;

  Router _router;

  UserService _userService;

  @override
  UserService get userService => _userService;

  SettingsComponent(this._router, this._userService) {
    settingsForm = FormBuilder.controlGroup({
      'image': Control<String>(''),
      'username': Control<String>(''),
      'bio': Control<String>(''),
      'email': Control<String>(''),
      'password': Control<String>(''),
    });
  }

  @override
  void ngOnInit() {
    var currentUser = _userService.getCurrentUser();
    user.email = currentUser.email;
    user.token = currentUser.token;
    user.username = currentUser.username;
    user.bio = currentUser.bio;
    user.image = currentUser.image;

    settingsForm.updateValue({
      ...(user.toJson()..remove('token')),
      'password': '',
    });
  }

  void logout() {
    _userService.purgeAuth();
    _router.navigateByUrl('/');
  }

  void submitForm() {
    isSubmitting = true;

    updateUser(settingsForm.value);
    _userService.update(user).listen((updatedUser) {
      _router.navigateByUrl('/profile/${updatedUser.username}');
    }).onError((error) {
      errors = Errors.fromJson(error);
      isSubmitting = false;
    });
  }

  void updateUser(Map<String, dynamic> value) {
    user.email = value['email'];
    user.username = value['username'];
    user.bio = value['bio'];
    user.image = value['image'];
  }
}
