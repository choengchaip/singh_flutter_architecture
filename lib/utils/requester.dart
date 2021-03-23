import 'dart:convert';
import 'package:http/http.dart' as http;

class Requester {
  static Map<String, String> _getRequesterHeader(
      Map<String, dynamic>? headers) {
    return {
      "x-timestamp": "2021-03-10 12:22:12",
      ...(headers ?? {}),
    };
  }

  static bool _isResponseError(http.Response response) {
    bool isResponseError = false;
    try {
      isResponseError =
          (int.parse(response.body) >= 400 && int.parse(response.body) <= 599);
    } catch (e) {
      isResponseError = false;
    }

    return (isResponseError ||
        (response.statusCode >= 400 && response.statusCode <= 599));
  }

  static Future<http.Response> get(String url, Map<String, dynamic> params,
      {Map<String, dynamic>? headers}) async {
    try {
      http.Response response = await http.get(
          Uri.parse(url).replace(queryParameters: params),
          headers: _getRequesterHeader(headers));
      if (_isResponseError(response)) {
        throw (json.decode(response.body));
      }
      return response;
    } catch (e) {
      throw (e);
    }
  }

  static Future<http.Response> post(String url, Map<String, dynamic> payload,
      {Map<String, dynamic>? headers}) async {
    try {
      http.Response response = await http.post(Uri.parse(url),
          body: payload, headers: _getRequesterHeader(headers));
      if (_isResponseError(response)) {
        throw (json.decode(response.body));
      }
      return response;
    } catch (e) {
      throw (e);
    }
  }

  static Future<http.Response> put(String url, Map<String, dynamic> payload,
      {Map<String, dynamic>? headers}) async {
    try {
      http.Response response = await http.put(Uri.parse(url),
          body: payload, headers: _getRequesterHeader(headers));
      if (_isResponseError(response)) {
        throw (json.decode(response.body));
      }
      return response;
    } catch (e) {
      throw (e);
    }
  }

  static Future<http.Response> delete(String url,
      {Map<String, dynamic>? payload, Map<String, dynamic>? headers}) async {
    try {
      http.Response response = await http.delete(Uri.parse(url),
          body: payload, headers: _getRequesterHeader(headers));
      if (_isResponseError(response)) {
        throw (json.decode(response.body));
      }
      return response;
    } catch (e) {
      throw (e);
    }
  }
}
