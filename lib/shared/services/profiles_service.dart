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
}
