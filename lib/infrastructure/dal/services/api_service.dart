import 'package:get/get.dart';

enum Method { POST, GET, PUT, DELETE, PATCH }

class ApiService extends GetConnect implements GetxService {
  final String baseUrl;
  late Map<String, String> _headers;

  ApiService({required this.baseUrl}) {
    _headers = {
      'Content-Type': 'application/json',
    };
    httpClient.baseUrl = baseUrl;
  }

  Future<dynamic> reqst({
    required String url,
    Method method = Method.GET,
    Map<String, dynamic>? params,
    Map<String, dynamic>? queryParams,
    String? authToken,
  }) async {
    Response response;
    try {
      switch (method) {
        case Method.POST:
          response = await post(url, params,
              headers: {
                'Content-Type': 'application/json',
                'Authorization': authToken ?? '',
              },
              query: queryParams);
          break;
        case Method.DELETE:
          response = await delete(url, headers: _headers, query: queryParams);
          break;
        case Method.PATCH:
          response = await patch(
            url,
            params,
            query: queryParams,
            headers: {
              'Content-Type': 'application/x-www-form-urlencoded',
            },
          );
          break;
        default:
          response = await get(url, query: queryParams, headers: {
            'Content-Type': 'application/json',
            'Authorization': authToken ?? '',
          });
          break;
      }
      return response;
    } catch (e) {
      throw Exception("Something went wrong: $e");
    }
  }

  void updateHeaders(String token) {
    _headers['Authorization'] = 'Bearer $token';
  }
}
