import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';

@Component(
  selector: 'layout-footer',
  templateUrl: 'footer_component.html',
  directives: [routerDirectives],
  pipes: [commonPipes],
)
class FooterComponent {
  final today = DateTime.now();
}
