import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';

import '../shared/shared.dart';
import 'no_auth_guard_service.dart';

@Component(
  selector: 'auth-page',
  templateUrl: 'auth_component.html',
  directives: [
    coreDirectives,
    routerDirectives,
    formDirectives,
    ListErrorsComponent
  ],
)
class AuthComponent with NoAuthGuard implements OnActivate {
  String authType = '';
  String title = '';
  Errors errors = Errors();
  bool isSubmitting = false;
  ControlGroup authForm;

  Router _router;
  UserService _userService;

  @override
  UserService get userService => _userService;

  AuthComponent(this._router, this._userService) {
    authForm = FormBuilder.controlGroup({
      'email': Control<String>('', Validators.required),
      'password': Control<String>('', Validators.required),
    });
  }

  @override
  void onActivate(RouterState previous, RouterState current) {
    authType = Uri.parse(current.path).pathSegments.last;
    title = authType == 'login' ? 'Sign In' : 'Sign Up';
    if (authType == 'register') {
      authForm.addControl('username', Control<String>('', Validators.required));
    }
  }

  submitForm() {
    isSubmitting = true;
    errors = Errors();

    var credentials = authForm.value;
    _userService.attemptAuth(authType, credentials).listen((event) {
      _router.navigateByUrl('/');
    }).onError((error) {
      errors = Errors.fromJson(error);
      isSubmitting = false;
    });
  }
}
