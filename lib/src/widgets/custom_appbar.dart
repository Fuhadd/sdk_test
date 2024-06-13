import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mca_official_flutter_sdk/src/constants/custom_colors.dart';
import 'package:mca_official_flutter_sdk/src/constants/custom_string.dart';
import 'package:mca_official_flutter_sdk/src/dialogs_and_popups/bottom_sheets/help_bottom_sheet.dart';
import 'package:mca_official_flutter_sdk/src/dialogs_and_popups/generic_dialog.dart';
import 'package:mca_official_flutter_sdk/src/globals.dart';
import 'package:mca_official_flutter_sdk/src/utils/spacers.dart';
import 'package:mca_official_flutter_sdk/src/widgets/custom_image_network.dart';
import 'package:mca_official_flutter_sdk/src/widgets/custom_text_widget.dart';
import 'package:mca_official_flutter_sdk/src/widgets/shimmer_loader.dart';

class CustomAppbar extends StatelessWidget {
  final bool showLogo, showHelp, showBackButton;
  final String? logoUrl, helpText;
  final void Function()? onBackTap;
  const CustomAppbar({
    super.key,
    this.showLogo = true,
    this.showHelp = false,
    this.showBackButton = true,
    this.logoUrl,
    this.onBackTap,
    this.helpText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Padding(
            padding: EdgeInsets.only(left: showBackButton ? 0 : 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (showBackButton)
                  GestureDetector(
                    onTap: onBackTap,
                    child: Container(
                      height: 41.sp,
                      width: 41.sp,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: CustomColors.backBorderColor,
                      ),
                      child: Center(
                        child: SvgPicture.asset(ConstantString.chevronLeft,
                            package: 'mca_official_flutter_sdk'),
                      ),
                    ),
                  ),
                showLogo
                    ? Global.businessDetails?.logo == null ||
                            (Global.businessDetails == null ||
                                Global.businessDetails?.isDefaultLogo == true)
                        ? Image.asset(
                            ConstantString.myCoverLogoWithText,
                            height: 25,
                            package: 'mca_official_flutter_sdk',
                          )
                        : customImagenetwork(
                            imageUrl: Global.businessDetails!.logo!,
                            loaderWidget: const ShimmerLoader(
                              height: 25,
                              width: 50,
                            ),
                            height: 25,
                          )

                    //  Image.network(
                    //     logoUrl!,
                    //     height: 25,
                    //   )
                    : const SizedBox.shrink(),
                Row(
                  children: [
                    showHelp
                        ? GestureDetector(
                            onTap: () {
                              showHelpBottomSheet(context);
                            },
                            child: Padding(
                              padding: EdgeInsets.only(right: 10.w),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(24),
                                  color: CustomColors.backBorderColor,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 12),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                        ConstantString.helpIcon,
                                        package: 'mca_official_flutter_sdk',
                                      ),
                                      horizontalSpacer(5.w),
                                      regularText(
                                        helpText ?? " Help",
                                        fontSize: 16.sp,
                                        color: CustomColors.blackTextColor,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        : const SizedBox.shrink(),
                    GestureDetector(
                      onTap: () {
                        GenericDialog().showSimplePopup(
                            context: context,
                            onOkPressed: () {
                              Navigator.of(context)
                                  .popUntil((route) => route.isFirst);

                              // var result = {
                              //   'context': Global.context,
                              // };

                              // Global.onClose == null
                              //     ? null
                              //     : Global.onClose!(result);
                            });
                        // Global.sdkClose!();
                      },
                      child: Container(
                        height: 41.sp,
                        width: 41.sp,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: CustomColors.backBorderColor,
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            ConstantString.xMark,
                            package: 'mca_official_flutter_sdk',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        verticalSpacer(5.h),
        const Divider(
          color: CustomColors.dividerGreyColor,
          thickness: 0.3,
        )
      ],
    );
  }
}

Future<File?> selectImage(ImageSource source) async {
  ImagePicker imagePicker = ImagePicker();
  XFile? pickedFile = await imagePicker.pickImage(
      source: source, imageQuality: 50, maxHeight: 612, maxWidth: 816);

  if (pickedFile != null) {
    File file = File(pickedFile.path);
    return file;
  }
  return null;
}
