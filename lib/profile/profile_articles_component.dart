import 'package:angdart_conduit/shared/shared.dart';
import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';

@Component(
  selector: 'profile-articles',
  templateUrl: 'profile_articles_component.html',
  directives: [ArticleListComponent],
)
class ProfileArticlesComponent implements OnActivate {
  Router _router;

  ProfilesService _profilesService;

  ProfileArticlesComponent(this._router, this._profilesService);

  ArticleListConfig articlesConfig;

  @override
  void onActivate(RouterState previous, RouterState current) async {
    var username = current.parameters['username'];
    try {
      var profile = await _profilesService.get(username).first;
      articlesConfig = ArticleListConfig()
        ..filters = ArticleListConfigFilters(author: profile.username);
    } catch (e) {
      _router.navigateByUrl('/');
    }
  }
}
