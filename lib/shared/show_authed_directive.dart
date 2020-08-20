import 'package:angular/angular.dart';

import 'shared.dart';

@Directive(
  selector: '[showAuthed]',
)
class ShowAuthedDirective implements OnInit {
  TemplateRef _templateRef;

  UserService _userService;

  ViewContainerRef _viewContainer;

  ShowAuthedDirective(
      this._templateRef, this._userService, this._viewContainer);

  bool condition;

  @Input()
  set showAuthed(bool condition) {
    this.condition = condition;
  }

  @override
  void ngOnInit() {
    _userService.isAuthenticated.listen((isAuthenticated) {
      if (isAuthenticated && condition || !isAuthenticated && !condition) {
        _viewContainer.createEmbeddedView(this._templateRef);
      } else {
        _viewContainer.clear();
      }
    });
  }
}
