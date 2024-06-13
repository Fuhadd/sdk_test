import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mca_official_flutter_sdk/src/constants/custom_colors.dart';
import 'package:mca_official_flutter_sdk/src/widgets/custom_text_widget.dart';
import 'package:mca_official_flutter_sdk/src/utils/spacers.dart';
import 'package:mca_official_flutter_sdk/src/widgets/icon_container.dart';

class ListOptionsContainer extends StatelessWidget {
  final String title, subTitle, icon;
  final bool isSelected;
  final void Function()? onTap;
  const ListOptionsContainer({
    super.key,
    this.onTap,
    required this.title,
    required this.subTitle,
    required this.icon,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () {},
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        // height: 85,
        decoration: BoxDecoration(
          color: CustomColors.backBorderColor,
          borderRadius: BorderRadius.circular(10.r),
          border: isSelected
              ? Border.all(color: CustomColors.primaryBrandColor(), width: 1.5)
              : Border.all(color: Colors.transparent, width: 0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconContainer(
                diameter: 41.sp,
                icon: icon,
              ),
              // Container(
              //   height: 41.sp,
              //   width: 41.sp,
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(4.r),
              //     color: CustomColors.lightGreenColor,
              //   ),
              //   child: Center(
              //     child: SvgPicture.asset(icon,
              //         package: 'mca_official_flutter_sdk'),
              //   ),
              // ),
              horizontalSpacer(20.h),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    semiBoldText(title,
                        fontSize: 16.sp, color: CustomColors.blackTextColor),
                    verticalSpacer(3.h),
                    regularText(
                      subTitle,
                      fontSize: 12.sp,
                      color: CustomColors.greyTextColor,
                      // maxLines: 1,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
