import 'package:rxdart/rxdart.dart';

import '../shared.dart';

class UserService {
  ApiService _apiService;

  BehaviorSubject<User> _currentUserSubject = BehaviorSubject<User>();

  Stream<User> get currentUser => _currentUserSubject.distinct();

  UserService(this._apiService);

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

  void setAuth(User user) {
    _currentUserSubject.add(user);
  }
}
