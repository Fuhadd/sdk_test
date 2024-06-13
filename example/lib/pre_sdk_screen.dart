import 'package:dio/dio.dart';
import 'package:example/sdk_screen.dart';
import 'package:flutter/material.dart';
import 'package:mca_official_flutter_sdk/mca_official_flutter_sdk.dart';

class PreSdkScreen extends StatefulWidget {
  const PreSdkScreen({super.key});

  @override
  State<PreSdkScreen> createState() => _PreSdkScreenState();
}

class _PreSdkScreenState extends State<PreSdkScreen> {
  Future<Map<String, dynamic>>? futureData;
  PaymentOption selectedPaymentOption = PaymentOption.wallet;
  bool isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureData = fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background design
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blueAccent, Colors.lightBlueAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          // Top design element
          Positioned(
            top: -50,
            right: -50,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
            ),
          ),
          // Bottom design element
          Positioned(
            bottom: -50,
            left: -50,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
            ),
          ),
          // Centered button
          FutureBuilder<Map<String, dynamic>>(
              future: futureData,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                      child: SizedBox(
                    height: 30,
                    width: 30,
                    child: CircularProgressIndicator.adaptive(
                      backgroundColor: Colors.white,
                    ),
                  ));
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  final data = snapshot.data!['data'];
                  // return
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildOptionContainer(
                              label: 'Wallet',
                              isSelected:
                                  selectedPaymentOption == PaymentOption.wallet,
                              onTap: () {
                                setState(() {
                                  selectedPaymentOption = PaymentOption.wallet;
                                });
                              },
                            ),
                            const SizedBox(width: 20),
                            _buildOptionContainer(
                              label: 'Gateway',
                              isSelected: selectedPaymentOption ==
                                  PaymentOption.gateway,
                              onTap: () {
                                setState(() {
                                  selectedPaymentOption = PaymentOption.gateway;
                                });
                              },
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        ElevatedButton(
                          onPressed: isLoading
                              ? null
                              : () {
                                  // Handle button press
                                  // setState(() {
                                  //   isLoading = true;
                                  // });
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => SdkScreen(
                                            walletReference: data,
                                            paymentOption:
                                                selectedPaymentOption,
                                          )));
                                  // setState(() {
                                  //   isLoading = false;
                                  // });
                                },
                          style: ElevatedButton.styleFrom(
                            // primary: Colors.white,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            elevation: 5,
                            shadowColor: Colors.black.withOpacity(0.5),
                          ),
                          child: const Text(
                            'Click to open SDK',
                            style: TextStyle(
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );

                  //  SuccessScreen(walletReference: data);
                } else {
                  return const Center(child: Text('No data'));
                }
              }),
        ],
      ),
    );
  }

  Widget _buildOptionContainer(
      {required String label,
      required bool isSelected,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.lightBlueAccent
              : Colors.grey[
                  300], // Light blue for selected, light gray for unselected
          borderRadius: BorderRadius.circular(20),
          boxShadow: isSelected
              ? [
                  const BoxShadow(
                      color: Colors.lightBlue, blurRadius: 10, spreadRadius: 1)
                ]
              : [
                  const BoxShadow(
                      color: Colors.grey, blurRadius: 5, spreadRadius: 1)
                ],
        ),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

Future<Map<String, dynamic>> fetchData() async {
  final Dio dio = Dio();
  const String url =
      "https://staging.api.mycover.ai/v1/distributors/create-debit-wallet-reference";
  final Map<String, String> headers = {
    "Authorization": "Bearer MCASECK_TEST|5a571e24-f938-4f14-945c-40ea3cfbc468",
    "Content-Type": "application/json",
  };

  try {
    final response = await dio.post(url, options: Options(headers: headers));
    if (response.statusCode != null && response.statusCode! ~/ 100 == 2) {
      final responseBody = response.data;
      print(responseBody);
      final responseCode = responseBody['responseCode'];
      final responseText = responseBody['responseText'];
      final data = responseBody['data'];
      // print(responseCode, responseText, data);

      return {
        'responseCode': responseCode,
        'responseText': responseText,
        'data': data,
      };
    } else {
      throw Exception('Failed to load data');
    }
  } on DioError catch (e) {
    final errorMessage = e.response?.data['responseText'] ?? 'Unknown error';
    throw Exception(errorMessage);
  }
}
