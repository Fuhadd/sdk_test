import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mca_official_flutter_sdk/src/constants/custom_colors.dart';
import 'package:mca_official_flutter_sdk/src/constants/custom_string.dart';
import 'package:mca_official_flutter_sdk/src/globals.dart';
import 'package:mca_official_flutter_sdk/src/screens/initialization/welcome_screen.dart';
import 'package:mca_official_flutter_sdk/src/utils/custom_text_styles.dart';
import 'package:mca_official_flutter_sdk/src/utils/spacers.dart';
import 'package:mca_official_flutter_sdk/src/widgets/custom_button.dart';
import 'package:mca_official_flutter_sdk/src/widgets/custom_text_widget.dart';

// import '../Constants/custom_colors.dart';

late Timer timer;

class GenericDialog {
  Future<void> showSimplePopup(
      {String? title,
      required BuildContext context,
      bool showTitle = true,
      String content = "",
      Widget? customIcon,
      Widget? contentBody,
      TextAlign? textAlign,
      String? okText,
      Function()? onOkPressed,
      Function()? onNoPressed,
      Color? footerColor}) async {
    return showDialog<void>(
      barrierColor: CustomColors.blackColor.withOpacity(0.75),
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
            shape: BoxShape.rectangle,
          ),
          child: AlertDialog(
            backgroundColor: Colors.white,
            elevation: 0,
            actionsPadding: EdgeInsets.zero,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            contentPadding:
                const EdgeInsets.only(top: 35, bottom: 25, left: 15, right: 10),
            content: SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      ConstantString.roundCautionIcon,
                      package: 'mca_official_flutter_sdk',
                    ),
                    verticalSpacer(25),
                    semiBoldText(
                      "Exit Page",
                      fontSize: 18.sp,
                      color: CustomColors.redExitColor,
                    ),
                    verticalSpacer(20.h),
                    regularText(
                        "Before exiting this page, please be aware that proceeding will result in the loss of any previously submitted data. Are you sure you want to continue?",
                        color: CustomColors.formTitleColor,
                        fontSize: 14.sp,
                        textAlign: TextAlign.center),
                    verticalSpacer(80.h),
                    Row(
                      children: [
                        Expanded(
                          child: CustomButton(
                            title: "No, Go back",
                            buttonColor: CustomColors.dividerGreyColor,
                            textColor: CustomColors.backTextColor,
                            fontSize: 13.sp,
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                        horizontalSpacer(10.w),
                        Expanded(
                          child: CustomButton(
                            title: "Yes, Exit page",
                            buttonColor: CustomColors.redExitColor,
                            onTap: onOkPressed ??
                                () {
                                  // var result = {
                                  //   'context': context,
                                  // };

                                  // Global.onClose == null
                                  //     ? null
                                  //     : Global.onClose!(result);

                                  Navigator.pop(context);
                                },
                            fontSize: 13.sp,
                          ),
                        ),
                      ],
                    ),
                    verticalSpacer(10)
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> showSelectImageDialog(
      {String? title,
      required BuildContext context,
      bool showTitle = true,
      String content = "",
      Widget? customIcon,
      Widget? contentBody,
      TextAlign? textAlign,
      String? okText,
      Function()? onCameraPressed,
      Function()? onGalleryPressed,
      Color? footerColor}) async {
    return showDialog<void>(
      barrierColor: CustomColors.blackColor.withOpacity(0.75),
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Container(
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  color: CustomColors.whiteColor,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(25.r),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 25.0, horizontal: 70.h),
                      child: Row(
                        children: [
                          ImageOptionContainer(
                            icon: ConstantString.cameraIcon,
                            title: "Camera",
                            onTap: onCameraPressed,
                          ),
                          const Spacer(),
                          ImageOptionContainer(
                            onTap: onGalleryPressed,
                            icon: ConstantString.galleryIcon,
                            title: "Gallery",
                          ),
                          // Expanded(
                          //   child: SvgPicture.asset(
                          //     ConstantString.galleryIcon,
                          //     package: 'mca_official_flutter_sdk',
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                    verticalSpacer(10)
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> previewImageDialog({
    String? title,
    required BuildContext context,
    required File selectedImage,
    Function()? onOkPressed,
    Function()? onNoPressed,
  }) async {
    return showDialog<void>(
      barrierColor: CustomColors.blackColor.withOpacity(0.75),
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Center(
            child: Container(
              height: 1.sh * 0.7,
              decoration: BoxDecoration(
                color: CustomColors.whiteColor,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(2.r),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    right: 10.0, left: 10, top: 10, bottom: 20),
                child: Column(
                  // mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Image.file(
                        selectedImage,
                        fit: BoxFit.fill,
                      ),
                    ),
                    verticalSpacer(25),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            ConstantString.bulbIcon,
                            height: 30,
                            package: 'mca_official_flutter_sdk',
                          ),
                          horizontalSpacer(5.w),
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Tips:  ",
                                    style: CustomTextStyles.semiBold(
                                      fontSize: 14.sp,
                                      color: CustomColors.blackTextColor,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        "Take in good lighting and ensure that the subject is well-framed",
                                    style: CustomTextStyles.regular(
                                      fontSize: 13.sp,
                                      color: CustomColors.blackTextColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    verticalSpacer(35),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: CustomButton(
                              title: "Cancel",
                              buttonColor: CustomColors.dividerGreyColor,
                              textColor: CustomColors.backTextColor,
                              fontSize: 14.sp,
                              onTap: onNoPressed ??
                                  () {
                                    Navigator.pop(context);
                                  },
                            ),
                          ),
                          horizontalSpacer(10.w),
                          Expanded(
                            flex: 2,
                            child: CustomButton(
                              title: "Submit",
                              onTap: onOkPressed ??
                                  () {
                                    Navigator.pop(context);
                                  },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class ImageOptionContainer extends StatelessWidget {
  final String title, icon;
  final Function()? onTap;
  const ImageOptionContainer({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border:
                  Border.all(color: CustomColors.blackColor.withOpacity(0.12)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[300]!, // Darker shadow
                  offset: const Offset(4, 4),
                  blurRadius: 10,
                  spreadRadius: 1,
                ),
                const BoxShadow(
                  color: Colors.white, // Lighter shadow
                  offset: Offset(-4, -4),
                  blurRadius: 10,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Center(
              child: SvgPicture.asset(
                icon,
                package: 'mca_official_flutter_sdk',
              ),
            ),
          ),
          verticalSpacer(20.h),
          w500Text(
            title,
            fontSize: 15.sp,
          ),
        ],
      ),
    );
  }
}
