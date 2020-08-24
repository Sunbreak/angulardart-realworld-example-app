import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';

import '../shared.dart';

@Component(
  selector: 'article-meta',
  templateUrl: 'article_meta_component.html',
  directives: [routerDirectives],
  pipes: [DatePipe],
)
class ArticleMetaComponent {
  @Input()
  Article article;
}
