import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mca_official_flutter_sdk/src/dialogs_and_popups/dialogs.dart';
import 'package:mca_official_flutter_sdk/src/globals.dart';
import 'package:mca_official_flutter_sdk/src/models/product_details_model.dart';
import 'package:mca_official_flutter_sdk/src/models/sdk_initialization_response.dart';
import 'package:mca_official_flutter_sdk/src/screens/initialization/welcome_screen.dart';
import 'package:mca_official_flutter_sdk/src/screens/product_details/product_details_screen.dart';
import '../../data/view_model/base_change_notifier.dart';

class InitViewModel extends BaseChangeNotifier {
  Future<void> initialiseSdk(WidgetRef ref, BuildContext context) async {
    try {
      final res = await initRepository.initialiseSdk();

      if (res.responseCode == 1) {
        SdkInitializationResponse data =
            SdkInitializationResponse.fromJson(res.data);

        ref.read(initResponseProvider.notifier).state = data;

        data.productCategories?.sort((a, b) {
          if (a.name == null && b.name == null) return 0;
          if (a.name == null) return 1;
          if (b.name == null) return -1;
          return a.name!.compareTo(b.name!);
        });
        ref.read(productCategoriesProvider.notifier).state =
            data.productCategories ?? [];

        ref.read(businessDetailsProvider.notifier).state = data.businessDetails;
        Global.brandColorPrimary = data.businessDetails?.brandColorPrimary;
        Global.businessDetails = data.businessDetails;
        // Global.isDefaultLogo = data.businessDetails?.isDefaultLogo ?? true;

        // await navigationHandler.pushReplacement(const WelcomeScreen());

        /////IMPRTANT HEREEE
        ///
        ///
        ///
        ///
        notifyListeners();

        if (Global.productId.length == 1) {
          final res = await productRepository.getProductDetails(
            categoryId: data.productCategories?[0].id ?? "",
            // providerId: providerId,
          );

          if (res.responseCode == 1) {
            List<ProductDetailsModel>? products = res.data["products"] != null
                ? (res.data["products"] as List)
                    .map((e) => ProductDetailsModel.fromJson(e))
                    .toList()
                : [];
            products.sort((a, b) {
              if (a.name == null && b.name == null) return 0;
              if (a.name == null) return 1;
              if (b.name == null) return -1;
              return a.name!.compareTo(b.name!);
            });

            ref.read(selectedProductCategoryProvider.notifier).state =
                data.productCategories?[0];
            if (products.isNotEmpty) {
              ref.read(selectedProductDetailsProvider.notifier).state =
                  products[0];

              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProductDetailsScreen(
                            // title: title,

                            productDetails: products[0],
                          )));
            }
          } else {
            CustomToast.showErrorMessage(context, res.errors.toString());
          }

          // ..
          // } else {
          //   // Navigator.pushReplacement(context,
          //   //     MaterialPageRoute(builder: (context) => const WelcomeScreen()));
          // navigationHandler.pushReplacementNamed(WelcomeScreen.routeName);
          // Navigator.pushReplacement(context,
          //     MaterialPageRoute(builder: (context) => const WelcomeScreen()));
        }
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const WelcomeScreen()));

        // navigationHandler.pushReplacementNamed(WelcomeScreen.routeName);

        // return data;
      } else {
        CustomToast.showErrorMessage(context, res.errors.toString());

        // Dialogs.showErrorMessage(res.errors.toString());
        // localCache.removeFromLocalCache(ConstantString.dashboardData);
        // GenericDialog()
        //     .showSimplePopup(type: InfoBoxType.warning, content: res.message);
      }

      /////IMPRTANT HEREEE
      ///
      ///
    } catch (e, stacktrace) {
      log(e.toString());
      log(stacktrace.toString());
      CustomToast.showErrorMessage(context, e.toString());
      // Dialogs.showErrorMessage(e.toString());
    }
    // Dialogs.showErrorMessage("Failed to initialize, Please try again");
  }
}
