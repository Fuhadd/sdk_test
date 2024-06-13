// ignore_for_file: prefer_typing_uninitialized_variables, unused_local_variable

import 'package:mca_official_flutter_sdk/src/constants/api_endpoints.dart';

import '../api/generic_response.dart';
import '../api_config/api_service.dart';
import '../api_config/local_cache.dart';

abstract class UserRepository {
  Future<GenericResponse> signIn(String email, String password);
}

class UserRepositoryImpl extends ApiService implements UserRepository {
  late LocalCache cache;

  UserRepositoryImpl({
    required this.cache,
    required String baseUrl,
  }) : super(baseUrl: baseUrl);

  @override
  Future<GenericResponse> signIn(String email, String password) async {
    var requestData = {"email": email, "password": password};
    var res = await post(ApiEndpoints.initialiseSdk,
        data: requestData, useToken: false);
    return GenericResponse.fromJson(res);
  }
}
