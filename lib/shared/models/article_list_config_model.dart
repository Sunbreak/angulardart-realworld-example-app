class ArticleListConfig {
  String type = 'all';

  ArticleListConfigFilters filters = ArticleListConfigFilters();
}

class ArticleListConfigFilters {
  String tag;
  String author;
  String favorited;
  int limit;
  int offset;

  ArticleListConfigFilters({
    this.tag,
    this.author,
    this.favorited,
    this.limit,
    this.offset,
  });

  factory ArticleListConfigFilters.fromJson(Map<String, dynamic> json) {
    return ArticleListConfigFilters(
      tag: json['tag'],
      author: json['author'],
      favorited: json['favorited'],
      limit: json['limit'],
      offset: json['offset'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (tag != null) 'tag': tag,
      if (author != null) 'author': author,
      if (favorited != null) 'favorited': favorited,
      if (limit != null) 'limit': limit,
      if (offset != null) 'offset': offset,
    };
  }
}
