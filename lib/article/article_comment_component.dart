import 'dart:async';

import 'package:angdart_conduit/shared/shared.dart';
import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';

@Component(
  selector: 'article-comment',
  templateUrl: 'article_comment_component.html',
  directives: [routerDirectives],
  pipes: [DatePipe],
)
class ArticleCommentComponent implements OnInit {
  UserService _userService;

  ArticleCommentComponent(this._userService);

  @Input()
  Comment comment;

  final _deleteComment = StreamController<bool>();

  @Output()
  Stream<bool> get deleteComment => _deleteComment.stream;

  bool canModify = false;

  @override
  void ngOnInit() {
    _userService.currentUser.listen((userData) {
      canModify = userData.username == comment.author.username;
    });
  }

  void deleteClicked() {
    _deleteComment.add(true);
  }
}
