import 'dart:convert';
import 'dart:html';

import 'package:http/http.dart' as http;

class ApiService {
  Map<String, String> setHeaders() {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
  }

  dynamic _formatErrors(error) {
    return jsonDecode(error);
  }

  Stream<dynamic> post(String path, [dynamic body]) {
    var future = http
        .post(
          'https://conduit.productionready.io/api$path',
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
}
