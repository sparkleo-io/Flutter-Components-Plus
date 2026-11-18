import 'dart:convert';
import 'package:http/http.dart' as http;
import 'logging_service.dart';

/// HTTP service for making API requests
class FCPHttpService {
  FCPHttpService._();

  static final FCPHttpService _instance = FCPHttpService._();
  static FCPHttpService get instance => _instance;

  final http.Client _client = http.Client();
  String? _baseUrl;
  final Map<String, String> _defaultHeaders = {
    'Content-Type': 'application/json',
  };

  final List<FCPHttpInterceptor> _interceptors = [];

  /// Set base URL for all requests
  void setBaseUrl(String baseUrl) {
    _baseUrl = baseUrl;
  }

  /// Set default headers for all requests
  void setDefaultHeaders(Map<String, String> headers) {
    _defaultHeaders.addAll(headers);
  }

  /// Add interceptor
  void addInterceptor(FCPHttpInterceptor interceptor) {
    _interceptors.add(interceptor);
  }

  /// Remove interceptor
  void removeInterceptor(FCPHttpInterceptor interceptor) {
    _interceptors.remove(interceptor);
  }

  /// Clear all interceptors
  void clearInterceptors() {
    _interceptors.clear();
  }

  /// Make GET request
  Future<FCPHttpResponse> get(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    return _makeRequest(
      'GET',
      endpoint,
      headers: headers,
      queryParameters: queryParameters,
    );
  }

  /// Make POST request
  Future<FCPHttpResponse> post(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
    dynamic body,
  }) async {
    return _makeRequest(
      'POST',
      endpoint,
      headers: headers,
      queryParameters: queryParameters,
      body: body,
    );
  }

  /// Make PUT request
  Future<FCPHttpResponse> put(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
    dynamic body,
  }) async {
    return _makeRequest(
      'PUT',
      endpoint,
      headers: headers,
      queryParameters: queryParameters,
      body: body,
    );
  }

  /// Make PATCH request
  Future<FCPHttpResponse> patch(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
    dynamic body,
  }) async {
    return _makeRequest(
      'PATCH',
      endpoint,
      headers: headers,
      queryParameters: queryParameters,
      body: body,
    );
  }

  /// Make DELETE request
  Future<FCPHttpResponse> delete(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    return _makeRequest(
      'DELETE',
      endpoint,
      headers: headers,
      queryParameters: queryParameters,
    );
  }

  /// Make HTTP request
  Future<FCPHttpResponse> _makeRequest(
    String method,
    String endpoint, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
    dynamic body,
  }) async {
    try {
      // Build URL
      String url = endpoint;
      if (_baseUrl != null && !endpoint.startsWith('http')) {
        url = '$_baseUrl$endpoint';
      }

      // Add query parameters
      if (queryParameters != null && queryParameters.isNotEmpty) {
        final uri = Uri.parse(url);
        final queryParams = Map<String, String>.from(uri.queryParameters);
        queryParams.addAll(
          queryParameters.map((key, value) => MapEntry(key, value.toString())),
        );
        url = uri.replace(queryParameters: queryParams).toString();
      }

      // Merge headers
      final requestHeaders = Map<String, String>.from(_defaultHeaders);
      if (headers != null) {
        requestHeaders.addAll(headers);
      }

      // Run request interceptors
      final interceptedRequest = await _runRequestInterceptors(
        FCPHttpRequest(
          method: method,
          url: url,
          headers: requestHeaders,
          body: body,
        ),
      );

      // Make HTTP request
      http.Response response;
      switch (method.toUpperCase()) {
        case 'GET':
          response = await _client.get(
            Uri.parse(interceptedRequest.url),
            headers: interceptedRequest.headers,
          );
          break;
        case 'POST':
          response = await _client.post(
            Uri.parse(interceptedRequest.url),
            headers: interceptedRequest.headers,
            body: interceptedRequest.body is String
                ? interceptedRequest.body
                : jsonEncode(interceptedRequest.body),
          );
          break;
        case 'PUT':
          response = await _client.put(
            Uri.parse(interceptedRequest.url),
            headers: interceptedRequest.headers,
            body: interceptedRequest.body is String
                ? interceptedRequest.body
                : jsonEncode(interceptedRequest.body),
          );
          break;
        case 'PATCH':
          response = await _client.patch(
            Uri.parse(interceptedRequest.url),
            headers: interceptedRequest.headers,
            body: interceptedRequest.body is String
                ? interceptedRequest.body
                : jsonEncode(interceptedRequest.body),
          );
          break;
        case 'DELETE':
          response = await _client.delete(
            Uri.parse(interceptedRequest.url),
            headers: interceptedRequest.headers,
            body: interceptedRequest.body is String
                ? interceptedRequest.body
                : jsonEncode(interceptedRequest.body),
          );
          break;
        default:
          throw FCPHttpException('Unsupported HTTP method: $method');
      }

      // Create response object
      final httpResponse = FCPHttpResponse(
        statusCode: response.statusCode,
        headers: response.headers,
        body: response.body,
        url: response.request?.url.toString() ?? url,
      );

      // Run response interceptors
      final interceptedResponse = await _runResponseInterceptors(httpResponse);

      // Check for HTTP errors
      if (interceptedResponse.statusCode >= 400) {
        throw FCPHttpException(
          'HTTP ${interceptedResponse.statusCode}: ${interceptedResponse.body}',
          statusCode: interceptedResponse.statusCode,
        );
      }

      return interceptedResponse;
    } catch (e) {
      if (e is FCPHttpException) {
        rethrow;
      }
      throw FCPHttpException('Request failed: $e');
    }
  }

  /// Run request interceptors
  Future<FCPHttpRequest> _runRequestInterceptors(FCPHttpRequest request) async {
    FCPHttpRequest interceptedRequest = request;
    for (final interceptor in _interceptors) {
      interceptedRequest = await interceptor.onRequest(interceptedRequest);
    }
    return interceptedRequest;
  }

  /// Run response interceptors
  Future<FCPHttpResponse> _runResponseInterceptors(
    FCPHttpResponse response,
  ) async {
    FCPHttpResponse interceptedResponse = response;
    for (final interceptor in _interceptors) {
      interceptedResponse = await interceptor.onResponse(interceptedResponse);
    }
    return interceptedResponse;
  }

  /// Dispose the HTTP client
  void dispose() {
    _client.close();
  }
}

/// HTTP request model
class FCPHttpRequest {
  const FCPHttpRequest({
    required this.method,
    required this.url,
    required this.headers,
    this.body,
  });

  final String method;
  final String url;
  final Map<String, String> headers;
  final dynamic body;
}

/// HTTP response model
class FCPHttpResponse {
  const FCPHttpResponse({
    required this.statusCode,
    required this.headers,
    required this.body,
    required this.url,
  });

  final int statusCode;
  final Map<String, String> headers;
  final String body;
  final String url;

  /// Parse response body as JSON
  Map<String, dynamic> get jsonBody {
    try {
      return jsonDecode(body) as Map<String, dynamic>;
    } catch (e) {
      throw FCPHttpException('Failed to parse response as JSON: $e');
    }
  }

  /// Parse response body as list
  List<dynamic> get jsonList {
    try {
      return jsonDecode(body) as List<dynamic>;
    } catch (e) {
      throw FCPHttpException('Failed to parse response as JSON list: $e');
    }
  }

  /// Check if response is successful
  bool get isSuccess => statusCode >= 200 && statusCode < 300;

  /// Check if response is a redirect
  bool get isRedirect => statusCode >= 300 && statusCode < 400;

  /// Check if response is a client error
  bool get isClientError => statusCode >= 400 && statusCode < 500;

  /// Check if response is a server error
  bool get isServerError => statusCode >= 500;
}

/// HTTP interceptor interface
abstract class FCPHttpInterceptor {
  /// Called before making the request
  Future<FCPHttpRequest> onRequest(FCPHttpRequest request);

  /// Called after receiving the response
  Future<FCPHttpResponse> onResponse(FCPHttpResponse response);
}

/// HTTP exception
class FCPHttpException implements Exception {
  const FCPHttpException(this.message, {this.statusCode});

  final String message;
  final int? statusCode;

  @override
  String toString() => 'FCPHttpException: $message';
}

/// Authentication interceptor
class FCPAuthInterceptor implements FCPHttpInterceptor {
  const FCPAuthInterceptor({required this.token});

  final String token;

  @override
  Future<FCPHttpRequest> onRequest(FCPHttpRequest request) async {
    final headers = Map<String, String>.from(request.headers);
    headers['Authorization'] = 'Bearer $token';
    return FCPHttpRequest(
      method: request.method,
      url: request.url,
      headers: headers,
      body: request.body,
    );
  }

  @override
  Future<FCPHttpResponse> onResponse(FCPHttpResponse response) async {
    return response;
  }
}

/// Logging interceptor
class FCPLoggingInterceptor implements FCPHttpInterceptor {
  const FCPLoggingInterceptor({this.enabled = true});

  final bool enabled;

  @override
  Future<FCPHttpRequest> onRequest(FCPHttpRequest request) async {
    if (enabled) {
      FCPLoggingService.instance.logHttpRequest(
        request.method,
        request.url,
        data: request.body == null
            ? null
            : {'body': request.body.toString()},
      );
    }
    return request;
  }

  @override
  Future<FCPHttpResponse> onResponse(FCPHttpResponse response) async {
    if (enabled) {
      FCPLoggingService.instance.logHttpResponse(
        response.statusCode,
        response.url,
        data: {'body': response.body},
      );
    }
    return response;
  }
}
