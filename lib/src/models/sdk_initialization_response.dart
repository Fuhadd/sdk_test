import 'package:mca_official_flutter_sdk/src/models/business_data_model.dart';
import 'package:mca_official_flutter_sdk/src/models/product_categories_model.dart';

class SdkInitializationResponse {
  final BusinessDetailsModel? businessDetails;
  final List<ProductCategoriesModel>? productCategories;

  SdkInitializationResponse({
    required this.businessDetails,
    required this.productCategories,
  });

  factory SdkInitializationResponse.fromJson(json) {
    return SdkInitializationResponse(
      businessDetails: BusinessDetailsModel.fromJson(json['businessDetails']),
      productCategories: json['product_categories'] != null
          ? (json['product_categories'] as List)
              .map((e) => ProductCategoriesModel.fromJson(e))
              .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'businessDetails': businessDetails?.toJson(),
      'product_categories': productCategories?.map((e) => e.toJson()).toList(),
    };
  }
}
