import 'package:angdart_conduit/shared/shared.dart';

import 'api_service.dart';

class ArticlesService {
  ApiService _apiService;

  ArticlesService(this._apiService);

  Stream<Article> get(String slug) {
    return _apiService.get('/articles/$slug').map((data) {
      var json = (data as Map)['article'];
      return Article.fromJson(json);
    });
  }

  Stream<Article> save(Article article) {
    if (article.slug != null) {
      return _apiService.put('/articles/${article.slug}', {
        'article': article.toJson(),
      }).map((data) {
        var json = (data as Map)['article'];
        return Article.fromJson(json);
      });
    } else {
      return _apiService.post('/articles/', {
        'article': article.toJson(),
      }).map((data) {
        var json = (data as Map)['article'];
        return Article.fromJson(json);
      });
    }
  }
}
