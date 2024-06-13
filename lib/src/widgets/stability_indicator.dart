import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mca_official_flutter_sdk/src/constants/custom_colors.dart';
import 'package:mca_official_flutter_sdk/src/utils/spacers.dart';
import 'package:mca_official_flutter_sdk/src/widgets/custom_text_widget.dart';

class StabilityIndicator extends StatelessWidget {
  final double value;

  const StabilityIndicator({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    // Determine the category and colors based on the value
    String category;
    Color dotColor, bgColor, textColor;

    if (value <= 50) {
      category = "error";
      dotColor = const Color(0xFFF04438);
      bgColor = const Color(0xFFFEF3F2);
      textColor = const Color(0xFFB42318);
    } else if (value <= 85) {
      category = "warning";
      dotColor = const Color(0xFFF79009);
      bgColor = const Color(0xFFFFFAEB);
      textColor = const Color(0xFFB54708);
    } else {
      category = "success";
      dotColor = const Color(0xFF12B76A);
      bgColor = const Color(0xFFECFDF3);
      textColor = const Color(0xFF027A48);
    }

    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: Row(
        children: [
          regularText("Stability:  ",
              fontSize: 12.sp, color: CustomColors.blackColor),
          Container(
            height: 20,
            decoration: BoxDecoration(
                color: bgColor, borderRadius: BorderRadius.circular(10.r)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.circle,
                    size: 7,
                    color: dotColor,
                  ),
                  horizontalSpacer(4),
                  regularText(
                    "$value%",
                    fontSize: 12.sp,
                    color: textColor,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
