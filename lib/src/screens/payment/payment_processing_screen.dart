import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mca_official_flutter_sdk/src/constants/custom_colors.dart';
import 'package:mca_official_flutter_sdk/src/utils/custom_text_styles.dart';
import 'package:mca_official_flutter_sdk/src/utils/enum.dart';
import 'package:mca_official_flutter_sdk/src/utils/spacers.dart';
import 'package:mca_official_flutter_sdk/src/widgets/custom_appbar.dart';
import 'package:mca_official_flutter_sdk/src/widgets/powered_by_footer.dart';

class PaymentProcessingScreen extends StatefulHookConsumerWidget {
  // final ProviderLiteModel? provider;
  // final ProductDetailsModel? productDetails;
  // final PurchaseinitializationModel purchaseDetails;
  // final PaymentMethod paymentMethod;
  const PaymentProcessingScreen({
    super.key,
    // required this.provider,
    // required this.productDetails,
    // required this.purchaseDetails,
    // required this.paymentMethod,
  });

  @override
  ConsumerState<PaymentProcessingScreen> createState() =>
      _PaymentProcessingScreenState();
}

class _PaymentProcessingScreenState
    extends ConsumerState<PaymentProcessingScreen> {
  PaymentMethod selectedOption = PaymentMethod.transfer;
  @override
  Widget build(BuildContext context) {
    // final paymentVM = ref.watch(paymentProvider);
    return Scaffold(
      backgroundColor: CustomColors.whiteColor,
      body: SafeArea(
          child: Column(
        children: [
          verticalSpacer(20.h),
          CustomAppbar(
            onBackTap:
                Navigator.canPop(context) ? () => Navigator.pop(context) : null,
          ),
          verticalSpacer(10.h),
          // Padding(
          //   padding: EdgeInsets.symmetric(horizontal: 20.w),
          //   child: PaymentDetailsContainer(
          //     //   productName: productName,
          //     //   periodOfCover: periodOfCover,
          //     //   formattedPrice: formattedPrice,
          //     //   price: price,
          //     provider: widget.provider,
          //     productDetails: widget.productDetails,
          //     //   isDynamicPrice: isDynamicPrice,
          //     //   productCategory: productCategory,
          //   ),
          // ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // semiBoldText(
                  //   "Select Payment methods",
                  //   fontSize: 20.sp,
                  // ),
                  const Expanded(child: ProgressIndicator()),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        // height: 185,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: CustomColors.backBorderColor,
                          borderRadius: BorderRadius.circular(10.r),
                          border:
                              Border.all(color: Colors.transparent, width: 0),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15.w, vertical: 20.h),
                          child: Column(
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text:
                                          "Please wait for us to confirm your payment. Don't close this SDK window while we check your transaction. If there's any delay, contact our support team at ",
                                      style: CustomTextStyles.regular(
                                        fontSize: 14.sp,
                                        color: CustomColors.lightBlackColor,
                                      ),
                                    ),
                                    TextSpan(
                                      text: "support@mycover.ai. ",
                                      style: CustomTextStyles.semiBold(
                                        fontSize: 14.sp,
                                        color: CustomColors.primaryBrandColor(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Expanded(child: SizedBox()),

                  verticalSpacer(8.sp),

                  const Expanded(child: SizedBox()),
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

class ProgressIndicator extends StatefulWidget {
  const ProgressIndicator({super.key});

  @override
  _ProgressIndicatorState createState() => _ProgressIndicatorState();
}

class _ProgressIndicatorState extends State<ProgressIndicator> {
  static const int totalTimeInSeconds = 600; // 10 minutes
  int remainingTimeInSeconds = totalTimeInSeconds;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (remainingTimeInSeconds > 0) {
          remainingTimeInSeconds--;
        } else {
          timer.cancel();
        }
      });
    });
  }

  String formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Column(
                children: [
                  Icon(Icons.check_circle, color: Colors.green, size: 40),
                  Text('Sent', style: TextStyle(color: Colors.green)),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: LinearProgressIndicator(
                    value: (totalTimeInSeconds - remainingTimeInSeconds) /
                        totalTimeInSeconds,
                    backgroundColor: Colors.grey.shade300,
                    color: Colors.green,
                    minHeight: 10,
                  ),
                ),
              ),
              const Column(
                children: [
                  Icon(Icons.access_time, color: Colors.orange, size: 40),
                  Text('Received', style: TextStyle(color: Colors.orange)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          Stack(
            alignment: Alignment.center,
            children: [
              LinearProgressIndicator(
                value: (totalTimeInSeconds - remainingTimeInSeconds) /
                    totalTimeInSeconds,
                backgroundColor: Colors.grey.shade300,
                color: Colors.green,
                minHeight: 10,
              ),
              Text(
                formatTime(remainingTimeInSeconds),
                style: const TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
