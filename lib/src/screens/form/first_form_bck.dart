// import 'dart:async';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:mca_official_flutter_sdk/src/Constants/custom_string.dart';
// import 'package:mca_official_flutter_sdk/src/constants/custom_colors.dart';
// import 'package:mca_official_flutter_sdk/src/globals.dart';
// import 'package:mca_official_flutter_sdk/src/models/form_field_model.dart';
// import 'package:mca_official_flutter_sdk/src/models/product_details_model.dart';
// import 'package:mca_official_flutter_sdk/src/screens/form/widgets/build_form_field_widget.dart';
// import 'package:mca_official_flutter_sdk/src/screens/form/form_view_model.dart';
// import 'package:mca_official_flutter_sdk/src/screens/form/widgets/product_price_container.dart';
// import 'package:mca_official_flutter_sdk/src/screens/payment/payment_method_screen.dart';
// import 'package:mca_official_flutter_sdk/src/screens/payment/payment_view_model.dart';
// import 'package:mca_official_flutter_sdk/src/utils/enum.dart';
// import 'package:mca_official_flutter_sdk/src/utils/string_utils.dart';
// import 'package:mca_official_flutter_sdk/src/widgets/custom_button.dart';
// import 'package:mca_official_flutter_sdk/src/widgets/custom_text_widget.dart';
// import 'package:mca_official_flutter_sdk/src/utils/spacers.dart';
// import 'package:mca_official_flutter_sdk/src/widgets/custom_appbar.dart';
// import 'package:mca_official_flutter_sdk/src/widgets/powered_by_footer.dart';

// class FirstFormScreen extends StatefulHookConsumerWidget {
//   final ProductDetailsModel? productDetails;
//   // final ProviderLiteModel? provider;
//   const FirstFormScreen({
//     super.key,
//     required this.productDetails,
//     // required this.provider,
//   });

//   @override
//   ConsumerState<FirstFormScreen> createState() => _FirstFormScreenState();
// }

// class _FirstFormScreenState extends ConsumerState<FirstFormScreen> {
//   int selectedProvider = 0;
//   bool isLoading = true;
//   int currentPage = 0;
//   Timer? debounce;

//   final formKey = GlobalKey<FormBuilderState>();
//   final Map<String, TextEditingController> _controllers = {};
//   final FocusScopeNode _focusScopeNode = FocusScopeNode();

//   @override
//   void initState() {
//     super.initState();
//     // Initialize controllers for each form field

//     for (var field in widget.productDetails?.formFields ?? []) {
//       if (field.name != null) {
//         _controllers[field.name!] = TextEditingController(
//           text: StringUtils.getInitialValue(field.name),
//         );
//       }
//     }
//     WidgetsBinding.instance.addPostFrameCallback((_) async {
//       ref.read(formDataProvider.notifier).state["product_id"] =
//           ref.watch(selectedProductDetailsProvider)?.id ?? "";
//     });
//   }

//   @override
//   void dispose() {
//     // Dispose controllers
//     for (var controller in _controllers.values) {
//       controller.dispose();
//     }
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final formVM = ref.watch(formVmProvider);
//     final paymentVM = ref.watch(paymentProvider);

//     List<FormFieldModel> filteredFields =
//         (widget.productDetails?.formFields ?? [])
//             .where((field) => field.showFirst == true)
//             .toList();

// // Sort the filtered form fields by position
//     filteredFields.sort((a, b) => (a.position ?? 0).compareTo(b.position ?? 0));

// // Define the number of items to show on the first page and subsequent pages
//     int itemsPerPage = currentPage == 0 ? 4 : 3;

// // Calculate the start and end index for the current page
//     int startIndex = currentPage == 0 ? 0 : 4 + (currentPage - 1) * 3;
//     int endIndex = startIndex + itemsPerPage;

// // Get the sublist of form fields for the current page
//     List<FormFieldModel> currentFields = filteredFields.sublist(
//       startIndex,
//       endIndex > filteredFields.length ? filteredFields.length : endIndex,
//     );

//     // Determine if we are on the last page
//     bool isLastPage = endIndex >= filteredFields.length;

//     return Scaffold(
//       // resizeToAvoidBottomInset: false,
//       backgroundColor: CustomColors.whiteColor,
//       body: SafeArea(
//           child: FocusScope(
//         node: _focusScopeNode,
//         child: SizedBox(
//           height: 1.sh,
//           child: FormBuilder(
//             key: formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 verticalSpacer(20.h),
//                 CustomAppbar(
//                   // showHelp: true,
//                   // helpText: "Plan details",
//                   onBackTap: currentPage > 0
//                       ? () {
//                           if (MediaQuery.of(context).viewInsets.bottom != 0) {
//                             FocusScope.of(context).unfocus();
//                           }
//                           if (_focusScopeNode.hasFocus) {
//                             _focusScopeNode.unfocus();
//                           }
//                           ref.read(autoValidateProvider.notifier).state = false;
//                           setState(() {
//                             currentPage--;
//                           });
//                         }
//                       : Navigator.canPop(context)
//                           ? () {
//                               if (MediaQuery.of(context).viewInsets.bottom !=
//                                   0) {
//                                 FocusScope.of(context).unfocus();
//                               }
//                               if (_focusScopeNode.hasFocus) {
//                                 _focusScopeNode.unfocus();
//                               }
//                               ref.read(autoValidateProvider.notifier).state =
//                                   false;
//                               Navigator.pop(context);
//                             }
//                           : null,
//                 ),
//                 Expanded(
//                   child: SingleChildScrollView(
//                     child: Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 20.w),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           verticalSpacer(10.h),
//                           semiBoldText(
//                             "Provide Plan Owner details",
//                             fontSize: 20.sp,
//                           ),
//                           verticalSpacer(25.h),
//                           Container(
//                             decoration: BoxDecoration(
//                               color: CustomColors.lightPrimaryBrandColor(),
//                             ),
//                             child: Padding(
//                               padding: EdgeInsets.symmetric(
//                                   vertical: 10, horizontal: 12.w),
//                               child: Row(
//                                 children: [
//                                   Center(
//                                     child: SvgPicture.asset(
//                                       ConstantString.infoIcon,
//                                       color: CustomColors.primaryBrandColor(),
//                                       package: 'mca_official_flutter_sdk',
//                                     ),
//                                   ),
//                                   horizontalSpacer(25.w),
//                                   Expanded(
//                                     child: regularText(
//                                         "Make sure you provide the right details as it appears on legal document",
//                                         fontSize: 14.sp,
//                                         color: CustomColors.blackTextColor),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           verticalSpacer(10.h),
//                           verticalSpacer(25.h),
//                           if (currentPage == 0) ...[
//                             Row(
//                               children: [
//                                 Expanded(
//                                     child: BuildFormFieldWidget(
//                                   field: filteredFields[0],
//                                   controller:
//                                       _controllers[filteredFields[0].name!],
//                                   filteredFieldsLength: filteredFields.length,
//                                   // debounce: debounce,
//                                   formVM: formVM,
//                                 )

//                                     //VERY IMPORTANT OOO
//                                     //  filteredFields[0].dataUrl != null
//                                     //     ? CustomDropdownField(
//                                     //         fieldName: filteredFields[0].name ?? "",
//                                     //         dataUrl: filteredFields[0].dataUrl ?? "",
//                                     //         label: filteredFields[0].label ?? "",
//                                     //         description:
//                                     //             filteredFields[0].description ?? "",
//                                     //       )
//                                     //     : customFormTextField(
//                                     //         filteredFields[0].name ?? '',
//                                     //         controller:
//                                     //             _controllers[filteredFields[0].name!],
//                                     //         title: filteredFields[0].label ?? "",
//                                     //         hintText: filteredFields[0].description,
//                                     //         // labelText: filteredFields[0].label,
//                                     //         autovalidateMode:
//                                     //             ref.watch(autoValidateProvider) == true
//                                     //                 ? AutovalidateMode.onUserInteraction
//                                     //                 : AutovalidateMode.disabled,

//                                     //         isCurrency:
//                                     //             filteredFields[0].isCurrency ?? false,
//                                     //         validator: (value) {
//                                     //           return CustomValidator.generalValidator(
//                                     //               value: value,
//                                     //               name: filteredFields[0].name,
//                                     //               label: filteredFields[0].label ?? "",
//                                     //               dataType: filteredFields[0].dataType,
//                                     //               inputType:
//                                     //                   filteredFields[0].inputType ?? "",
//                                     //               minMaxConstraint: filteredFields[0]
//                                     //                   .minMaxConstraint,
//                                     //               errorMsg: filteredFields[0].errorMsg,
//                                     //               min: filteredFields[0].min ?? 0,
//                                     //               max: filteredFields[1].max);
//                                     //         },
//                                     //         onChanged: (value) {
//                                     //           // ref.read(formDataProvider.notifier).state
//                                     //           if (filteredFields[0].dataType ==
//                                     //               'number') {
//                                     //             if (value!.isNotEmpty) {
//                                     //               ref
//                                     //                       .read(formDataProvider.notifier)
//                                     //                       .state[
//                                     //                   filteredFields[0].name ??
//                                     //                       ""] = int.parse(
//                                     //                   value.replaceAll(",", ""));
//                                     //             }
//                                     //           } else {
//                                     //             ref
//                                     //                     .read(formDataProvider.notifier)
//                                     //                     .state[
//                                     //                 filteredFields[0].name ??
//                                     //                     ""] = value;

//                                     //             if (filteredFields[0].name == "email") {
//                                     //               Global.email = value;
//                                     //             }
//                                     //           }
//                                     //         },
//                                     //       ),

//                                     ////VERY IMPORTANT OO

//                                     ),
//                                 horizontalSpacer(20.w),
//                                 Expanded(
//                                   child: BuildFormFieldWidget(
//                                     field: filteredFields[1],
//                                     controller:
//                                         _controllers[filteredFields[1].name!],
//                                     filteredFieldsLength: filteredFields.length,
//                                     // debounce: debounce,
//                                     formVM: formVM,
//                                   ),
//                                   //  VERY IMPORTANT OOO
//                                   // filteredFields[1].dataUrl != null
//                                   //     ? CustomDropdownField(
//                                   //         fieldName: filteredFields[1].name ?? "",
//                                   //         dataUrl: filteredFields[1].dataUrl ?? "",
//                                   //         label: filteredFields[1].label ?? "",
//                                   //         description:
//                                   //             filteredFields[1].description ?? "",
//                                   //       )
//                                   //     : customFormTextField(
//                                   //         filteredFields[1].name ?? '',
//                                   //         controller:
//                                   //             _controllers[filteredFields[1].name!],
//                                   //         title: filteredFields[1].label ?? "",
//                                   //         hintText: filteredFields[1].description,
//                                   //         // title: field.inputType ?? "",
//                                   //         // labelText: filteredFields[1].label,
//                                   //         autovalidateMode:
//                                   //             ref.watch(autoValidateProvider) == true
//                                   //                 ? AutovalidateMode.onUserInteraction
//                                   //                 : AutovalidateMode.disabled,

//                                   //         isCurrency:
//                                   //             filteredFields[1].isCurrency ?? false,
//                                   //         validator: (value) {
//                                   //           return CustomValidator.generalValidator(
//                                   //               value: value,
//                                   //               name: filteredFields[1].name,
//                                   //               label: filteredFields[1].label ?? "",
//                                   //               dataType: filteredFields[1].dataType,
//                                   //               inputType:
//                                   //                   filteredFields[1].inputType ?? "",
//                                   //               minMaxConstraint: filteredFields[1]
//                                   //                   .minMaxConstraint,
//                                   //               errorMsg: filteredFields[1].errorMsg,
//                                   //               min: filteredFields[1].min ?? 0,
//                                   //               max: filteredFields[1].max);
//                                   //         },
//                                   //         onChanged: (value) {
//                                   //           // ref.read(formDataProvider.notifier).state
//                                   //           if (filteredFields[1].dataType ==
//                                   //               'number') {
//                                   //             if (value!.isNotEmpty) {
//                                   //               ref
//                                   //                       .read(formDataProvider.notifier)
//                                   //                       .state[
//                                   //                   filteredFields[1].name ??
//                                   //                       ""] = int.parse(
//                                   //                   value.replaceAll(",", ""));
//                                   //             }
//                                   //           } else {
//                                   //             ref
//                                   //                     .read(formDataProvider.notifier)
//                                   //                     .state[
//                                   //                 filteredFields[1].name ??
//                                   //                     ""] = value;

//                                   //             if (filteredFields[1].name == "email") {
//                                   //               Global.email = value;
//                                   //             }
//                                   //           }
//                                   //         },
//                                   //       ),

//                                   //VERY IMPORTANT OO
//                                 ),
//                               ],
//                             ),
//                             ListView.builder(
//                               physics: const NeverScrollableScrollPhysics(),
//                               itemCount: currentFields.length - 2,
//                               shrinkWrap: true,
//                               itemBuilder: (context, index) {
//                                 FormFieldModel field = currentFields[index + 2];
//                                 return BuildFormFieldWidget(
//                                   field: field,
//                                   controller: _controllers[field.name!],
//                                   filteredFieldsLength: filteredFields.length,
//                                   // debounce: debounce,
//                                   formVM: formVM,
//                                 );
//                                 // Container();
//                                 // InkWell(
//                                 //     onTap: () async {
//                                 // if (field.inputType == "date") {
//                                 //   print(11111111);
//                                 //   final date = await showDatePicker(
//                                 //       context: context,
//                                 //       initialDate: DateTime.now(),
//                                 //       firstDate: DateTime(2000),
//                                 //       lastDate: DateTime.now());
//                                 //   // onDateTimeChanged:
//                                 //   // (DateTime newDate) {
//                                 //   //   setState(() {
//                                 //   //     controller.text =
//                                 //   //         newDate.toString().substring(0, 10);
//                                 //   //     purchaseData[item['name']] =
//                                 //   //         controller.text;

//                                 //   //     _formKey.currentState!.validate();
//                                 //   //   });
//                                 //   // };
//                                 //   if (date != null) {
//                                 //     setState(() {
//                                 //       _controllers[field.name!]!.text =
//                                 //           date.toString().substring(0, 10);

//                                 //       ref
//                                 //               .read(formDataProvider.notifier)
//                                 //               .state[field.name ?? ""] =
//                                 //           _controllers[field.name!]!.text;

//                                 //       // purchaseData[item['name']] =
//                                 //       //     controller.text;
//                                 //     });
//                                 //   }
//                                 // }
//                                 // },
//                                 // child:

//                                 ///VERY IMPORTANT OO
//                                 ///
//                                 //  field.dataUrl != null
//                                 //     ? CustomDropdownField(
//                                 //         fieldName: field.name ?? "",
//                                 //         dataUrl: field.dataUrl ?? "",
//                                 //         label: field.label ?? "",
//                                 //         description:
//                                 //             field.description ?? "",
//                                 //       )
//                                 //     : (field.inputType == "date")
//                                 //         ? CustomDatePicker(
//                                 //             fieldName: field.name ?? "",
//                                 //             label: field.label ?? "",
//                                 //             description:
//                                 //                 field.description ?? "",
//                                 //           )
//                                 //         : (field.inputType == "file")
//                                 //             ? CustomImagePicker(
//                                 //                 fieldName: field.name ?? "",
//                                 //                 label: field.label ?? "",
//                                 //                 description:
//                                 //                     field.description ?? "",
//                                 //               )
//                                 //             : customFormTextField(
//                                 //                 field.name ?? '',
//                                 //                 onTap: () async {
//                                 //                   print(field.dataUrl);
//                                 //                   if (field.inputType ==
//                                 //                       "date") {
//                                 //                     print(11111111);

//                                 //                     final date =
//                                 //                         await showDatePicker(
//                                 //                       context: context,
//                                 //                       initialDate:
//                                 //                           DateTime.now(),
//                                 //                       firstDate:
//                                 //                           DateTime(2000),
//                                 //                       lastDate:
//                                 //                           DateTime(3000),
//                                 //                     );
//                                 //                     if (date != null) {
//                                 //                       setState(() {
//                                 //                         _controllers[field
//                                 //                                     .name!]!
//                                 //                                 .text =
//                                 //                             date
//                                 //                                 .toString()
//                                 //                                 .substring(
//                                 //                                     0, 10);

//                                 //                         ref
//                                 //                             .read(formDataProvider
//                                 //                                 .notifier)
//                                 //                             .state[field
//                                 //                                 .name ??
//                                 //                             ""] = _controllers[
//                                 //                                 field
//                                 //                                     .name!]!
//                                 //                             .text;
//                                 //                       });
//                                 //                     }
//                                 //                   }
//                                 //                 },
//                                 //                 controller: _controllers[
//                                 //                     field.name!],
//                                 //                 readOnly:
//                                 //                     (field.inputType ==
//                                 //                         "date"),
//                                 //                 title: field.label ?? "",
//                                 //                 hintText: field.description,
//                                 //                 isNumber: field.dataType ==
//                                 //                     "number",
//                                 //                 isCurrency:
//                                 //                     field.isCurrency ==
//                                 //                         true,
//                                 //                 autovalidateMode: ref.watch(
//                                 //                             autoValidateProvider) ==
//                                 //                         true
//                                 //                     ? AutovalidateMode
//                                 //                         .onUserInteraction
//                                 //                     : AutovalidateMode
//                                 //                         .disabled,
//                                 //                 validator: (value) {
//                                 //                   return CustomValidator
//                                 //                       .generalValidator(
//                                 //                           value: value,
//                                 //                           name: field.name,
//                                 //                           label:
//                                 //                               field.label ??
//                                 //                                   "",
//                                 //                           dataType: field
//                                 //                               .dataType,
//                                 //                           inputType: field
//                                 //                                   .inputType ??
//                                 //                               "",
//                                 //                           minMaxConstraint:
//                                 //                               field
//                                 //                                   .minMaxConstraint,
//                                 //                           errorMsg: field
//                                 //                               .errorMsg,
//                                 //                           min: field.min ??
//                                 //                               0,
//                                 //                           max: field.max);
//                                 //                 },
//                                 //                 onChanged: (value) {
//                                 //                   if (field.dataType ==
//                                 //                       'number') {
//                                 //                     if (value!.isNotEmpty) {
//                                 //                       ref
//                                 //                               .read(formDataProvider
//                                 //                                   .notifier)
//                                 //                               .state[field
//                                 //                                   .name ??
//                                 //                               ""] =
//                                 //                           int.parse(value
//                                 //                               .replaceAll(
//                                 //                                   ",", ""));
//                                 //                     }
//                                 //                   } else {
//                                 //                     ref
//                                 //                         .read(
//                                 //                             formDataProvider
//                                 //                                 .notifier)
//                                 //                         .state[field
//                                 //                             .name ??
//                                 //                         ""] = value;

//                                 //                     if (field.name ==
//                                 //                         "email") {
//                                 //                       Global.email = value;
//                                 //                     }
//                                 //                   }

//                                 //                   final formData =
//                                 //                       ref.watch(
//                                 //                           formDataProvider);

//                                 //                   // Print the length of firstFields, length of formData, and the content of formData
//                                 //                   print(
//                                 //                       'Total length of showFirst formFields: ${filteredFields.length}');
//                                 //                   print(
//                                 //                       'Total length of formDataProvider: ${formData.length}');
//                                 //                   print(
//                                 //                       'Content of formDataProvider: $formData');
//                                 //                 },
//                                 //               ));

//                                 //     VERY IMPORTANT OO
//                               },
//                             ),
//                           ] else ...[
//                             ListView.builder(
//                               itemCount: currentFields.length,
//                               shrinkWrap: true,
//                               itemBuilder: (context, index) {
//                                 FormFieldModel field = currentFields[index];
//                                 return BuildFormFieldWidget(
//                                   field: field,
//                                   controller: _controllers[field.name!],
//                                   filteredFieldsLength: filteredFields.length,
//                                   formVM: formVM,
//                                   formKey: formKey,
//                                 );

//                                 // BuildFormFieldWidget(
//                                 //   field: field,
//                                 //   controller: _controllers[field.name!],
//                                 // );

//                                 //VERY IMPORTANT OOOO

//                                 // field.dataUrl != null
//                                 //     ? CustomDropdownField(
//                                 //         fieldName: field.name ?? "",
//                                 //         dataUrl: field.dataUrl ?? "",
//                                 //         label: field.label ?? "",
//                                 //         description: field.description ?? "",
//                                 //       )
//                                 //     : (field.inputType == "date")
//                                 //         ? CustomDatePicker(
//                                 //             fieldName: field.name ?? "",
//                                 //             label: field.label ?? "",
//                                 //             description: field.description ?? "",
//                                 //           )
//                                 //         : (field.inputType == "file")
//                                 //             ? CustomImagePicker(
//                                 //                 fieldName: field.name ?? "",
//                                 //                 label: field.label ?? "",
//                                 //                 description:
//                                 //                     field.description ?? "",
//                                 //               )
//                                 //             : customFormTextField(
//                                 //                 field.name ?? '',
//                                 //                 onTap: () async {
//                                 //                   print(field.dataUrl);
//                                 //                   if (field.inputType == "date") {
//                                 //                     print(11111111);

//                                 //                     final date =
//                                 //                         await showDatePicker(
//                                 //                       context: context,
//                                 //                       initialDate: DateTime.now(),
//                                 //                       firstDate: DateTime(2000),
//                                 //                       lastDate: DateTime(3000),
//                                 //                     );
//                                 //                     if (date != null) {
//                                 //                       setState(() {
//                                 //                         _controllers[field.name!]!
//                                 //                                 .text =
//                                 //                             date
//                                 //                                 .toString()
//                                 //                                 .substring(0, 10);

//                                 //                         ref
//                                 //                             .read(formDataProvider
//                                 //                                 .notifier)
//                                 //                             .state[field
//                                 //                                 .name ??
//                                 //                             ""] = _controllers[
//                                 //                                 field.name!]!
//                                 //                             .text;
//                                 //                       });
//                                 //                     }
//                                 //                   }
//                                 //                 },
//                                 //                 controller:
//                                 //                     _controllers[field.name!],
//                                 //                 readOnly:
//                                 //                     (field.inputType == "date"),
//                                 //                 title: field.label ?? "",
//                                 //                 hintText: field.description,
//                                 //                 isNumber:
//                                 //                     field.dataType == "number",
//                                 //                 isCurrency:
//                                 //                     field.isCurrency == true,
//                                 //                 autovalidateMode: ref.watch(
//                                 //                             autoValidateProvider) ==
//                                 //                         true
//                                 //                     ? AutovalidateMode
//                                 //                         .onUserInteraction
//                                 //                     : AutovalidateMode.disabled,
//                                 //                 validator: (value) {
//                                 //                   return CustomValidator
//                                 //                       .generalValidator(
//                                 //                           value: value,
//                                 //                           name: field.name,
//                                 //                           label: field.label ?? "",
//                                 //                           dataType: field.dataType,
//                                 //                           inputType:
//                                 //                               field.inputType ?? "",
//                                 //                           minMaxConstraint: field
//                                 //                               .minMaxConstraint,
//                                 //                           errorMsg: field.errorMsg,
//                                 //                           min: field.min ?? 0,
//                                 //                           max: field.max);
//                                 //                 },
//                                 //                 onChanged: (value) async {
//                                 //                   ref
//                                 //                       .read(productPriceProvider
//                                 //                           .notifier)
//                                 //                       .state = 0;
//                                 //                   if (field.dataType == 'number') {
//                                 //                     if (value!.isNotEmpty) {
//                                 //                       ref
//                                 //                               .read(formDataProvider
//                                 //                                   .notifier)
//                                 //                               .state[
//                                 //                           field.name ??
//                                 //                               ""] = int.parse(value
//                                 //                           .replaceAll(",", ""));
//                                 //                     } else {
//                                 //                       // Remove the entry if the value is empty
//                                 //                       ref
//                                 //                           .read(formDataProvider
//                                 //                               .notifier)
//                                 //                           .state
//                                 //                           .remove(field.name ?? "");
//                                 //                     }
//                                 //                   } else {
//                                 //                     if (value!.isNotEmpty) {
//                                 //                       ref
//                                 //                               .read(formDataProvider
//                                 //                                   .notifier)
//                                 //                               .state[
//                                 //                           field.name ?? ""] = value;
//                                 //                     } else {
//                                 //                       // Remove the entry if the value is empty
//                                 //                       ref
//                                 //                           .read(formDataProvider
//                                 //                               .notifier)
//                                 //                           .state
//                                 //                           .remove(field.name ?? "");
//                                 //                     }
//                                 //                   }

//                                 //                   final formData =
//                                 //                       ref.watch(formDataProvider);
//                                 //                   print(
//                                 //                       'Total length of showFirst formFields: ${filteredFields.length}');
//                                 //                   print(
//                                 //                       'Total length of formDataProvider: ${formData.length}');
//                                 //                   print(
//                                 //                       'Content of formDataProvider: $formData');

//                                 //                   // if (filteredFields.length + 2 ==
//                                 //                   //     formData.length) {
//                                 //                   //   var validate = formKey
//                                 //                   //       .currentState
//                                 //                   //       ?.validate();

//                                 //                   //   if (validate == true) {
//                                 //                   //     await Future.delayed(
//                                 //                   //         const Duration(
//                                 //                   //             seconds: 1));
//                                 //                   //     await formVM
//                                 //                   //         .fetchProductPrice(
//                                 //                   //       ref: ref,
//                                 //                   //       context: context,
//                                 //                   //       productId: ref
//                                 //                   //               .watch(
//                                 //                   //                   selectedProductDetailsProvider)
//                                 //                   //               ?.id ??
//                                 //                   //           "",
//                                 //                   //     );
//                                 //                   //   }
//                                 //                   // Debounce logic
//                                 //                   if (_debounce?.isActive ??
//                                 //                       false) {
//                                 //                     _debounce?.cancel();
//                                 //                   }
//                                 //                   _debounce = Timer(
//                                 //                     const Duration(seconds: 1),
//                                 //                     () async {
//                                 //                       if (filteredFields.length +
//                                 //                               2 ==
//                                 //                           formData.length) {
//                                 //                         var validate = formKey
//                                 //                             .currentState
//                                 //                             ?.validate();

//                                 //                         if (validate == true) {
//                                 //                           await formVM
//                                 //                               .fetchProductPrice(
//                                 //                             ref: ref,
//                                 //                             context: context,
//                                 //                             productId: ref
//                                 //                                     .watch(
//                                 //                                         selectedProductDetailsProvider)
//                                 //                                     ?.id ??
//                                 //                                 "",
//                                 //                           );
//                                 //                         }
//                                 //                       }
//                                 //                     },
//                                 //                   );
//                                 //                 },
//                                 //               );

//                                 ///VERY IMPORTANTY
//                               },
//                             ),
//                           ],
//                           verticalSpacer(50.h),
//                           // const Expanded(child: SizedBox()),
//                           Column(
//                             children: [
//                               isLastPage
//                                   ? ProductPriceContainer(
//                                       title: "Premium",
//                                       isLoading: formVM.isLoading,
//                                     )
//                                   : const SizedBox.shrink(),
//                               CustomButton(
//                                 title: ref.watch(productPriceProvider) == 0
//                                     ? "Continue"
//                                     : "Proceed to payment",
//                                 isLoading: paymentVM.isLoading,
//                                 onTap: formVM.isLoading
//                                     ? null
//                                     : endIndex < filteredFields.length
//                                         ? () {
//                                             // Check if the keyboard is currently visible
//                                             if (MediaQuery.of(context)
//                                                     .viewInsets
//                                                     .bottom !=
//                                                 0) {
//                                               FocusScope.of(context).unfocus();
//                                             }
//                                             if (_focusScopeNode.hasFocus) {
//                                               _focusScopeNode.unfocus();
//                                             }
//                                             var validate = formKey.currentState
//                                                 ?.validate();

//                                             if (ref
//                                                 .watch(formErrorsProvider)
//                                                 .isNotEmpty) {
//                                               ref
//                                                   .read(
//                                                       shouldValidateImageplusDrop
//                                                           .notifier)
//                                                   .state = true;
//                                             } else {
//                                               ref
//                                                   .read(
//                                                       shouldValidateImageplusDrop
//                                                           .notifier)
//                                                   .state = false;
//                                               ref
//                                                   .read(formErrorsProvider
//                                                       .notifier)
//                                                   .state = {};

//                                               if (validate == true) {
//                                                 ref
//                                                     .read(autoValidateProvider
//                                                         .notifier)
//                                                     .state = false;
//                                                 formKey.currentState?.save();
//                                                 print(ref
//                                                     .watch(formDataProvider));
//                                                 print(ref
//                                                     .watch(imageListProvider));
//                                                 setState(() {
//                                                   currentPage++;
//                                                 });
//                                               } else {
//                                                 ref
//                                                     .read(autoValidateProvider
//                                                         .notifier)
//                                                     .state = true;
//                                               }
//                                             }
//                                           }
//                                         : ref.watch(productPriceProvider) == 0
//                                             ? () async {
//                                                 // Check if the keyboard is currently visible

//                                                 if (MediaQuery.of(context)
//                                                         .viewInsets
//                                                         .bottom !=
//                                                     0) {
//                                                   FocusScope.of(context)
//                                                       .unfocus();
//                                                 }
//                                                 if (_focusScopeNode.hasFocus) {
//                                                   _focusScopeNode.unfocus();
//                                                 }
//                                                 var validate = formKey
//                                                     .currentState
//                                                     ?.validate();

//                                                 if (ref
//                                                     .watch(formErrorsProvider)
//                                                     .isNotEmpty) {
//                                                   ref
//                                                       .read(
//                                                           shouldValidateImageplusDrop
//                                                               .notifier)
//                                                       .state = true;
//                                                 } else {
//                                                   ref
//                                                       .read(
//                                                           shouldValidateImageplusDrop
//                                                               .notifier)
//                                                       .state = false;
//                                                   ref
//                                                       .read(formErrorsProvider
//                                                           .notifier)
//                                                       .state = {};
//                                                   if (validate == true) {
//                                                     ref
//                                                         .read(
//                                                             autoValidateProvider
//                                                                 .notifier)
//                                                         .state = false;
//                                                     formKey.currentState
//                                                         ?.save();
//                                                     print(endIndex);
//                                                     print(
//                                                         filteredFields.length);
//                                                     print(ref.watch(
//                                                         formDataProvider));
//                                                     // ref
//                                                     //     .read(formDataProvider.notifier)
//                                                     //     .state["product_id"] = ref
//                                                     //         .watch(
//                                                     //             selectedProductDetailsProvider)
//                                                     //         ?.id ??
//                                                     //     "";

//                                                     await formVM
//                                                         .fetchProductPrice(
//                                                       ref: ref,
//                                                       context: context,
//                                                       productId: ref
//                                                               .watch(
//                                                                   selectedProductDetailsProvider)
//                                                               ?.id ??
//                                                           "",
//                                                     );
//                                                   } else {
//                                                     ref
//                                                         .read(
//                                                             autoValidateProvider
//                                                                 .notifier)
//                                                         .state = true;
//                                                   }
//                                                 }
//                                               }
//                                             : () async {
//                                                 Global.paymentOption ==
//                                                         PaymentOption.wallet
//                                                     ? await paymentVM
//                                                         .initiateWalletPurchase(
//                                                         ref: ref,
//                                                         context: context,
//                                                       )
//                                                     : Navigator.push(
//                                                         context,
//                                                         MaterialPageRoute(
//                                                             builder: (context) =>
//                                                                 const PaymentMethodScreen(
//                                                                     // provider: widget.provider,
//                                                                     // productDetails: ref.watch(
//                                                                     //     selectedProductDetailsProvider),
//                                                                     )));
//                                               },
//                               ),
//                               verticalSpacer(25.h),
//                               const PoweredByFooter(),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       )),
//     );
//   }
// }

// test() async {
//   return true;
// }
