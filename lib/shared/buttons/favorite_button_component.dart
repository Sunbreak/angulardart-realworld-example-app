import 'dart:async';

import 'package:angdart_conduit/shared/shared.dart';
import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';

@Component(
  selector: 'favorite-button',
  templateUrl: 'favorite_button_component.html',
  directives: [coreDirectives],
)
class FavoriteButtonComponent {
  Router _router;

  ArticlesService _articlesService;

  UserService _userService;

  FavoriteButtonComponent(
      this._router, this._articlesService, this._userService);

  Article _article;

  Article get article => _article;

  @Input()
  set article(Article article) {
    _article = article;
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
      'btn-outline-secondary': !article.favorited,
      'btn-secondary': article.favorited,
    };
  }

  void toggleFavorite() async {
    isSubmitting = true;

    var authenticated = await _userService.isAuthenticated.first;
    if (!authenticated) {
      _router.navigateByUrl('/login');
      return;
    }

    try {
      if (!article.favorited) {
        await _articlesService.favorite(article.slug).first;
      } else {
        await _articlesService.unfavorite(article.slug).first;
      }
      _onToggle.add(!article.favorited);
    } catch (e) {
      // nothing
    } finally {
      isSubmitting = false;
    }
  }
}
