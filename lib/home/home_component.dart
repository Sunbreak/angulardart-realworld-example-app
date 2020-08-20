import 'package:angdart_conduit/shared/shared.dart';
import 'package:angular/angular.dart';

@Component(
  selector: 'home-page',
  templateUrl: 'home_component.html',
  styleUrls: ['home_component.css'],
  directives: [ShowAuthedDirective],
)
class HomeComponent {}
