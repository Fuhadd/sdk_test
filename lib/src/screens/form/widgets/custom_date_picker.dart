import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mca_official_flutter_sdk/src/constants/custom_colors.dart';
import 'package:mca_official_flutter_sdk/src/globals.dart';
import 'package:mca_official_flutter_sdk/src/screens/form/form_view_model.dart';
import 'package:mca_official_flutter_sdk/src/utils/custom_text_styles.dart';
import 'package:mca_official_flutter_sdk/src/utils/spacers.dart';
import 'package:mca_official_flutter_sdk/src/widgets/custom_text_widget.dart';

// ignore: must_be_immutable
class CustomDatePicker extends StatefulHookConsumerWidget {
  final String fieldName, label, description;
  final StateProvider<Map<String, dynamic>>? customProvider;
  final int min;

  final int? filteredFieldsLength;
  GlobalKey<FormBuilderState>? formKey;
  final FormViewModel? formVM;
  CustomDatePicker({
    super.key,
    required this.fieldName,
    required this.label,
    required this.description,
    required this.min,
    this.customProvider,
    this.filteredFieldsLength,
    this.formVM,
    this.formKey,
  });

  @override
  ConsumerState<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends ConsumerState<CustomDatePicker> {
  Timer? debounce;
  @override
  Widget build(BuildContext context) {
    final formErrors = ref.watch(formErrorsProvider);
    final shouldValidate = ref.watch(shouldValidateImageplusDrop);
    var today = DateTime.now();
    var maxDate = DateTime(3000);
    var minDate = DateTime(today.year - widget.min, today.month, today.day);

    DateTime initialDate = today;
    if (minDate.isBefore(today) && widget.min > 0) {
      initialDate = minDate;
      maxDate = minDate;
      minDate = DateTime(1000);
    } else {
      minDate = DateTime(1000);
    }
    return GestureDetector(
      onTap: () async {
        FocusScope.of(context).unfocus();
        final date = await showDatePicker(
          context: context,
          // initialDate: DateTime.now(),
          // firstDate: DateTime(2000),
          // lastDate: DateTime.now(),

          initialDate: initialDate,
          firstDate: minDate,
          lastDate: maxDate,
          builder: (BuildContext context, Widget? child) {
            return Theme(
              data: customDatePickerTheme,
              child: child!,
            );
          },
        );

        // onDateTimeChanged:
        // (DateTime newDate) {
        //   setState(() {
        //     controller.text =
        //         newDate.toString().substring(0, 10);
        //     purchaseData[item['name']] =
        //         controller.text;

        //     _formKey.currentState!.validate();
        //   });
        // };
        if (date != null) {
          setState(() {
            // _controllers[field.name!]!.text =
            //     date.toString().substring(0, 10);
            ref
                .read(formErrorsProvider.notifier)
                .state
                .remove(widget.fieldName);

            if (widget.customProvider != null) {
              ref
                  .read(widget.customProvider!.notifier)
                  .state[widget.fieldName] = date.toString().substring(0, 10);
            } else {
              ref.read(formDataProvider.notifier).state[widget.fieldName] =
                  date.toString().substring(0, 10);
              if ((widget.filteredFieldsLength != null) &&
                  (widget.formVM != null) &&
                  (widget.formKey != null)) {
                final formData = ref.watch(formDataProvider);
                print(
                    'Total length of showFirst formFields: ${widget.filteredFieldsLength}');
                print('Total length of formDataProvider: ${formData.length}');
                print('Content of formDataProvider: $formData');

                ///
                ///
                if (debounce?.isActive ?? false) {
                  debounce?.cancel();
                }
                debounce = Timer(
                  const Duration(seconds: 1),
                  () async {
                    if (widget.filteredFieldsLength! + 2 == formData.length) {
                      var validate = widget.formKey!.currentState?.validate();

                      if (validate == true) {
                        await widget.formVM!.fetchProductPrice(
                          ref: ref,
                          context: context,
                          productId:
                              ref.watch(selectedProductDetailsProvider)?.id ??
                                  "",
                        );
                      }
                    }
                  },
                );
              }
            }

            // purchaseData[item['name']] =
            //     controller.text;
          });
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          w500Text(
            widget.label,
            fontSize: 14.sp,
            color: CustomColors.formTitleColor,
          ),
          verticalSpacer(8.sp),
          Container(
            width: double.infinity,
            height: 46,
            decoration: BoxDecoration(
              color: CustomColors.backBorderColor,
              border:
                  Border.all(color: CustomColors.dividerGreyColor, width: 0.8),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  widget.customProvider != null
                      ? ref.watch(widget.customProvider!)[widget.fieldName] ==
                              null
                          ? Text(
                              widget.description,
                              style: CustomTextStyles.regular(
                                  fontSize: 15.sp,
                                  color: CustomColors.formHintColor),
                            )
                          : Text(
                              ref
                                  .watch(
                                      widget.customProvider!)[widget.fieldName]
                                  .toString(),
                              style: CustomTextStyles.regular(
                                  fontSize: 15.sp,
                                  color: CustomColors.blackColor),
                            )
                      : ref.watch(formDataProvider)[widget.fieldName] == null
                          ? Text(
                              widget.description,
                              style: CustomTextStyles.regular(
                                  fontSize: 15.sp,
                                  color: CustomColors.formHintColor),
                            )
                          : Text(
                              ref
                                  .watch(formDataProvider)[widget.fieldName]
                                  .toString(),
                              style: CustomTextStyles.regular(
                                  fontSize: 15.sp,
                                  color: CustomColors.blackColor),
                            ),
                  const Icon(
                    Icons.date_range_rounded,
                    color: CustomColors.formHintColor,
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
          formErrors.containsKey(widget.fieldName) && shouldValidate
              ? Padding(
                  padding: EdgeInsets.only(top: 5.sp),
                  child: Text(
                    formErrors[widget.fieldName],
                    style: CustomTextStyles.regular(
                      fontSize: 12.sp,
                      color: Colors.red,
                    ),
                  ),
                )
              : Container(),
          verticalSpacer(25.sp),
        ],
      ),
    );
  }
}

final ThemeData customDatePickerTheme = ThemeData(
  colorScheme: ColorScheme.light(
      primary: CustomColors.primaryBrandColor(), // Header background color
      onPrimary: Colors.white, // Header text color
      onSurface: Colors.black, // Body text color
      onBackground: Colors.white),
  dialogBackgroundColor: Colors.white, // Background color of the dialog

  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: CustomColors.primaryBrandColor(), // Button text color
    ),
  ),
  datePickerTheme: DatePickerThemeData(
    headerBackgroundColor:
        CustomColors.primaryBrandColor(), // Header background color
    headerForegroundColor: Colors.white, // Header text color
    dayBackgroundColor: MaterialStateColor.resolveWith((states) =>
        states.contains(MaterialState.selected)
            ? CustomColors.primaryBrandColor()
            : Colors.transparent), // Selected day background color

    dayForegroundColor: MaterialStateColor.resolveWith(
        (states) => states.contains(MaterialState.selected)
            ? Colors.white
            : states.contains(MaterialState.disabled)
                ? Colors.grey
                : Colors.black), // Selected day text color

    weekdayStyle: const TextStyle(color: Colors.black), // Weekday text color
    dayStyle: const TextStyle(color: Colors.black),

    // disabledDayForegroundColor: Colors.grey, // Disabled day text color
    // disabledDayBackgroundColor: Colors.transparent,
    elevation: 0,
  ),
);
