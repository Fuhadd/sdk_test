import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// ignore: unused_import
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:async';
import 'package:mca_official_flutter_sdk/src/constants/custom_colors.dart';
import 'package:mca_official_flutter_sdk/src/utils/spacers.dart';

import 'package:mca_official_flutter_sdk/src/widgets/custom_text_widget.dart';

class CustomToast {
  static void showErrorMessage(BuildContext context, String message) {
    OverlayEntry overlayEntry;
    Duration duration = const Duration(seconds: 4);
    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 50.0,
        left: 20.0,
        right: 20.0,
        child: Material(
          color: Colors.transparent,
          child: _buildToastContent(message, duration),
        ),
      ),
    );

    Overlay.of(context).insert(overlayEntry);

    // Remove the overlay after the duration
    Timer(duration, () {
      overlayEntry.remove();
    });
  }

  static Widget _buildToastContent(String message, Duration duration) {
    return ToastContent(message: message, duration: duration);
  }
}

class ToastContent extends StatefulWidget {
  final String message;
  final Duration duration;

  const ToastContent(
      {super.key, required this.message, required this.duration});

  @override
  _ToastContentState createState() => _ToastContentState();
}

class _ToastContentState extends State<ToastContent> {
  double progress = 1.0;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    startProgress();
  }

  void startProgress() {
    timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
      setState(() {
        progress -= 10 / widget.duration.inMilliseconds;
        if (progress <= 0) {
          progress = 0;
          timer.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10.0,
      ),
      child: Container(
        // padding: const EdgeInsets.only(left: 24.0, right: 24, top: 12.0),
        margin: const EdgeInsets.symmetric(horizontal: 20.0),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            verticalSpacer(5),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15, top: 10.0),
              child: w500Text(
                widget.message,
                fontSize: 14.sp,
                color: CustomColors.whiteColor,
              ),

              //  Text(
              //   widget.message,
              //   style: const TextStyle(
              //     color: Colors.white,
              //     fontSize: 16.0,
              //   ),
              // ),
            ),
            const SizedBox(height: 15.0),
            LinearProgressIndicator(
              value: progress,
              minHeight: 5,
              backgroundColor: Colors.white.withOpacity(0.3),
              valueColor:
                  AlwaysStoppedAnimation<Color>(Colors.red.withOpacity(0.7)),
            ),
          ],
        ),
      ),
    );
  }
}
