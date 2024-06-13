import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mca_official_flutter_sdk/src/models/business_data_model.dart';
import 'package:mca_official_flutter_sdk/src/models/product_categories_model.dart';
import 'package:mca_official_flutter_sdk/src/models/product_details_model.dart';
import 'package:mca_official_flutter_sdk/src/models/sdk_initialization_response.dart';
import 'package:mca_official_flutter_sdk/src/models/ussd_provider_model.dart';
import 'package:mca_official_flutter_sdk/src/utils/enum.dart';
import 'package:mca_official_flutter_sdk/src/utils/environment_config.dart';

enum BuildEnvironment { production, development }

class Global {
  static BuildContext? context;
  static late EnvironmentVariables environmentVariables;
  static List<String> prefixList = [];
  static String instanceId = "";
  static String publicKey = "";
  static String reference = "";
  static PaymentOption paymentOption = PaymentOption.gateway;
  static List<String> productId = [];
  static String? brandColorPrimary;
  static String? email;
  static String? phone;
  static Map<String, dynamic> form = {};
  static BusinessDetailsModel? businessDetails;
  static List<UssdProviderModel> ussdProviders = [];
  static bool isContactFieldsEditable = true;
  static bool isTest = true;
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static Function? onComplete = () {
    print("Done");
  };
  static Function? onClose = () {
    print("Done");
  };
}

final paymentOptionProvider =
    StateProvider<PaymentOption>((ref) => PaymentOption.gateway);
// final referenceProvider = StateProvider<String?>((ref) => null);
final transactionTypeProvider =
    StateProvider<TransactionType>((ref) => TransactionType.purchase);
final publicKeyProvider = StateProvider<String?>((ref) => null);
final onCompleteProvider = StateProvider<Function?>((ref) => null);
final onCloseProvider = StateProvider<Function?>((ref) => null);
final isContactFieldsEditableProvider = StateProvider<bool>((ref) => true);
// final formProvider = StateProvider<Map<String, dynamic>>((ref) => {});

final initResponseProvider =
    StateProvider<SdkInitializationResponse?>((ref) => null);

final productCategoriesProvider =
    StateProvider<List<ProductCategoriesModel>>((ref) => []);

final businessDetailsProvider =
    StateProvider<BusinessDetailsModel?>((ref) => null);

//Filter
final filterFromNairaProvider = StateProvider<String?>((ref) => null);
final filterToNairaProvider = StateProvider<String?>((ref) => null);
final filterFromPercentProvider = StateProvider<String?>((ref) => null);
final filterToPercentProvider = StateProvider<String?>((ref) => null);

//FormFIeds
final formDataProvider = StateProvider<Map<String, dynamic>>((ref) {
  return Map<String, dynamic>.from(Global.form);
});
final urlFormDataProvider = StateProvider<Map<String, dynamic>>((ref) => {});

final imageListProvider = StateProvider<List<Map<String, File?>>>((ref) => []);
final imagePlaceholderProvider =
    StateProvider<Map<String, String>>((ref) => {});

final productPriceProvider = StateProvider<int>((ref) => 0);

final autoValidateProvider = StateProvider<bool>((ref) => false);

final selectedBankProvider = StateProvider<UssdProviderModel?>((ref) => null);

///Selected Product
final selectedProductCategoryProvider =
    StateProvider<ProductCategoriesModel?>((ref) => null);

final selectedProductDetailsProvider =
    StateProvider<ProductDetailsModel?>((ref) => null);

///Global Item Pair
final globalItemListProvider =
    StateProvider<List<Map<String, dynamic>>>((ref) => []);

final globalItemPairProvider = StateProvider<Map<String, dynamic>>((ref) => {});

//
//ERROR VALIDATION

final formErrorsProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final shouldValidateImageplusDrop = StateProvider<bool>((ref) => false);
