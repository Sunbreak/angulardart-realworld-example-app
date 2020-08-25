import 'package:angdart_conduit/shared/shared.dart';
import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';

@Component(
  selector: 'profile-favorites',
  templateUrl: 'profile_favorites_component.html',
  directives: [ArticleListComponent],
)
class ProfileFavoritesComponent implements OnActivate {
  Router _router;

  ProfilesService _profilesService;

  ProfileFavoritesComponent(this._router, this._profilesService);

  ArticleListConfig favoritesConfig = ArticleListConfig();

  @override
  void onActivate(RouterState previous, RouterState current) async {
    var username = current.parameters['username'];
    try {
      var profile = await _profilesService.get(username).first;
      favoritesConfig = ArticleListConfig()
        ..filters = ArticleListConfigFilters(favorited: profile.username);
    } catch (e) {
      _router.navigateByUrl('/');
    }
  }
}
