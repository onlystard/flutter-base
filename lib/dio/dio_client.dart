import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';

@injectable
class DioClient {
  DioClient() {
    _dio = Dio();
    // _dio.interceptors.add(getIt<TokenInterceptor>());
    _dio.options.baseUrl = dotenv.env['BASE_URL'] ?? '';
  }

  late final Dio _dio;

  Dio get dio => _dio;
}
