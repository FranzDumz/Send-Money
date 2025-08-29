import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:crypto/crypto.dart';
import 'package:dio/io.dart';

import 'network_strings.dart';

class ApiClient {
  final Dio _dio;

  ApiClient({String? baseUrl})
      : _dio = Dio(
          BaseOptions(
            baseUrl: NetworkStrings.baseUrl,
            connectTimeout: const Duration(seconds: 10),
            receiveTimeout: const Duration(seconds: 10),
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
          ),
        ) {
    _dio.interceptors.add(LogInterceptor(
      request: true,
      requestBody: true,
      responseBody: true,
      error: true,
    ));

    //  _setupSslPinning();
  }

  // SSL Pinning
  void _setupSslPinning() {
    final adapter = _dio.httpClientAdapter;

    if (adapter is IOHttpClientAdapter) {
      adapter.createHttpClient = () {
        final client = HttpClient();

        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) {
          final hash = sha256.convert(cert.der).toString();
          final isValid = hash == NetworkStrings.certificateSha256;
          if (!isValid) {
            log(' SSL pinning failed: $hash');
          } else {
            log(' SSL pinning passed');
          }
          return isValid;
        };

        return client;
      };
    }
  }

  // --------------------- Requests ---------------------
  Future<Response> get(String endpoint,
          {Map<String, dynamic>? queryParameters, Options? options}) =>
      _dio.get(endpoint, queryParameters: queryParameters, options: options);

  Future<Response> post(String endpoint, {dynamic data, Options? options}) =>
      _dio.post(endpoint, data: data, options: options);

  Future<Response> put(String endpoint, {dynamic data, Options? options}) =>
      _dio.put(endpoint, data: data, options: options);

  Future<Response> delete(String endpoint, {dynamic data, Options? options}) =>
      _dio.delete(endpoint, data: data, options: options);

  // ----------------- Auth headers -----------------
  void setAuthToken(String token) {
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  void clearAuthToken() {
    _dio.options.headers.remove('Authorization');
  }
}
