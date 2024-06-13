import 'package:example/post_sdk_screen.dart';
import 'package:example/pre_sdk_screen.dart';
import 'package:flutter/material.dart';
import 'package:mca_official_flutter_sdk/mca_official_flutter_sdk.dart';

class SdkScreen extends StatefulWidget {
  final String walletReference;
  final PaymentOption paymentOption;
  const SdkScreen({
    super.key,
    required this.walletReference,
    required this.paymentOption,
  });

  @override
  State<SdkScreen> createState() => _SdkScreenState();
}

class _SdkScreenState extends State<SdkScreen> {
  @override
  Widget build(BuildContext context) {
    void onComplete(dynamic result) {
      // Navigator.of(result['context']).pop();
      Navigator.of(result['context']).pushReplacement(MaterialPageRoute(
        builder: (context) => const PostSdkScreen(),
      ));
    }

    void onClose(dynamic result) {
      // Navigator.of(result['context']).pop();
      Navigator.of(result['context']).pushReplacement(MaterialPageRoute(
        builder: (context) => const PreSdkScreen(),
      ));
    }

    return Scaffold(
      // appBar: AppBar(),
      body: MyCoverAI(
        publicKey: "MCAPUBK_TEST|1acf339a-d36f-47e7-8e1b-fd0b76b61b0c",
        form: const {
          'email': "fuhad@mycovergenius.com",
          'first_name': 'Fuhad',
          'last_name': 'Aminu',
          'phone': '08123232332',
        },
        onComplete: onComplete,
        onClose: onClose,
        context: context,
        // isContactFieldsEditable: false,
        paymentOption: widget.paymentOption,
        debitWalletReference: widget.walletReference,
        // productId: const [
        //   "fab6bda1-b870-4648-8704-11c1802a51d0",
        //   // "c1d0f39c-0b8a-452f-a876-78bef8dde1d9",
        //   // "b83d5f4d-e868-4782-bb35-df6e3344ae7d",
        // ],
      ),
    );
  }
}
