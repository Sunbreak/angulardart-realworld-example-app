import 'package:angdart_conduit/shared/services/api_service.dart';

import '../shared.dart';

class ProfilesService {
  ApiService _apiService;

  ProfilesService(this._apiService);

  Stream<Profile> get(String username) {
    return _apiService.get('/profiles/$username').map((data) {
      var json = (data as Map)['profile'];
      return Profile.fromJson(json);
    });
  }

  Stream<Profile> follow(String username) {
    return _apiService.post('/profiles/$username/follow').map((data) {
      var json = (data as Map)['profile'];
      return Profile.fromJson(json);
    });
  }

  Stream<Profile> unfollow(String username) {
    return _apiService.delete('/profiles/$username/follow').map((data) {
      var json = (data as Map)['profile'];
      return Profile.fromJson(json);
    });
  }
}
