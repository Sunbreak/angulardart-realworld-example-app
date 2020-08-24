import 'package:angdart_conduit/article/markdown_pipe.dart';
import 'package:angdart_conduit/shared/buttons/favorite_button_component.dart';
import 'package:angdart_conduit/shared/shared.dart';
import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';

import 'article_comment_component.dart';

@Component(
  selector: 'article-page',
  templateUrl: 'article_component.html',
  directives: [
    coreDirectives,
    routerDirectives,
    formDirectives,
    ShowAuthedDirective,
    FollowButtonComponent,
    FavoriteButtonComponent,
    ArticleCommentComponent,
  ],
  pipes: [MarkdownPipe],
)
class ArticleComponent implements OnInit, OnActivate {
  Article article = Article();
  User currentUser;
  bool canModify = false;
  List<Comment> comments = [];
  String commentField = '';
  Errors commentFormErrors = Errors();
  bool isSubmitting = false;
  bool isDeleting = false;

  Router _router;

  ArticlesService _articlesService;

  UserService _userService;

  CommentsService _commentService;

  ArticleComponent(this._router, this._articlesService, this._userService,
      this._commentService);

  @override
  void ngOnInit() {
    _userService.currentUser.listen((userData) {
      currentUser = userData;
      canModify = currentUser.username == article.author?.username;
    });
  }

  @override
  void onActivate(RouterState previous, RouterState current) async {
    var slug = current.parameters['slug'];
    if (slug == null) return;

    try {
      article = await _articlesService.get(slug).first;
      populateComments();
    } catch (error) {
      _router.navigateByUrl('/');
    }

    canModify = currentUser?.username == article.author.username;
  }

  void onToggleFavorite(bool favorited) {
    article.favorited = favorited;

    if (favorited) {
      article.favoritesCount++;
    } else {
      article.favoritesCount--;
    }
  }

  void onToggleFollowing(bool following) {
    article.author.following = following;
  }

  void deleteArticle() async {
    isDeleting = true;

    await _articlesService.destroy(article.slug).first;
    _router.navigateByUrl('/');
  }

  void populateComments() async {
    comments = await _commentService
        .getAll(article.slug)
        .first;
  }

  void addComment() async {
    isSubmitting = true;

    try {
      var comment = await _commentService
          .add(article.slug, commentField)
          .first;
      comments.insert(0, comment);
      commentField = '';
    } catch (error) {
      commentFormErrors = Errors.fromJson(error);
    } finally {
      isSubmitting = false;
    }
  }

  void onDeleteComment(Comment comment) async {
    await _commentService
        .destroy(comment.id, article.slug)
        .first;
    comments.remove(comment);
  }
}
