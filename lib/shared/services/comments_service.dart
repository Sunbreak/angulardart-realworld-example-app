import '../shared.dart';
import 'api_service.dart';

class CommentsService {
  ApiService _apiService;

  CommentsService(this._apiService);

  Stream<List<Comment>> getAll(String slug) {
    return _apiService.get('/articles/$slug/comments').map((event) {
      var jsonList = (event as Map)['comments'] as List;
      return jsonList.map((json) => Comment.fromJson(json)).toList();
    });
  }

  Stream<Comment> add(String slug, String payload) {
    return _apiService.post('/articles/$slug/comments', {
      'comment': {
        'body': payload,
      },
    }).map((data) {
      var json = (data as Map)['comment'];
      return Comment.fromJson(json);
    });
  }

  Stream<void> destroy(int commentId, String articleSlug) {
    return _apiService.delete('/articles/$articleSlug/comments/$commentId');
  }
}
