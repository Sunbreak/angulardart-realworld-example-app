import 'package:angdart_conduit/shared/services/api_service.dart';

class TagsService {
  ApiService _apiService;

  TagsService(this._apiService);

  Stream<List<String>> getAll() {
    return _apiService.get('/tags').map((data) {
      var jsonList = (data as Map)['tags'] as List;
      return jsonList.cast();
    });
  }
}
