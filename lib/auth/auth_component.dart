import 'dart:convert';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';

@Component(
  selector: 'auth-page',
  templateUrl: 'auth_component.html',
  directives: [coreDirectives, routerDirectives, formDirectives],
)
class AuthComponent implements OnActivate {
  String authType = '';
  String title = '';
  bool isSubmitting = false;
  ControlGroup authForm;

  AuthComponent() {
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
    print(jsonEncode(authForm.value));
  }
}
