import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:mca_official_flutter_sdk/src/Constants/custom_string.dart';
import 'package:mca_official_flutter_sdk/src/constants/custom_colors.dart';
import 'package:mca_official_flutter_sdk/src/models/product_categories_model.dart';
import 'package:mca_official_flutter_sdk/src/models/product_details_model.dart';
import 'package:mca_official_flutter_sdk/src/screens/product_details/product_details_screen.dart';
import 'package:mca_official_flutter_sdk/src/utils/spacers.dart';
import 'package:mca_official_flutter_sdk/src/widgets/custom_button.dart';
import 'package:mca_official_flutter_sdk/src/widgets/custom_text_widget.dart';
import 'package:mca_official_flutter_sdk/src/widgets/product_details_container.dart';

void showPlanDetailsBottomSheet(
  BuildContext context, {
  // required String title,
  // required String productName,
  // required String periodOfCover,
  // required String formattedPrice,
  // required String price,
  required ProductCategoriesModel productCategory,
  required ProductDetailsModel? productDetails,
  // ProviderLiteModel? provider,
  // required bool isDynamicPrice,
  // String? keyBenefits,
  // String? howToClaim,
  // String? howItWorks,
  // String? fullBenefits,
  String? okText,
  String? cancelText,
  Color? iconColor,
  Widget? customIcon,
  Function()? onOkPressed,
  Function()? onCancelPressed,
  bool isDismissible = true,
  bool enableDrag = false,
  bool showButton = false,

// StringUtils.getProductPrice(
//                                         ref
//                                                 .watch(
//                                                     productListProvider)?[index]
//                                                 .price ??
//                                             "",
//                                         ref
//                                                 .watch(
//                                                     productListProvider)?[index]
//                                                 .isDynamicPricing ??
//                                             false)
}) {
  showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.r),
      ),
      backgroundColor: Colors.white,
      elevation: 0,
      // scrollControlDisabledMaxHeightRatio: 300,
      // barrierColor: Colors.white,

      context: context,
      builder: (context) {
        return PopScope(
          canPop: isDismissible ? false : true,
          onPopInvoked: (didPop) {
            if (didPop) {
              return;
            }
          },
          child: LayoutBuilder(builder: (context, constraints) {
            return ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: 1.sh * 0.7, // max height constraint
              ),
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    verticalSpacer(30.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          semiBoldText(
                              "${productCategory.name ?? ""} Insurance",
                              fontSize: 16.sp),
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: SvgPicture.asset(
                              ConstantString.xMark,
                              package: 'mca_official_flutter_sdk',
                            ),
                          ),
                        ],
                      ),
                    ),
                    verticalSpacer(30.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: const ProductDetailsContainer(
                          // productName: productName,
                          // periodOfCover: periodOfCover,
                          // formattedPrice: formattedPrice,
                          // price: price,
                          // provider: provider,
                          // isDynamicPrice: isDynamicPrice,
                          // productCategory: productCategory,
                          ),
                    ),
                    verticalSpacer(30.h),
                    Flexible(
                      fit: FlexFit.loose,
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              productDetails?.keyBenefits == null
                                  ? const SizedBox.shrink()
                                  : HtmlWidget(
                                      productDetails!.keyBenefits!,
                                    ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    verticalSpacer(20),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: CustomButton(
                              title: "Go back",
                              buttonColor: CustomColors.dividerGreyColor,
                              textColor: CustomColors.backTextColor,
                              fontSize: 14.sp,
                              onTap: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                          horizontalSpacer(10.w),
                          Expanded(
                            flex: 2,
                            child: CustomButton(
                              title: "Continue",
                              onTap: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ProductDetailsScreen(
                                              // title: title,
                                              // productName:
                                              //     productDetails?.name ?? "",
                                              // periodOfCover: StringUtils
                                              //     .getProviderPeriodOfCover(
                                              //   productDetails?.coverPeriod ??
                                              //       "",
                                              // ),
                                              // formattedPrice:
                                              //     StringUtils.getProductPrice(
                                              //         productDetails?.price ??
                                              //             "",
                                              //         productDetails
                                              //                 ?.isDynamicPricing ??
                                              //             false),
                                              // price:
                                              //     productDetails?.price ?? "",
                                              // provider:
                                              //     productDetails?.provider,
                                              // isDynamicPrice: productDetails
                                              //         ?.isDynamicPricing ??
                                              //     false,
                                              // howToClaim:
                                              //     productDetails?.howToClaim,
                                              // howItWorks:
                                              //     productDetails?.howItWorks,
                                              // fullBenefits:
                                              //     productDetails?.fullBenefits,
                                              // keyBenefits:
                                              //     productDetails?.keyBenefits,

                                              // productCategory: productCategory,
                                              productDetails: productDetails,
                                            )));
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    verticalSpacer(MediaQuery.of(context).padding.bottom + 10),
                  ],
                ),
              ),
            );
          }),
        );
      });
}
