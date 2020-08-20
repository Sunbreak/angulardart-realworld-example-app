import 'package:rxdart/rxdart.dart';

import '../shared.dart';

class UserService {
  ApiService _apiService;

  JwtService _jwtService;

  BehaviorSubject<User> _currentUserSubject =
      BehaviorSubject<User>.seeded(User());

  Stream<User> get currentUser => _currentUserSubject.distinct();

  ReplaySubject<bool> _isAuthenticatedSubject = ReplaySubject<bool>(maxSize: 1);

  Stream<bool> get isAuthenticated => _isAuthenticatedSubject;

  UserService(this._apiService, this._jwtService);

  // Verify JWT in localstorage with server & load user's info.
  // This runs once on application startup.
  void populate() {
    // If JWT detected, attempt to get & store user's info
    if (_jwtService.getToken() != null) {
      _apiService.get('/user').listen((data) {
        setAuth(User.fromJson((data as Map)['user']));
      }).onError((error) {
        // Remove any potential remnants of previous auth states
        purgeAuth();
      });
    } else {
      purgeAuth();
    }
  }

  void setAuth(User user) {
    // Save JWT sent from server in localstorage
    _jwtService.saveToken(user.token);
    // Set current user data into observable
    _currentUserSubject.add(user);
    // Set isAuthenticated to true
    _isAuthenticatedSubject.add(true);
  }

  void purgeAuth() {
    // Remove JWT from localstorage
    _jwtService.destroyToken();
    // Set current user to an empty object
    _currentUserSubject.add(User());
    // Set auth status to false
    _isAuthenticatedSubject.add(false);
  }

  Stream<User> attemptAuth(String authType, Map<String, dynamic> credentials) {
    var route = authType == 'login' ? '/login' : '';
    return _apiService.post(
      '/users$route',
      {'user': credentials},
    ).map((data) {
      var user = User.fromJson((data as Map)['user']);
      setAuth(user);
      return user;
    });
  }
}
