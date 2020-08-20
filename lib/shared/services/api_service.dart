import 'dart:convert';
import 'dart:html';

import 'package:http/http.dart' as http;

import 'jwt_service.dart';

const _api_url = 'https://conduit.productionready.io/api';

class ApiService {
  JwtService _jwtService;

  ApiService(this._jwtService);

  Map<String, String> setHeaders() {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (_jwtService.getToken() != null)
        'Authorization': 'Token ${_jwtService.getToken()}',
    };
  }

  dynamic _formatErrors(error) {
    return jsonDecode(error);
  }

  Stream<dynamic> post(String path, [dynamic body]) {
    var future = http
        .post(
      '$_api_url$path',
          body: body != null ? jsonEncode(body) : null,
          headers: setHeaders(),
        )
        .catchError(_formatErrors)
        .then((response) {
      // FIXME https://github.com/dart-lang/http/issues/461
      if (response.statusCode == HttpStatus.unprocessableEntity) {
        throw _formatErrors(response.body);
      }
      return jsonDecode(response.body);
    });
    return Stream.fromFuture(future);
  }

  Stream<dynamic> get(String path) {
    var future = http
        .get(
      '$_api_url$path',
      headers: setHeaders(),
    )
        .catchError(_formatErrors)
        .then((value) => jsonDecode(value.body));
    return Stream.fromFuture(future);
  }
}
