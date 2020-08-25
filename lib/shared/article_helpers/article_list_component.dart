import 'package:angular/angular.dart';

import '../shared.dart';

@Component(
  selector: 'article-list',
  templateUrl: 'article_list_component.html',
  styleUrls: ['article_list_component.css'],
  directives: [coreDirectives, ArticlePreviewComponent],
)
class ArticleListComponent {
  ArticleListConfig query;
  List<Article> results = [];
  bool loading = false;
  int currentPage = 1;
  List<int> totalPages = [1];

  ArticlesService _articlesService;

  ArticleListComponent(this._articlesService);

  @Input()
  int limit;

  @Input()
  set config(ArticleListConfig config) {
    if (config != null) {
      query = config;
      currentPage = 1;
      runQuery();
    }
  }

  void runQuery() async {
    loading = true;
    results = [];

    if (limit != null) {
      query.filters.limit = limit;
      query.filters.offset = limit * (currentPage - 1);
    }

    try {
      Map data = await _articlesService.query(query).first;
      List jsonList = data['articles'];
      results = jsonList.map((json) => Article.fromJson(json)).toList();

      int articlesCount = data['articlesCount'];
      totalPages = List.generate((articlesCount / limit).ceil(), (i) => i + 1);
    } finally {
      loading = false;
    }
  }

  void setPageTo(int pageNumber) {
    currentPage = pageNumber;
    runQuery();
  }
}
