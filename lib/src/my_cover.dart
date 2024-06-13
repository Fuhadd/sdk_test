import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mca_official_flutter_sdk/locator.dart';
import 'package:mca_official_flutter_sdk/src/constants/custom_colors.dart';
import 'package:mca_official_flutter_sdk/src/globals.dart';
import 'package:mca_official_flutter_sdk/src/screens/initialization/initialization_view_model.dart';
import 'package:mca_official_flutter_sdk/src/utils/enum.dart';
import 'package:mca_official_flutter_sdk/src/utils/spacers.dart';
import 'package:mca_official_flutter_sdk/src/widgets/custom_text_widget.dart';

class MyCoverAI extends StatefulHookConsumerWidget {
  final BuildContext context;
  final PaymentOption? paymentOption;
  final TransactionType? transactionType;
  final String? debitWalletReference;
  final String publicKey;
  final List<String>? productId;
  final Function? onComplete;
  final Function? onClose;
  final bool? isContactFieldsEditable;
  final Map<String, dynamic>? form;

  const MyCoverAI({
    super.key,
    required this.context,
    required this.publicKey,
    this.productId,
    this.debitWalletReference,
    this.form,
    this.transactionType,
    this.paymentOption,
    this.isContactFieldsEditable,
    required this.onComplete,
    this.onClose,
  });

  @override
  ConsumerState<MyCoverAI> createState() => _MyCoverAIState();
}

class _MyCoverAIState extends ConsumerState<MyCoverAI> {
  late Future<void> _future;

  @override
  void initState() {
    super.initState();
    _future = initialise(
      context: widget.context,
      publicKey: widget.publicKey,
      ref: ref,
      productId: widget.productId,
      debitWalletReference: widget.debitWalletReference,
      form: widget.form,
      transactionType: widget.transactionType,
      paymentOption: widget.paymentOption,
      isContactFieldsEditable: widget.isContactFieldsEditable,
      onComplete: widget.onComplete,
      onClose: widget.onClose,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Reinitialize the future every time dependencies change
    _future = initialise(
      context: widget.context,
      publicKey: widget.publicKey,
      ref: ref,
      productId: widget.productId,
      debitWalletReference: widget.debitWalletReference,
      form: widget.form,
      transactionType: widget.transactionType,
      paymentOption: widget.paymentOption,
      isContactFieldsEditable: widget.isContactFieldsEditable,
      onComplete: widget.onComplete,
      onClose: widget.onClose,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 973),
      child: Scaffold(
        body: FutureBuilder(
          // future: initialise(
          //   context: widget.context,
          //   publicKey: widget.publicKey,
          //   ref: ref,
          //   productId: widget.productId,
          //   debitWalletReference: widget.debitWalletReference,
          //   form: widget.form,
          //   transactionType: widget.transactionType,
          //   paymentOption: widget.paymentOption,
          //   isContactFieldsEditable: widget.isContactFieldsEditable,
          //   onComplete: widget.onComplete,
          //   onClose: widget.onClose,
          // ),
          future: _future,
          builder: (context, rideSnapshot) {
            if (rideSnapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                      child: SpinKitFadingCircle(
                        color: CustomColors.primaryBrandColor(),
                        size: 35.0,
                      ),
                    ),
                    Container(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        semiBoldText("Welcome", fontSize: 16.sp),
                        horizontalSpacer(10),
                        const SpinKitThreeBounce(
                          color: Colors.black,
                          size: 10.0,
                        ),
                      ],
                    )
                  ],
                ),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}

initialise({
  required String publicKey,
  required WidgetRef ref,
  required BuildContext context,
  required List<String>? productId,
  required String? debitWalletReference,
  required Map<String, dynamic>? form,
  required TransactionType? transactionType,
  required PaymentOption? paymentOption,
  required bool? isContactFieldsEditable,
  required Function? onComplete,
  required Function? onClose,
}) async {
  Global.publicKey = publicKey;
  Global.context = context;
  Global.paymentOption = paymentOption ?? PaymentOption.gateway;
  Global.form = form != null ? Map<String, dynamic>.from(form) : {};
  Global.productId = productId ?? [];
  Global.reference = debitWalletReference ?? "";
  Global.onComplete = onComplete;
  Global.onClose = onClose;
  Global.isContactFieldsEditable = isContactFieldsEditable ?? true;
  Global.email = Global.form.containsKey('email') ? Global.form['email'] : null;
  Global.phone = Global.form.containsKey('phone') ? Global.form['phone'] : null;

// Check if the Global.form contains the key 'phone'
  if (Global.form.containsKey('phone')) {
    // Add the 'phone_number' key with the same value as 'phone'
    Global.form['phone_number'] = Global.form['phone'];
  }

  await setupLocator();
  ref.read(paymentOptionProvider.notifier).state =
      paymentOption ?? PaymentOption.gateway;

  ref.read(transactionTypeProvider.notifier).state =
      transactionType ?? TransactionType.purchase;

  ref.read(publicKeyProvider.notifier).state = publicKey;

  ref.read(onCompleteProvider.notifier).state = onComplete;
  ref.read(onCloseProvider.notifier).state = onClose;
  ref.read(isContactFieldsEditableProvider.notifier).state =
      isContactFieldsEditable ?? true;

  // Navigator.pushReplacement(
  //     context,
  //     MaterialPageRoute(
  //         builder: (context) => const TestHome(
  //             // title: title,

  //             )));

  await InitViewModel().initialiseSdk(
    ref,
    context,
  );
}
