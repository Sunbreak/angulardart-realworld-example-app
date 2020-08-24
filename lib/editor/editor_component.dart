import 'package:angdart_conduit/shared/shared.dart';
import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';

@Component(
  selector: 'editor-page',
  templateUrl: 'editor_component.html',
  directives: [coreDirectives, formDirectives, ListErrorsComponent],
)
class EditorComponent with AuthGuard implements OnActivate {
  Article article = Article();
  ControlGroup articleForm;
  String tagField = '';
  Errors errors = Errors();
  bool isSubmitting = false;

  Router _router;

  ArticlesService _articlesService;

  UserService _userService;

  @override
  UserService get userService => _userService;

  EditorComponent(this._router, this._articlesService, this._userService) {
    articleForm = ControlGroup({
      'title': Control(''),
      'description': Control(''),
      'body': Control(''),
    });
  }

  @override
  void onActivate(RouterState previous, RouterState current) async {
    var slug = current.parameters['slug'];
    if (slug == null) return;

    Article article;
    try {
      article = await _articlesService.get(slug).first;
    } catch (error) {
      _router.navigateByUrl('/');
      return;
    }

    if (_userService.getCurrentUser().username != article.author.username) {
      _router.navigateByUrl('/');
    } else {
      patchValue(article);
    }
  }

  void patchValue(Article article) {
    this.article = article;
    var json = article.toJson();
    articleForm.updateValue({
      'title': json['title'],
      'description': json['description'],
      'body': json['body'],
    });
  }

  void addTag() {
    if (!article.tagList.contains(tagField)) {
      article.tagList.add(tagField);
    }
    tagField = '';
  }

  void removeTag(String tagName) {
    article.tagList.remove(tagName);
  }

  void updateArticle(Map<String, dynamic> value) {
    article = Article.fromJson({
      ...article.toJson(),
      ...value,
    });
  }

  void submitForm() async {
    isSubmitting = true;

    updateArticle(articleForm.value);

    try {
      var article = await _articlesService.save(this.article).first;
      _router.navigateByUrl('/editor/${article.slug}');
    } catch (error) {
      errors = Errors.fromJson(error as Map);
    } finally {
      isSubmitting = false;
    }
  }
}
