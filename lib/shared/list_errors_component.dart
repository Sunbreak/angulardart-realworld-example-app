import 'package:angular/angular.dart';

import 'models/models.dart';

@Component(
  selector: 'list-errors',
  templateUrl: 'list_errors_component.html',
  directives: [coreDirectives],
)
class ListErrorsComponent {
  List<String> _formattedErrors;

  @Input()
  set errors(Errors errorList) {
    _formattedErrors = [];

    if (errorList.errors != null) {
      var errors = errorList.errors as Map;
      for (var field in errors.keys) {
        _formattedErrors.add('$field ${errors[field]}');
      }
    }
  }

  List<String> get errorList => _formattedErrors;
}
