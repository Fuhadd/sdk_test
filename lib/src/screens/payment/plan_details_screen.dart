import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:mca_official_flutter_sdk/src/Constants/custom_string.dart';
import 'package:mca_official_flutter_sdk/src/constants/custom_colors.dart';
import 'package:mca_official_flutter_sdk/src/globals.dart';
import 'package:mca_official_flutter_sdk/src/models/purchase_details_response.dart';
import 'package:mca_official_flutter_sdk/src/screens/form/second_form_screen.dart';
import 'package:mca_official_flutter_sdk/src/utils/custom_text_styles.dart';
import 'package:mca_official_flutter_sdk/src/utils/string_utils.dart';
import 'package:mca_official_flutter_sdk/src/widgets/custom_text_widget.dart';
import 'package:mca_official_flutter_sdk/src/utils/enum.dart';
import 'package:mca_official_flutter_sdk/src/utils/spacers.dart';
import 'package:mca_official_flutter_sdk/src/widgets/custom_appbar.dart';
import 'package:mca_official_flutter_sdk/src/widgets/custom_button.dart';
import 'package:mca_official_flutter_sdk/src/widgets/powered_by_footer.dart';
import 'package:mca_official_flutter_sdk/src/widgets/product_details_container.dart';

class PlanDetailsScreen extends StatefulHookConsumerWidget {
  // final String title;
  final PurchaseDetailsResponseModel purchaseDetails;
  const PlanDetailsScreen({
    super.key,
    // required this.title,
    required this.purchaseDetails,
  });

  @override
  ConsumerState<PlanDetailsScreen> createState() => _PlanDetailsScreenState();
}

class _PlanDetailsScreenState extends ConsumerState<PlanDetailsScreen> {
  SdkOptions selectedOption = SdkOptions.buy;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.whiteColor,
      body: SafeArea(
          child: Column(
        children: [
          verticalSpacer(20.h),
          CustomAppbar(
            showBackButton: false,
            onBackTap:
                Navigator.canPop(context) ? () => Navigator.pop(context) : null,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  verticalSpacer(10.h),
                  semiBoldText(
                    "Plan details",
                    fontSize: 20.sp,
                    color: CustomColors.darkTextColor,
                  ),

                  verticalSpacer(30.h),
                  const ProductDetailsContainer(
                      // productName: widget.productName,
                      // periodOfCover: widget.periodOfCover,
                      // formattedPrice: widget.formattedPrice,
                      // price: widget.price,
                      // provider: widget.provider,
                      // isDynamicPrice: widget.isDynamicPrice,
                      // productCategory: widget.productCategory,
                      ),
                  verticalSpacer(10.h),

                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 20.h),
                            child: PlanExpandableContainer(
                              title: "Plan Details",
                              child: Column(
                                children: [
                                  verticalSpacer(5),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          regularText(
                                            "Plan status",
                                            fontSize: 14.sp,
                                            color: CustomColors.greyTextColor,
                                          ),
                                          verticalSpacer(2),
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              color:
                                                  CustomColors.lightOrangeColor,
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 5,
                                                      horizontal: 6),
                                              child: regularText(
                                                "Pending",
                                                color: CustomColors.orangeColor,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          regularText(
                                            "Plan name",
                                            fontSize: 13.sp,
                                            color: CustomColors.greyTextColor,
                                          ),
                                          verticalSpacer(4),
                                          semiBoldText(
                                            widget.purchaseDetails.payload
                                                    ?.route ??
                                                "",
                                            fontSize: 14.sp,
                                            color: CustomColors.blackTextColor,
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  verticalSpacer(20),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          regularText(
                                            "Purchase date",
                                            fontSize: 14.sp,
                                            color: CustomColors.greyTextColor,
                                          ),
                                          verticalSpacer(4),
                                          semiBoldText(
                                            DateFormat('d\'th\' MMMM yyyy')
                                                .format(widget.purchaseDetails
                                                        .createdAt ??
                                                    DateTime.now()),
                                            fontSize: 14.sp,
                                            color: CustomColors.blackTextColor,
                                          )
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          regularText(
                                            "Premium",
                                            fontSize: 13.sp,
                                            color: CustomColors.greyTextColor,
                                          ),
                                          verticalSpacer(4),
                                          RichText(
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: '₦',
                                                  style: TextStyle(
                                                    fontFamily: "",
                                                    package:
                                                        'mca_official_flutter_sdk',
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 14.sp,
                                                    color: CustomColors
                                                        .blackTextColor,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: StringUtils
                                                          .formatPriceWithComma(widget
                                                                  .purchaseDetails
                                                                  .payload
                                                                  ?.amount
                                                                  .toString() ??
                                                              "") ??
                                                      "",
                                                  style:
                                                      CustomTextStyles.semiBold(
                                                    fontSize: 14.sp,
                                                    color: CustomColors
                                                        .blackTextColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 20.h),
                            child: PlanExpandableContainer(
                              title: "Purchase Details",
                              child: Column(
                                children: [
                                  verticalSpacer(5),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          regularText(
                                            "Email",
                                            fontSize: 14.sp,
                                            color: CustomColors.greyTextColor,
                                          ),
                                          verticalSpacer(4),
                                          semiBoldText(
                                            widget.purchaseDetails.payload?.data
                                                    ?.email ??
                                                "",
                                            fontSize: 14.sp,
                                            color: CustomColors.blackTextColor,
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          regularText(
                                            "Phone number",
                                            fontSize: 13.sp,
                                            color: CustomColors.greyTextColor,
                                          ),
                                          verticalSpacer(4),
                                          semiBoldText(
                                            widget.purchaseDetails.payload?.data
                                                    ?.phone ??
                                                widget.purchaseDetails.payload
                                                    ?.data?.phoneNumber ??
                                                "",
                                            fontSize: 14.sp,
                                            color: CustomColors.blackTextColor,
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  verticalSpacer(20),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          regularText(
                                            "Last name",
                                            fontSize: 14.sp,
                                            color: CustomColors.greyTextColor,
                                          ),
                                          verticalSpacer(4),
                                          semiBoldText(
                                            widget.purchaseDetails.payload?.data
                                                    ?.lastName ??
                                                "",
                                            fontSize: 14.sp,
                                            color: CustomColors.blackTextColor,
                                          )
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          regularText(
                                            "First name",
                                            fontSize: 13.sp,
                                            color: CustomColors.greyTextColor,
                                          ),
                                          verticalSpacer(4),
                                          semiBoldText(
                                            widget.purchaseDetails.payload?.data
                                                    ?.firstName ??
                                                "",
                                            fontSize: 14.sp,
                                            color: CustomColors.blackTextColor,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          verticalSpacer(30.h),
                        ],
                      ),
                    ),
                  ),
                  // const Expanded(child: SizedBox()),
                  CustomButton(
                    title: "Continue",
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SecondFormScreen(
                                    productDetails: ref
                                        .watch(selectedProductDetailsProvider),
                                    // productDetails: widget.productDetails,
                                    // // formFields:
                                    // //     widget.productDetails?.formFields ?? [],

                                    // provider: widget.provider,
                                  )));
                    },
                  ),
                  verticalSpacer(25.h),
                  const PoweredByFooter(),
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }
}

class PlanExpandableContainer extends StatefulWidget {
  final String title;
  final Widget child;
  const PlanExpandableContainer({
    super.key,
    required this.title,
    required this.child,
  });

  @override
  _PlanExpandableContainerState createState() =>
      _PlanExpandableContainerState();
}

class _PlanExpandableContainerState extends State<PlanExpandableContainer> {
  bool _isExpanded = false;

  void _toggleContainer() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleContainer,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 15),
        decoration: BoxDecoration(
          color: CustomColors.backBorderColor,
          borderRadius: BorderRadius.circular(8.r),
        ),
        // width: 300,
        height: _isExpanded ? 1.sh * 0.3 : 50,
        child: ClipRect(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  semiBoldText(
                    widget.title,
                    fontSize: 14.sp,
                    color: CustomColors.blackColor,
                  ),
                  AnimatedRotation(
                    turns: _isExpanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 300),
                    child: Center(
                      child: SvgPicture.asset(ConstantString.chevronDown,
                          package: 'mca_official_flutter_sdk'),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: AnimatedCrossFade(
                  firstChild: Container(),
                  secondChild: Padding(
                    padding: const EdgeInsets.only(top: 15, bottom: 5),
                    child:

                        //     HtmlWidget(
                        //   widget.subTtitle,
                        // ),

                        Scrollbar(
                      // isAlwaysShown: true,
                      child: SingleChildScrollView(
                        child: widget.child,

                        // Text(
                        //   'Here is the expanded content. You can show more information here. Here is the expanded content. You can show more information here.Here is the expanded content. You can show more information here.Here is the expanded content. You can show more information here.\nHere is the expanded content. You can show more information here.t. You can show more information here.Here is the expanded content. You can show more information here.Here is the expanded content. You can show more information here.\nHere is the expanded content. You can show more information here.t. You can show more information here.Here is the expanded content. You can show more information here.Here is the expanded content. You can show more information here.\nHere is the expanded content. You can show more information here.t. You can show more information here.Here is the expanded content. You can show more information here.Here is the expanded content. You can show more information here.\nHere is the expanded content. You can show more information here.t. You can show more information here.Here is the expanded content. You can show more information here.Here is the expanded content. You can show more information here.\nHere is the expanded content. You can show more information here.t. You can show more information here.Here is the expanded content. You can show more information here.Here is the expanded content. You can show more information here.\nHere is the expanded content. You can show more information here.t. You can show more information here.Here is the expanded content. You can show more information here.Here is the expanded content. You can show more information here.\nHere is the expanded content. You can show more information here.t. You can show more information here.Here is the expanded content. You can show more information here.Here is the expanded content. You can show more information here.\nHere is the expanded content. You can show more information here.t. You can show more information here.Here is the expanded content. You can show more information here.Here is the expanded content. You can show more information here.\nHere is the expanded content. You can show more information here.t. You can show more information here.Here is the expanded content. You can show more information here.Here is the expanded content. You can show more information here.\nHere is the expanded content. You can show more information here.t. You can show more information here.Here is the expanded content. You can show more information here.Here is the expanded content. You can show more information here.\nHere is the expanded content. You can show more information here.t. You can show more information here.Here is the expanded content. You can show more information here.Here is the expanded content. You can show more information here.\nHere is the expanded content. You can show more information here.t. You can show more information here.Here is the expanded content. You can show more information here.Here is the expanded content. You can show more information here.\nHere is the expanded content. You can show more information here.t. You can show more information here.Here is the expanded content. You can show more information here.Here is the expanded content. You can show more information here.\nHere is the expanded content. You can show more information here.t. You can show more information here.Here is the expanded content. You can show more information here.Here is the expanded content. You can show more information here.\nHere is the expanded content. You can show more information here.t. You can show more information here.Here is the expanded content. You can show more information here.Here is the expanded content. You can show more information here.\nHere is the expanded content. You can show more information here.',
                        //   style: TextStyle(color: Colors.black, fontSize: 16),
                        // ),
                      ),
                    ),
                  ),
                  crossFadeState: _isExpanded
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
                  duration: const Duration(milliseconds: 300),
                ),
              ),
              // if (_isExpanded) ...[
              //   const SizedBox(height: 20),
              //   const Text(
              //     'Here is the expanded content. You can show more information here.',
              //     style: TextStyle(color: Colors.white, fontSize: 16),
              //   ),
              // ],
            ],
          ),
        ),
      ),
    );
  }
}
