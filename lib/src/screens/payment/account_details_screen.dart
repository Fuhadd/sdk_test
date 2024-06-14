import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mca_official_flutter_sdk/src/constants/custom_colors.dart';
import 'package:mca_official_flutter_sdk/src/globals.dart';
import 'package:mca_official_flutter_sdk/src/models/purchase_initialization_response.dart';
import 'package:mca_official_flutter_sdk/src/screens/payment/payment_view_model.dart';
import 'package:mca_official_flutter_sdk/src/utils/custom_text_styles.dart';
import 'package:mca_official_flutter_sdk/src/utils/string_utils.dart';
import 'package:mca_official_flutter_sdk/src/widgets/custom_text_widget.dart';
import 'package:mca_official_flutter_sdk/src/utils/enum.dart';
import 'package:mca_official_flutter_sdk/src/utils/spacers.dart';
import 'package:mca_official_flutter_sdk/src/widgets/custom_appbar.dart';
import 'package:mca_official_flutter_sdk/src/widgets/custom_button.dart';
import 'package:mca_official_flutter_sdk/src/widgets/payment_details_container.dart';
import 'package:mca_official_flutter_sdk/src/widgets/powered_by_footer.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
// import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
// import 'package:pusher_channels_flutter/pusher-js/core/channels/channel.dart';
// import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
// import 'package:web_socket_channel/web_socket_channel.dart';
// import 'package:web_socket_channel/status.dart' as status;

class AccountDetailsScreen extends StatefulHookConsumerWidget {
  // final ProviderLiteModel? provider;
  // final ProductDetailsModel? productDetails;
  final PurchaseinitializationModel purchaseDetails;
  final PaymentMethod paymentMethod;
  const AccountDetailsScreen({
    super.key,
    // required this.provider,
    // required this.productDetails,
    required this.purchaseDetails,
    required this.paymentMethod,
  });

  @override
  ConsumerState<AccountDetailsScreen> createState() =>
      _AccountDetailsScreenState();
}

class _AccountDetailsScreenState extends ConsumerState<AccountDetailsScreen> {
  // late PusherChannelsFlutter pusher;
  late String displayText;

  // @override
  // void initState() {
  //   super.initState();
  //   displayText = widget.paymentMethod == PaymentMethod.transfer
  //       ? "Copy details"
  //       : "Copy USSD code";
  //   pusher = PusherChannelsFlutter.getInstance();
  //   initPusher();
  // }

  // void onMemberAdded(String channelName, PusherMember member) {
  //   print("onMemberAdded: $channelName user: $member");
  // }

  // void onMemberRemoved(String channelName, PusherMember member) {
  //   print("onMemberRemoved: $channelName user: $member");
  // }

  // void onError(String message, int? code, dynamic e) {
  //   print("onError: $message code: $code exception: $e");
  // }

  // void onConnectionStateChange(dynamic currentState, dynamic previousState) {
  //   print("Connection: $currentState");
  // }

  // void onDecryptionFailure(String event, String reason) {
  //   print("onDecryptionFailure: $event reason: $reason");
  // }

  // void onSubscriptionError(String message, dynamic e) {
  //   print("onSubscriptionError: $message Exception: $e");
  // }

  // void onSubscriptionSucceeded(String channelName, dynamic data) {
  //   print("onSubscriptionSucceeded: $channelName data: $data");
  // }

  // void onEvent(PusherEvent event) {
  //   print("onEvent: $event");
  // }

  // Future<void> initPusher() async {
  //   try {
  //     await pusher.init(
  //       apiKey: "73968744b27e375ef439",
  //       cluster: "mt1",
  //       onConnectionStateChange: onConnectionStateChange,
  //       onError: onError,
  //       onSubscriptionSucceeded: onSubscriptionSucceeded,
  //       onEvent: onEvent,
  //       onSubscriptionError: onSubscriptionError,
  //       onDecryptionFailure: onDecryptionFailure,
  //       onMemberAdded: onMemberAdded,
  //       onMemberRemoved: onMemberRemoved,
  //       onSubscriptionCount: onConnectionStateChange,
  //     );
  //     print("Pusher initialized successfully");

  //     await pusher.subscribe(
  //         channelName: 'cache-${widget.purchaseDetails.reference}');
  //     print("Subscribed to channel: cache-${widget.purchaseDetails.reference}");

  //     await pusher.connect();
  //     print("Pusher connected");
  //   } catch (e) {
  //     print("Pusher initialization error: $e");
  //   }
  // }

  // @override
  // void dispose() {
  //   pusher.disconnect();
  //   super.dispose();
  // }

  //BELOW
  PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();
  PaymentMethod selectedOption = PaymentMethod.transfer;
  // String displayText = "";
  // late PusherChannelsFlutter pusher;
  late String channelName;
  // Channel? channel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    displayText = widget.paymentMethod == PaymentMethod.transfer
        ? "Copy details"
        : "Copy USSD code";
    initPusher();
  }

  void onMemberAdded(String channelName, PusherMember member) {
    print("onMemberAdded: $channelName user: $member");
  }

  void onMemberRemoved(String channelName, PusherMember member) {
    print("onMemberRemoved: $channelName user: $member");
  }

  void onError(String message, int? code, dynamic e) {
    print("onError: $message code: $code exception: $e");
  }

  void onConnectionStateChange(dynamic currentState, dynamic previousState) {
    print("Connection: $currentState");
  }

  void onDecryptionFailure(String event, String reason) {
    print("onDecryptionFailure: $event reason: $reason");
  }

  void onSubscriptionError(String message, dynamic e) {
    print("onSubscriptionError: $message Exception: $e");
  }

  void onSubscriptionSucceeded(String channelName, dynamic data) {
    print("onSubscriptionSucceeded: $channelName data: $data");
  }

  void onEvent(PusherEvent event) {
    print("onEvent: $event");
  }

  Future<void> initPusher() async {
    // if (!_channelFormKey.currentState!.validate()) {
    //   return;
    // }
    // // Remove keyboard
    // FocusScope.of(context).requestFocus(FocusNode());
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.setString("apiKey", _apiKey.text);
    // prefs.setString("cluster", _cluster.text);
    // prefs.setString("channelName", _channelName.text);

    try {
      await pusher.init(
        apiKey: "e1c1f089656c77fe14b2",
        cluster: "us2",
        onConnectionStateChange: onConnectionStateChange,
        onError: onError,
        onSubscriptionSucceeded: onSubscriptionSucceeded,
        onEvent: onEvent,
        onSubscriptionError: onSubscriptionError,
        onDecryptionFailure: onDecryptionFailure,
        onMemberAdded: onMemberAdded,
        onMemberRemoved: onMemberRemoved,
        onSubscriptionCount: onConnectionStateChange,
        // authEndpoint: "<Your Authendpoint Url>",
        // onAuthorizer: onAuthorizer
      );
      await pusher.subscribe(
          channelName: 'cache-${widget.purchaseDetails.reference}');
      await pusher.connect();
    } catch (e) {
      log("ERROR: $e");
    }
    // PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();
    // try {
    //   await pusher.init(
    //     apiKey: "73968744b27e375ef439",
    //     cluster: "mt1",
    //     onConnectionStateChange: onConnectionStateChange,
    //     onError: onError,
    //     onSubscriptionSucceeded: onSubscriptionSucceeded,
    //     onEvent: onEvent,
    //     onSubscriptionError: onSubscriptionError,
    //     onDecryptionFailure: onDecryptionFailure,
    //     onMemberAdded: onMemberAdded,
    //     onMemberRemoved: onMemberRemoved,

    //     // authEndpoint: "<Your Authendpoint>",
    //     // onAuthorizer: onAuthorizer
    //   );
    //   await pusher.subscribe(
    //     channelName: 'cache-${widget.purchaseDetails.reference}',
    //     // onConnectionStateChange: onConnectionStateChange,
    //     // onError: onError,
    //     // onSubscriptionSucceeded: onSubscriptionSucceeded,
    //     // onEvent: onEvent,
    //     // onSubscriptionError: onSubscriptionError,
    //     // onDecryptionFailure: onDecryptionFailure,
    //     // onMemberAdded: onMemberAdded,
    //     // onMemberRemoved: onMemberRemoved,
    //   );

    //   await pusher.connect();
    //   // myChannel.
    // } catch (e) {
    //   print("ERROR: $e");
    // }
  }

  @override
  Widget build(BuildContext context) {
    // final channel = WebSocketChannel.connect(
    //   // Uri.parse('wss://echo.websocket.events'),
    //   Uri.parse('wss://cache-${widget.purchaseDetails.reference}'),
    // );

    final paymentVM = ref.watch(paymentProvider);
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
          // pusher.
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: const PaymentDetailsContainer(
                //   productName: productName,
                //   periodOfCover: periodOfCover,
                //   formattedPrice: formattedPrice,
                //   price: price,
                // provider: widget.provider,
                // productDetails: widget.productDetails,
                //   isDynamicPrice: isDynamicPrice,
                //   productCategory: productCategory,
                ),
          ),
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
                  const Expanded(child: SizedBox()),
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
                              horizontal: 15.w, vertical: 40.h),
                          child: Column(
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "Transfer  ",
                                      style: CustomTextStyles.regular(
                                        fontSize: 14.sp,
                                        color: CustomColors.blackTextColor,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          "NGN ${StringUtils.formatPriceWithComma(
                                        widget.purchaseDetails.amount
                                            .toString(),
                                      )}",
                                      style: CustomTextStyles.semiBold(
                                        fontSize: 18.sp,
                                        color: CustomColors.primaryBrandColor(),
                                      ),
                                    ),
                                    TextSpan(
                                      text: "  to",
                                      style: CustomTextStyles.regular(
                                        fontSize: 14.sp,
                                        color: CustomColors.blackTextColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              verticalSpacer(30.h),
                              semiBoldText(
                                  widget.paymentMethod == PaymentMethod.transfer
                                      ? widget.purchaseDetails.bank ?? ""
                                      : ref
                                              .watch(selectedBankProvider)
                                              ?.bankName ??
                                          "",
                                  fontSize: 22.sp,
                                  color: CustomColors.blackTextColor),
                              verticalSpacer(10.h),
                              // semiBoldText("",
                              //     fontSize: 22.sp,
                              //     color: CustomColors.blackTextColor),
                              // verticalSpacer(10.h),
                              semiBoldText(
                                  // widget.purchaseDetails.accountNumber ??
                                  //     "12345678990",

                                  widget.paymentMethod == PaymentMethod.transfer
                                      ? widget.purchaseDetails.accountNumber ??
                                          ""
                                      : widget.purchaseDetails.paymentCode ??
                                          "",
                                  fontSize: 22.sp,
                                  color: widget.paymentMethod ==
                                          PaymentMethod.transfer
                                      ? CustomColors.blackTextColor
                                      : CustomColors.primaryBrandColor()),
                              verticalSpacer(30.h),
                              GestureDetector(
                                onTap: () async {
                                  await Clipboard.setData(
                                    ClipboardData(
                                      text: widget
                                              .purchaseDetails.accountNumber ??
                                          "",
                                    ),
                                  );
                                  setState(() {
                                    // copied = true;
                                    displayText = widget.paymentMethod ==
                                            PaymentMethod.transfer
                                        ? "Account number copied to clipboard"
                                        : "USSD code copied to clipboard";
                                  });

                                  Future.delayed(const Duration(seconds: 2),
                                      () {
                                    setState(() {
                                      // copied = false;
                                      displayText = widget.paymentMethod ==
                                              PaymentMethod.transfer
                                          ? "Copy details"
                                          : "Copy USSD code";
                                    });
                                  });
                                  // ToastNotification.show(
                                  //   context: context,
                                  //   copiedText:
                                  //       widget.purchaseDetails.accountNumber ??
                                  //           "",
                                  //   toastMessage: "Copied to clipboard!",
                                  // );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color:
                                        CustomColors.lightPrimaryBrandColor(),
                                    borderRadius: BorderRadius.circular(3.r),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10.w, vertical: 5.h),
                                    child: AnimatedSwitcher(
                                      duration:
                                          const Duration(milliseconds: 300),
                                      transitionBuilder: (Widget child,
                                          Animation<double> animation) {
                                        return FadeTransition(
                                            opacity: animation, child: child);
                                      },
                                      child: w500Text(
                                        // widget.paymentMethod ==
                                        //         PaymentMethod.transfer
                                        //     ? "Copy details"
                                        //     : "Copy USSD code",
                                        // fontSize: 14.sp,
                                        displayText,
                                        key: ValueKey<String>(displayText),
                                        fontSize: 14.sp,
                                        color: CustomColors.primaryBrandColor(),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Expanded(child: SizedBox()),
                  // const Expanded(child: SizedBox()),
                  Center(
                    child: regularText(
                      "Click the button after making payment ",
                      fontSize: 14.sp,
                      color: CustomColors.lightBlackColor,
                    ),
                  ),
                  verticalSpacer(8.sp),

                  // StreamBuilder(stream: stream, builder: builder)
                  // StreamBuilder(
                  //   stream: channel.stream,
                  //   builder: (context, snapshot) {
                  //     return Text(snapshot.hasData ? '${snapshot.data}' : '');
                  //   },
                  // ),
                  // Text(pusher.connectionState == 'DISCONNECTED'
                  //     ? 'Pusher Channels Example'
                  //     : _channelName.text),
                  CustomButton(
                      title: "Continue",
                      isLoading: paymentVM.isLoading,
                      onTap:
                          //  selectedOption == PaymentMethod.transfer
                          //     ?
                          () {
                        paymentVM.verifyPayment(
                            reference: widget.purchaseDetails.reference ?? "",
                            ref: ref,
                            context: context);

                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) =>
                        //             const ListViewProductListScreen())

                        //             );
                      }
                      // : null,
                      ),
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
