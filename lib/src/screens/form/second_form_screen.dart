import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mca_official_flutter_sdk/src/Constants/custom_string.dart';
import 'package:mca_official_flutter_sdk/src/constants/custom_colors.dart';
import 'package:mca_official_flutter_sdk/src/globals.dart';
import 'package:mca_official_flutter_sdk/src/models/form_field_model.dart';
import 'package:mca_official_flutter_sdk/src/models/product_details_model.dart';
import 'package:mca_official_flutter_sdk/src/models/provider_lite_model.dart';
import 'package:mca_official_flutter_sdk/src/screens/form/widgets/build_form_field_widget.dart';
import 'package:mca_official_flutter_sdk/src/screens/form/widgets/custom_date_picker.dart';
import 'package:mca_official_flutter_sdk/src/screens/form/widgets/custom_dropdown_field.dart';
import 'package:mca_official_flutter_sdk/src/screens/form/widgets/custom_image_picker.dart';
import 'package:mca_official_flutter_sdk/src/screens/form/form_view_model.dart';
import 'package:mca_official_flutter_sdk/src/screens/form/widgets/product_price_container.dart';
import 'package:mca_official_flutter_sdk/src/screens/payment/payment_method_screen.dart';
import 'package:mca_official_flutter_sdk/src/utils/form_validator.dart';
import 'package:mca_official_flutter_sdk/src/utils/string_utils.dart';
import 'package:mca_official_flutter_sdk/src/widgets/custom_button.dart';
import 'package:mca_official_flutter_sdk/src/widgets/custom_text_widget.dart';
import 'package:mca_official_flutter_sdk/src/utils/spacers.dart';
import 'package:mca_official_flutter_sdk/src/widgets/custom_appbar.dart';
import 'package:mca_official_flutter_sdk/src/widgets/custom_textfield.dart';
import 'package:mca_official_flutter_sdk/src/widgets/powered_by_footer.dart';

class SecondFormScreen extends StatefulHookConsumerWidget {
  final ProductDetailsModel? productDetails;
  // final ProviderLiteModel? provider;
  const SecondFormScreen({
    super.key,
    required this.productDetails,
    // required this.provider,
  });

  @override
  ConsumerState<SecondFormScreen> createState() => _SecondFormScreenState();
}

class _SecondFormScreenState extends ConsumerState<SecondFormScreen> {
  int selectedProvider = 0;
  bool isLoading = true;
  int currentPage = 0;

  final formKey = GlobalKey<FormBuilderState>();
  final Map<String, TextEditingController> _controllers = {};
  final FocusScopeNode _focusScopeNode = FocusScopeNode();

  @override
  void initState() {
    super.initState();
    // Initialize controllers for each form field
    // for (var field
    //     in ref.watch(selectedProductDetailsProvider)?.formFields ?? []) {
    //   if (field.name != null) {
    //     _controllers[field.name!] = TextEditingController(
    //       text: StringUtils.getInitialValue(field.name),
    //     );
    //   }
    // }
    //
    // final controller = _getControllerOf(item['name'].toString(),
    //     initValue:
    //         getInitialValue(item['label'].toString(), item['name'].toString()));

    for (var field in widget.productDetails?.formFields ?? []) {
      if (field.name != null) {
        _controllers[field.name!] = TextEditingController(
            // text: StringUtils.getInitialValue(field.name),
            );
      }
    }
  }

  @override
  void dispose() {
    // Dispose controllers
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final formVM = ref.watch(formVmProvider);

    List<FormFieldModel> filteredFields =
        (widget.productDetails?.formFields ?? [])
            .where((field) => field.showFirst == false)
            .toList();

// Sort the filtered form fields by position
    filteredFields.sort((a, b) => (a.position ?? 0).compareTo(b.position ?? 0));

// Define the number of items to show on the first page and subsequent pages
    int itemsPerPage = 3;

// Calculate the start and end index for the current page
    int startIndex = currentPage * itemsPerPage;
    int endIndex = startIndex + itemsPerPage;

// Ensure endIndex does not exceed the length of the list
    endIndex =
        endIndex > filteredFields.length ? filteredFields.length : endIndex;

// Get the sublist of form fields for the current page
    List<FormFieldModel> currentFields =
        filteredFields.sublist(startIndex, endIndex);

    // Determine if we are on the last page
    bool isLastPage = endIndex >= filteredFields.length;

    return Scaffold(
      backgroundColor: CustomColors.whiteColor,
      body: SafeArea(
          child: FocusScope(
        node: _focusScopeNode,
        child: FormBuilder(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpacer(20.h),
              CustomAppbar(
                // showHelp: true,
                // helpText: "Plan details",
                onBackTap: currentPage > 0
                    ? () {
                        if (MediaQuery.of(context).viewInsets.bottom != 0) {
                          FocusScope.of(context).unfocus();
                        }
                        if (_focusScopeNode.hasFocus) {
                          _focusScopeNode.unfocus();
                        }
                        ref.read(autoValidateProvider.notifier).state = false;
                        setState(() {
                          currentPage--;
                        });
                      }
                    : Navigator.canPop(context)
                        ? () {
                            if (MediaQuery.of(context).viewInsets.bottom != 0) {
                              FocusScope.of(context).unfocus();
                            }
                            if (_focusScopeNode.hasFocus) {
                              _focusScopeNode.unfocus();
                            }
                            ref.read(autoValidateProvider.notifier).state =
                                false;
                            Navigator.pop(context);
                          }
                        : null,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              verticalSpacer(10.h),
                              semiBoldText(
                                "Activate Plan",
                                fontSize: 20.sp,
                              ),
                              verticalSpacer(25.h),
                              MediaQuery.of(context).viewInsets.bottom != 0
                                  ? const SizedBox.shrink()
                                  : Padding(
                                      padding: EdgeInsets.only(bottom: 25.h),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: CustomColors
                                              .lightPrimaryBrandColor(),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 12.w),
                                          child: Row(
                                            children: [
                                              Center(
                                                child: SvgPicture.asset(
                                                  ConstantString.infoIcon,
                                                  color: CustomColors
                                                      .primaryBrandColor(),
                                                  package:
                                                      'mca_official_flutter_sdk',
                                                ),
                                              ),
                                              horizontalSpacer(25.w),
                                              Expanded(
                                                child: regularText(
                                                    "Make sure you provide the right details as it appears on legal document",
                                                    fontSize: 14.sp,
                                                    color: CustomColors
                                                        .blackTextColor),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),

                              verticalSpacer(10.h),

                              // verticalSpacer(25.h),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: currentFields.length,
                                itemBuilder: (context, index) {
                                  FormFieldModel field = currentFields[index];
                                  return BuildFormFieldWidget(
                                    field: field,
                                    controller: _controllers[field.name!],
                                  );

                                  ///VERY IMPORTANT OO
                                  // field.dataUrl != null
                                  //     ? CustomDropdownField(
                                  //         fieldName: field.name ?? "",
                                  //         dataUrl: field.dataUrl ?? "",
                                  //         label: field.label ?? "",
                                  //         description: field.description ?? "",
                                  //       )
                                  //     : (field.inputType == "date")
                                  //         ? CustomDatePicker(
                                  //             fieldName: field.name ?? "",
                                  //             label: field.label ?? "",
                                  //             description: field.description ?? "",
                                  //           )
                                  //         : (field.inputType == "file")
                                  //             ? CustomImagePicker(
                                  //                 fieldName: field.name ?? "",
                                  //                 label: field.label ?? "",
                                  //                 description: field.description ?? "",
                                  //               )
                                  //             : customFormTextField(
                                  //                 field.name ?? '',
                                  //                 onTap: () async {
                                  //                   print(field.dataUrl);
                                  //                   if (field.inputType == "date") {
                                  //                     print(11111111);

                                  //                     final date = await showDatePicker(
                                  //                       context: context,
                                  //                       initialDate: DateTime.now(),
                                  //                       firstDate: DateTime(2000),
                                  //                       lastDate: DateTime(3000),
                                  //                     );
                                  //                     if (date != null) {
                                  //                       setState(() {
                                  //                         _controllers[field.name!]!
                                  //                                 .text =
                                  //                             date
                                  //                                 .toString()
                                  //                                 .substring(0, 10);

                                  //                         ref
                                  //                                 .read(formDataProvider
                                  //                                     .notifier)
                                  //                                 .state[field
                                  //                                     .name ??
                                  //                                 ""] =
                                  //                             _controllers[field.name!]!
                                  //                                 .text;
                                  //                       });
                                  //                     }
                                  //                   }
                                  //                 },
                                  //                 controller: _controllers[field.name!],
                                  //                 readOnly: (field.inputType == "date"),
                                  //                 title: field.label ?? "",
                                  //                 hintText: field.description,
                                  //                 isNumber: field.dataType == "number",
                                  //                 isCurrency: field.isCurrency == true,
                                  //                 autovalidateMode:
                                  //                     ref.watch(autoValidateProvider) ==
                                  //                             true
                                  //                         ? AutovalidateMode
                                  //                             .onUserInteraction
                                  //                         : AutovalidateMode.disabled,
                                  //                 validator: (value) {
                                  //                   return CustomValidator
                                  //                       .generalValidator(
                                  //                     value: value,
                                  //                     name: field.name,
                                  //                     label: field.label ?? "",
                                  //                     dataType: field.dataType,
                                  //                     inputType: field.inputType ?? "",
                                  //                     minMaxConstraint:
                                  //                         field.minMaxConstraint,
                                  //                     errorMsg: field.errorMsg,
                                  //                     min: field.min ?? 0,
                                  //                     max: field.max,
                                  //                   );
                                  //                 },
                                  //                 onChanged: (value) {
                                  //                   if (field.dataType == 'number') {
                                  //                     if (value!.isNotEmpty) {
                                  //                       ref
                                  //                               .read(formDataProvider
                                  //                                   .notifier)
                                  //                               .state[
                                  //                           field.name ??
                                  //                               ""] = int.parse(
                                  //                           value.replaceAll(",", ""));
                                  //                     }
                                  //                   } else {
                                  //                     ref
                                  //                             .read(formDataProvider
                                  //                                 .notifier)
                                  //                             .state[field.name ?? ""] =
                                  //                         value;

                                  //                     if (field.name == "email") {
                                  //                       Global.email = value;
                                  //                     }
                                  //                   }
                                  //                 },
                                  //               );

                                  ///VERTY IMPORTANT OO
                                },
                              ),

                              // if (currentPage == 0) ...[
                              //   Row(
                              //     children: [
                              //       Expanded(
                              //         child: filteredFields[0].dataUrl != null
                              //             ? CustomDropdownField(
                              //                 fieldName: filteredFields[0].name ?? "",
                              //                 dataUrl: filteredFields[0].dataUrl ?? "",
                              //                 label: filteredFields[0].label ?? "",
                              //                 description:
                              //                     filteredFields[0].description ?? "",
                              //               )
                              //             : customFormTextField(
                              //                 filteredFields[0].name ?? '',
                              //                 controller:
                              //                     _controllers[filteredFields[0].name!],
                              //                 title: filteredFields[0].label ?? "",
                              //                 hintText: filteredFields[0].description,
                              //                 // labelText: filteredFields[0].label,
                              //                 autovalidateMode:
                              //                     ref.watch(autoValidateProvider) == true
                              //                         ? AutovalidateMode.onUserInteraction
                              //                         : AutovalidateMode.disabled,

                              //                 isCurrency:
                              //                     filteredFields[0].isCurrency ?? false,
                              //                 validator: (value) {
                              //                   return CustomValidator.generalValidator(
                              //                     value: value,
                              //                     name: filteredFields[0].name,
                              //                     label: filteredFields[0].label ?? "",
                              //                     dataType: filteredFields[0].dataType,
                              //                     inputType:
                              //                         filteredFields[0].inputType ?? "",
                              //                     minMaxConstraint:
                              //                         filteredFields[0].minMaxConstraint,
                              //                     errorMsg: filteredFields[0].errorMsg,
                              //                     min: filteredFields[0].min ?? 0,
                              //                   );
                              //                 },
                              //                 onChanged: (value) {
                              //                   // ref.read(formDataProvider.notifier).state
                              //                   if (filteredFields[0].dataType ==
                              //                       'number') {
                              //                     if (value!.isNotEmpty) {
                              //                       ref
                              //                               .read(formDataProvider.notifier)
                              //                               .state[
                              //                           filteredFields[0].name ??
                              //                               ""] = int.parse(
                              //                           value.replaceAll(",", ""));
                              //                     }
                              //                   } else {
                              //                     ref
                              //                             .read(formDataProvider.notifier)
                              //                             .state[
                              //                         filteredFields[0].name ??
                              //                             ""] = value;

                              //                     if (filteredFields[0].name == "email") {
                              //                       Global.email = value;
                              //                     }
                              //                   }
                              //                 },
                              //               ),
                              //       ),
                              //       horizontalSpacer(20.w),
                              //       Expanded(
                              //         child: filteredFields[1].dataUrl != null
                              //             ? CustomDropdownField(
                              //                 fieldName: filteredFields[1].name ?? "",
                              //                 dataUrl: filteredFields[1].dataUrl ?? "",
                              //                 label: filteredFields[1].label ?? "",
                              //                 description:
                              //                     filteredFields[1].description ?? "",
                              //               )
                              //             : customFormTextField(
                              //                 filteredFields[1].name ?? '',
                              //                 controller:
                              //                     _controllers[filteredFields[1].name!],
                              //                 title: filteredFields[1].label ?? "",
                              //                 hintText: filteredFields[1].description,
                              //                 // title: field.inputType ?? "",
                              //                 // labelText: filteredFields[1].label,
                              //                 autovalidateMode:
                              //                     ref.watch(autoValidateProvider) == true
                              //                         ? AutovalidateMode.onUserInteraction
                              //                         : AutovalidateMode.disabled,

                              //                 isCurrency:
                              //                     filteredFields[1].isCurrency ?? false,
                              //                 validator: (value) {
                              //                   return CustomValidator.generalValidator(
                              //                     value: value,
                              //                     name: filteredFields[1].name,
                              //                     label: filteredFields[1].label ?? "",
                              //                     dataType: filteredFields[1].dataType,
                              //                     inputType:
                              //                         filteredFields[1].inputType ?? "",
                              //                     minMaxConstraint:
                              //                         filteredFields[1].minMaxConstraint,
                              //                     errorMsg: filteredFields[1].errorMsg,
                              //                     min: filteredFields[1].min ?? 0,
                              //                   );
                              //                 },
                              //                 onChanged: (value) {
                              //                   // ref.read(formDataProvider.notifier).state
                              //                   if (filteredFields[1].dataType ==
                              //                       'number') {
                              //                     if (value!.isNotEmpty) {
                              //                       ref
                              //                               .read(formDataProvider.notifier)
                              //                               .state[
                              //                           filteredFields[1].name ??
                              //                               ""] = int.parse(
                              //                           value.replaceAll(",", ""));
                              //                     }
                              //                   } else {
                              //                     ref
                              //                             .read(formDataProvider.notifier)
                              //                             .state[
                              //                         filteredFields[1].name ??
                              //                             ""] = value;

                              //                     if (filteredFields[1].name == "email") {
                              //                       Global.email = value;
                              //                     }
                              //                   }
                              //                 },
                              //               ),
                              //       ),
                              //     ],
                              //   ),
                              //   Expanded(
                              //     child: ListView.builder(
                              //       itemCount: currentFields.length - 2,
                              //       itemBuilder: (context, index) {
                              //         FormFieldModel field = currentFields[index + 2];
                              //         return
                              //             // Container();
                              //             InkWell(
                              //                 onTap: () async {
                              //                   // if (field.inputType == "date") {
                              //                   //   print(11111111);
                              //                   //   final date = await showDatePicker(
                              //                   //       context: context,
                              //                   //       initialDate: DateTime.now(),
                              //                   //       firstDate: DateTime(2000),
                              //                   //       lastDate: DateTime.now());
                              //                   //   // onDateTimeChanged:
                              //                   //   // (DateTime newDate) {
                              //                   //   //   setState(() {
                              //                   //   //     controller.text =
                              //                   //   //         newDate.toString().substring(0, 10);
                              //                   //   //     purchaseData[item['name']] =
                              //                   //   //         controller.text;

                              //                   //   //     _formKey.currentState!.validate();
                              //                   //   //   });
                              //                   //   // };
                              //                   //   if (date != null) {
                              //                   //     setState(() {
                              //                   //       _controllers[field.name!]!.text =
                              //                   //           date.toString().substring(0, 10);

                              //                   //       ref
                              //                   //               .read(formDataProvider.notifier)
                              //                   //               .state[field.name ?? ""] =
                              //                   //           _controllers[field.name!]!.text;

                              //                   //       // purchaseData[item['name']] =
                              //                   //       //     controller.text;
                              //                   //     });
                              //                   //   }
                              //                   // }
                              //                 },
                              //                 child: field.dataUrl != null
                              //                     ? CustomDropdownField(
                              //                         fieldName: field.name ?? "",
                              //                         dataUrl: field.dataUrl ?? "",
                              //                         label: field.label ?? "",
                              //                         description:
                              //                             field.description ?? "",
                              //                       )
                              //                     : (field.inputType == "date")
                              //                         ? CustomDatePicker(
                              //                             fieldName: field.name ?? "",
                              //                             label: field.label ?? "",
                              //                             description:
                              //                                 field.description ?? "",
                              //                           )
                              //                         : (field.inputType == "file")
                              //                             ? CustomImagePicker(
                              //                                 fieldName: field.name ?? "",
                              //                                 label: field.label ?? "",
                              //                                 description:
                              //                                     field.description ?? "",
                              //                               )
                              //                             : customFormTextField(
                              //                                 field.name ?? '',
                              //                                 onTap: () async {
                              //                                   print(field.dataUrl);
                              //                                   if (field.inputType ==
                              //                                       "date") {
                              //                                     print(11111111);

                              //                                     final date =
                              //                                         await showDatePicker(
                              //                                       context: context,
                              //                                       initialDate:
                              //                                           DateTime.now(),
                              //                                       firstDate:
                              //                                           DateTime(2000),
                              //                                       lastDate:
                              //                                           DateTime(3000),
                              //                                     );
                              //                                     if (date != null) {
                              //                                       setState(() {
                              //                                         _controllers[field
                              //                                                     .name!]!
                              //                                                 .text =
                              //                                             date
                              //                                                 .toString()
                              //                                                 .substring(
                              //                                                     0, 10);

                              //                                         ref
                              //                                             .read(formDataProvider
                              //                                                 .notifier)
                              //                                             .state[field
                              //                                                 .name ??
                              //                                             ""] = _controllers[
                              //                                                 field
                              //                                                     .name!]!
                              //                                             .text;
                              //                                       });
                              //                                     }
                              //                                   }
                              //                                 },
                              //                                 controller: _controllers[
                              //                                     field.name!],
                              //                                 readOnly:
                              //                                     (field.inputType ==
                              //                                         "date"),
                              //                                 title: field.label ?? "",
                              //                                 hintText: field.description,
                              //                                 isNumber: field.dataType ==
                              //                                     "number",
                              //                                 isCurrency:
                              //                                     field.isCurrency ==
                              //                                         true,
                              //                                 autovalidateMode: ref.watch(
                              //                                             autoValidateProvider) ==
                              //                                         true
                              //                                     ? AutovalidateMode
                              //                                         .onUserInteraction
                              //                                     : AutovalidateMode
                              //                                         .disabled,
                              //                                 validator: (value) {
                              //                                   return CustomValidator
                              //                                       .generalValidator(
                              //                                     value: value,
                              //                                     name: field.name,
                              //                                     label:
                              //                                         field.label ?? "",
                              //                                     dataType:
                              //                                         field.dataType,
                              //                                     inputType:
                              //                                         field.inputType ??
                              //                                             "",
                              //                                     minMaxConstraint: field
                              //                                         .minMaxConstraint,
                              //                                     errorMsg:
                              //                                         field.errorMsg,
                              //                                     min: field.min ?? 0,
                              //                                   );
                              //                                 },
                              //                                 onChanged: (value) {
                              //                                   if (field.dataType ==
                              //                                       'number') {
                              //                                     if (value!.isNotEmpty) {
                              //                                       ref
                              //                                               .read(formDataProvider
                              //                                                   .notifier)
                              //                                               .state[field
                              //                                                   .name ??
                              //                                               ""] =
                              //                                           int.parse(value
                              //                                               .replaceAll(
                              //                                                   ",", ""));
                              //                                     }
                              //                                   } else {
                              //                                     ref
                              //                                         .read(
                              //                                             formDataProvider
                              //                                                 .notifier)
                              //                                         .state[field
                              //                                             .name ??
                              //                                         ""] = value;

                              //                                     if (field.name ==
                              //                                         "email") {
                              //                                       Global.email = value;
                              //                                     }
                              //                                   }
                              //                                 },
                              //                               ));
                              //       },
                              //     ),
                              //   ),
                              // ] else ...[
                              //   Expanded(
                              //     child: ListView.builder(
                              //       itemCount: currentFields.length,
                              //       itemBuilder: (context, index) {
                              //         FormFieldModel field = currentFields[index];
                              //         return field.dataUrl != null
                              //             ? CustomDropdownField(
                              //                 fieldName: field.name ?? "",
                              //                 dataUrl: field.dataUrl ?? "",
                              //                 label: field.label ?? "",
                              //                 description: field.description ?? "",
                              //               )
                              //             : (field.inputType == "date")
                              //                 ? CustomDatePicker(
                              //                     fieldName: field.name ?? "",
                              //                     label: field.label ?? "",
                              //                     description: field.description ?? "",
                              //                   )
                              //                 : (field.inputType == "file")
                              //                     ? CustomImagePicker(
                              //                         fieldName: field.name ?? "",
                              //                         label: field.label ?? "",
                              //                         description:
                              //                             field.description ?? "",
                              //                       )
                              //                     : customFormTextField(
                              //                         field.name ?? '',
                              //                         onTap: () async {
                              //                           print(field.dataUrl);
                              //                           if (field.inputType == "date") {
                              //                             print(11111111);

                              //                             final date =
                              //                                 await showDatePicker(
                              //                               context: context,
                              //                               initialDate: DateTime.now(),
                              //                               firstDate: DateTime(2000),
                              //                               lastDate: DateTime(3000),
                              //                             );
                              //                             if (date != null) {
                              //                               setState(() {
                              //                                 _controllers[field.name!]!
                              //                                         .text =
                              //                                     date
                              //                                         .toString()
                              //                                         .substring(0, 10);

                              //                                 ref
                              //                                     .read(formDataProvider
                              //                                         .notifier)
                              //                                     .state[field
                              //                                         .name ??
                              //                                     ""] = _controllers[
                              //                                         field.name!]!
                              //                                     .text;
                              //                               });
                              //                             }
                              //                           }
                              //                         },
                              //                         controller:
                              //                             _controllers[field.name!],
                              //                         readOnly:
                              //                             (field.inputType == "date"),
                              //                         title: field.label ?? "",
                              //                         hintText: field.description,
                              //                         isNumber:
                              //                             field.dataType == "number",
                              //                         isCurrency:
                              //                             field.isCurrency == true,
                              //                         autovalidateMode: ref.watch(
                              //                                     autoValidateProvider) ==
                              //                                 true
                              //                             ? AutovalidateMode
                              //                                 .onUserInteraction
                              //                             : AutovalidateMode.disabled,
                              //                         validator: (value) {
                              //                           return CustomValidator
                              //                               .generalValidator(
                              //                             value: value,
                              //                             name: field.name,
                              //                             label: field.label ?? "",
                              //                             dataType: field.dataType,
                              //                             inputType:
                              //                                 field.inputType ?? "",
                              //                             minMaxConstraint:
                              //                                 field.minMaxConstraint,
                              //                             errorMsg: field.errorMsg,
                              //                             min: field.min ?? 0,
                              //                           );
                              //                         },
                              //                         onChanged: (value) {
                              //                           if (field.dataType == 'number') {
                              //                             if (value!.isNotEmpty) {
                              //                               ref
                              //                                       .read(formDataProvider
                              //                                           .notifier)
                              //                                       .state[
                              //                                   field.name ??
                              //                                       ""] = int.parse(value
                              //                                   .replaceAll(",", ""));
                              //                             }
                              //                           } else {
                              //                             ref
                              //                                     .read(formDataProvider
                              //                                         .notifier)
                              //                                     .state[
                              //                                 field.name ?? ""] = value;

                              //                             if (field.name == "email") {
                              //                               Global.email = value;
                              //                             }
                              //                           }
                              //                         },
                              //                       );
                              //       },
                              //     ),
                              //   ),

                              // ],
                              // isLastPage
                              //     ? ProductPriceContainer(
                              //         title: "Premium",
                              //         isLoading: formVM.isLoading,
                              //       )
                              //     : const SizedBox.shrink(),

                              Visibility(
                                visible:
                                    (MediaQuery.of(context).viewInsets.bottom !=
                                        0),
                                child: Column(
                                  children: [
                                    CustomButton(
                                        title: isLastPage
                                            ? "Activate Plan"
                                            : "Continue",
                                        isLoading: formVM.isLoading,
                                        onTap: endIndex < filteredFields.length
                                            ? () {
                                                // Check if the keyboard is currently visible
                                                // FocusScope.of(context).unfocus();
                                                if (MediaQuery.of(context)
                                                        .viewInsets
                                                        .bottom !=
                                                    0) {
                                                  FocusScope.of(context)
                                                      .unfocus();
                                                }
                                                if (_focusScopeNode.hasFocus) {
                                                  _focusScopeNode.unfocus();
                                                }
                                                var validate = formKey
                                                    .currentState
                                                    ?.validate();

                                                if (validate == true) {
                                                  ref
                                                      .read(autoValidateProvider
                                                          .notifier)
                                                      .state = false;
                                                  formKey.currentState?.save();
                                                  print(ref
                                                      .watch(formDataProvider));
                                                  print(ref.watch(
                                                      imageListProvider));
                                                  setState(() {
                                                    currentPage++;
                                                  });
                                                } else {
                                                  ref
                                                      .read(autoValidateProvider
                                                          .notifier)
                                                      .state = true;
                                                }
                                              }
                                            : () async {
                                                // Check if the keyboard is currently visible
                                                // FocusScope.of(context).unfocus();
                                                if (MediaQuery.of(context)
                                                        .viewInsets
                                                        .bottom !=
                                                    0) {
                                                  FocusScope.of(context)
                                                      .unfocus();
                                                }
                                                if (_focusScopeNode.hasFocus) {
                                                  _focusScopeNode.unfocus();
                                                }
                                                var validate = formKey
                                                    .currentState
                                                    ?.validate();

                                                if (validate == true) {
                                                  ref
                                                      .read(autoValidateProvider
                                                          .notifier)
                                                      .state = false;
                                                  formKey.currentState?.save();
                                                  print(endIndex);
                                                  print(filteredFields.length);
                                                  print(ref
                                                      .watch(formDataProvider));
                                                  ref
                                                      .read(formDataProvider
                                                          .notifier)
                                                      .state["product_id"] = ref
                                                          .watch(
                                                              selectedProductDetailsProvider)
                                                          ?.id ??
                                                      "";

                                                  await formVM.completePurchase(
                                                      ref: ref,
                                                      context: context);
                                                } else {
                                                  ref
                                                      .read(autoValidateProvider
                                                          .notifier)
                                                      .state = true;
                                                }
                                              }),
                                    verticalSpacer(25.h),
                                    const PoweredByFooter(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Visibility(
                        visible:
                            !(MediaQuery.of(context).viewInsets.bottom != 0),
                        child: Column(
                          children: [
                            CustomButton(
                                title:
                                    isLastPage ? "Activate Plan" : "Continue",
                                isLoading: formVM.isLoading,
                                onTap: endIndex < filteredFields.length
                                    ? () {
                                        // Check if the keyboard is currently visible
                                        // FocusScope.of(context).unfocus();
                                        if (MediaQuery.of(context)
                                                .viewInsets
                                                .bottom !=
                                            0) {
                                          FocusScope.of(context).unfocus();
                                        }
                                        if (_focusScopeNode.hasFocus) {
                                          _focusScopeNode.unfocus();
                                        }
                                        var validate =
                                            formKey.currentState?.validate();

                                        if (validate == true) {
                                          ref
                                              .read(
                                                  autoValidateProvider.notifier)
                                              .state = false;
                                          formKey.currentState?.save();
                                          print(ref.watch(formDataProvider));
                                          print(ref.watch(imageListProvider));
                                          setState(() {
                                            currentPage++;
                                          });
                                        } else {
                                          ref
                                              .read(
                                                  autoValidateProvider.notifier)
                                              .state = true;
                                        }
                                      }
                                    : () async {
                                        // Check if the keyboard is currently visible
                                        // FocusScope.of(context).unfocus();
                                        if (MediaQuery.of(context)
                                                .viewInsets
                                                .bottom !=
                                            0) {
                                          FocusScope.of(context).unfocus();
                                        }
                                        if (_focusScopeNode.hasFocus) {
                                          _focusScopeNode.unfocus();
                                        }
                                        var validate =
                                            formKey.currentState?.validate();

                                        if (validate == true) {
                                          ref
                                              .read(
                                                  autoValidateProvider.notifier)
                                              .state = false;
                                          formKey.currentState?.save();
                                          print(endIndex);
                                          print(filteredFields.length);
                                          print(ref.watch(formDataProvider));
                                          ref
                                              .read(formDataProvider.notifier)
                                              .state["product_id"] = ref
                                                  .watch(
                                                      selectedProductDetailsProvider)
                                                  ?.id ??
                                              "";

                                          await formVM.completePurchase(
                                              ref: ref, context: context);
                                        } else {
                                          ref
                                              .read(
                                                  autoValidateProvider.notifier)
                                              .state = true;
                                        }
                                      }),
                            verticalSpacer(25.h),
                            const PoweredByFooter(),
                            // verticalSpacer(25.h),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}

test() async {
  return true;
}
