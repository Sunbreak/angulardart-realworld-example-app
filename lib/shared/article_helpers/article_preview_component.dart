import 'package:angdart_conduit/shared/buttons/favorite_button_component.dart';
import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';

import '../shared.dart';

@Component(
  selector: 'article-preview',
  templateUrl: 'article_preview_component.html',
  directives: [coreDirectives, routerDirectives, FavoriteButtonComponent],
)
class ArticlePreviewComponent {
  @Input()
  Article article;

  void onToggleFavorite(bool favorited) {
    article.favorited = favorited;

    if (favorited) {
      article.favoritesCount++;
    } else {
      article.favoritesCount--;
    }
  }
}
