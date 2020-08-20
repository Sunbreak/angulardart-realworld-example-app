import 'dart:html';

class JwtService {
  String getToken() {
    return window.localStorage['jwtToken'];
  }

  void saveToken(String token) {
    window.localStorage['jwtToken'] = token;
  }

  void destroyToken() {
    window.localStorage.remove('jwtToken');
  }
}
