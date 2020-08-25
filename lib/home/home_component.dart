import 'package:angdart_conduit/shared/shared.dart';
import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';

@Component(
  selector: 'home-page',
  templateUrl: 'home_component.html',
  styleUrls: ['home_component.css'],
  directives: [coreDirectives, ShowAuthedDirective, ArticleListComponent],
)
class HomeComponent implements OnInit {
  Router _router;

  UserService _userService;

  TagsService _tagsService;

  HomeComponent(this._router, this._userService, this._tagsService);

  bool isAuthenticated;
  ArticleListConfig listConfig = ArticleListConfig();
  List<String> tags = [];
  bool tagsLoaded = false;

  @override
  void ngOnInit() {
    _userService.isAuthenticated.listen((authenticated) {
      isAuthenticated = authenticated;
      setListTo(authenticated ? 'feed' : 'all');
    });

    _tagsService.getAll().listen((tags) {
      this.tags = tags;
      tagsLoaded = true;
    });
  }

  void setListTo([String type = '', String key, dynamic value]) {
    if (type == 'feed' && !isAuthenticated) {
      _router.navigateByUrl('/login');
      return;
    }

    listConfig = ArticleListConfig()
      ..type = type
      ..filters = ArticleListConfigFilters.fromJson({
        if (key != null && value != null) key: value,
      });
  }
}
