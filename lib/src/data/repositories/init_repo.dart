// ignore_for_file: prefer_typing_uninitialized_variables, unused_local_variable

import 'package:mca_official_flutter_sdk/src/constants/api_endpoints.dart';
import 'package:mca_official_flutter_sdk/src/globals.dart';
import 'package:mca_official_flutter_sdk/src/utils/enum.dart';

import '../api/generic_response.dart';
import '../api_config/api_service.dart';
import '../api_config/local_cache.dart';

abstract class InitRepository {
  Future<GenericResponse> initialiseSdk(
      // {
      // required String publicKey,
      // PaymentOption? paymentOption,
      // String? reference,
      // }
      );
}

class InitRepositoryImpl extends ApiService implements InitRepository {
  late LocalCache cache;

  InitRepositoryImpl({
    required this.cache,
    required String baseUrl,
  }) : super(baseUrl: baseUrl);

  @override
  Future<GenericResponse> initialiseSdk(
      //   {
      //   // required String publicKey,
      //   // PaymentOption? paymentOption,
      //   // String? reference,
      // }
      ) async {
    var requestData = {
      "payment_option": Global.paymentOption.getName,
      "debit_wallet_reference":
          Global.reference.isEmpty ? null : Global.reference,
      "action": "purchase",
      "product_id": Global.productId,
    };
    var res = await post(ApiEndpoints.initialiseSdk,
        data: requestData, useToken: true);
    // printLargeString(res.toString());
    return GenericResponse.fromJson(res);

    //   if (productId!.isEmpty) {
    //   data = {
    //     "payment_option": paymentOption,
    //     "debit_wallet_reference": reference,
    //     "action": "purchase"
    //   };
    // } else {
    //   data = {
    //     "product_id": productId,
    //     "payment_option": paymentOption,
    //     "debit_wallet_reference": reference,
    //     "action": "purchase"
    //   };
    // }
    // print('=======> Init data $data');
    // print(publicKey);
    // return await ApiScheme.initialisePostRequest(
    //     url: '${getBaseUrl(publicKey)}' + _initialiseSdkUrl,
    //     data: data,
    //     token: publicKey);
  }
}

void printLargeString(String text) {
  const int chunkSize = 800; // You can adjust this size as needed
  for (int i = 0; i < text.length; i += chunkSize) {
    int end = (i + chunkSize < text.length) ? i + chunkSize : text.length;
    print(text.substring(i, end));
  }
}
