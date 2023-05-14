import 'package:eighty_three_native_component/core/res/src/cubit/country_type/provider/model/country_type.dart';
import 'package:eighty_three_native_component/core/res/src/cubit/country_type/controller/country_type_cubit.dart';
import 'package:eighty_three_native_component/core/res/src/cubit/global_cubit.dart';
import 'package:eighty_three_native_component/core/res/src/routes/routes_name.dart';
import 'package:eighty_three_native_component/core/res/src/services/dependency_jnjection.dart';
import 'package:eighty_three_native_component/core/res/src/services/navigation.dart';
import 'package:eighty_three_native_component/core/res/src/widget/images/my_image.dart';
import 'package:eighty_three_native_component/core/res/src/widget/text_field/design/parent/parent.dart';
import 'package:eighty_three_native_component/core/res/src/widget/text_field/validator/child/phone_validator.dart';
import 'package:eighty_three_native_component/core/res/theme/colors.dart';
import 'package:eighty_three_native_component/eighty_three_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PhoneNumberTextField extends StatelessWidget {
  final TextEditingController? phoneNumberController;
  final FocusNode? phoneNumberFocusNode;
  final String? phoneTitle;
  final String? phoneHint;
  final String? error;
  final Color? fillColor;
  final bool? readOnly;
  final double? hintFontSize;
  final double? titleFontSize;
  final double? fullWidth;
  final void Function()? onTab;
  final void Function(String)? onChanged;
  final CountryType? selectedCountry;
  final bool hasPrefix;
  final bool hasSuffix;
  final Widget? suffixWidget;

  const PhoneNumberTextField(
      {super.key,
      this.phoneNumberController,
      this.phoneNumberFocusNode,
      this.phoneTitle = '',
      this.fillColor,
      this.phoneHint = '',
      this.fullWidth,
      this.readOnly,
      this.hintFontSize,
      this.titleFontSize,
      this.selectedCountry,
      this.error,
      this.hasPrefix = true,
      this.hasSuffix = false,
      this.onTab,
      this.onChanged,
      this.suffixWidget});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CountryTypeCubit>.value(
      value: sl<CountryTypeCubit>(),
      child: BlocBuilder<CountryTypeCubit, CountryTypeState>(
        builder: (BuildContext context, CountryTypeState state) {
          final CountryTypeCubit cubit = sl<CountryTypeCubit>();
          return ParentTextField(
            maxLength: 10,
            key: key,
            controller: phoneNumberController,
            textInputFormatter: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(
                RegExp('[0-9]'),
              ),
              FilteringTextInputFormatter.deny(
                RegExp('^0+'), //users can't type 0 at 1st position
              ),
              LengthLimitingTextInputFormatter(10)
            ],
            validator: PhoneValidator().getValidation(),
            keyboardType: TextInputType.number,
            readOnly: readOnly ?? false,
            title: tr(phoneTitle!),
            titleFontSize: titleFontSize,
            hint: tr(phoneHint!),
            onChanged: (String? value) {
              if (onChanged != null) {
                onChanged!(value!);
              }
            },
            focusNode: phoneNumberFocusNode,
            error: error,
            fillColor: fillColor,
            suffix: hasSuffix
                ? suffixWidget ??
                    InkWell(
                      onTap: () async {
                        final dynamic result = await CustomNavigator.instance
                            .pushNamed(RoutesName.qrCode, arguments: true);
                        phoneNumberController!.text = result as String;
                      },
                      child: Container(
                          padding: const EdgeInsets.all(15),
                          child: MyImage.svgAssets(
                              url: "assets/images/bar_code.svg",
                              width: 5,
                              height: 5)),
                    )
                : const SizedBox.shrink(),
            prefix: hasPrefix
                ? Directionality(
                    textDirection: TextDirection.ltr,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        border: Border(
                            right: BorderSide(
                          color: AppColors.borderColor,
                        )),
                      ),
                      padding: const EdgeInsets.only(left: 10),
                      child: cubit.selectedCountry == null
                          ? const Center(
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            )
                          : InkWell(
                              onTap: () {
                                _phoneNumberBottomSheet(
                                  context: context,
                                );
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Container(
                                    width: 30,
                                    height: 40,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: MyImage.assets(
                                      url: cubit.selectedCountry!.icon!,
                                      width: 30,
                                      height: 30,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Text('+${cubit.selectedCountry!.phoneCode}'),
                                  const SizedBox(width: 5),
                                  const Icon(
                                    Icons.keyboard_arrow_down_sharp,
                                    color: Colors.black,
                                  ),
                                ],
                              ),
                            ),
                    ),
                  )
                : null,
            onTab: onTab,
            hintFontSize: fullWidth == null ? null : fullWidth! / 30,
          );
        },
      ),
    );
  }
}

void _phoneNumberBottomSheet({required BuildContext context}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (_) => BlocBuilder<CountryTypeCubit, CountryTypeState>(
      bloc: sl<CountryTypeCubit>(),
      builder: (BuildContext context, CountryTypeState state) => Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(15), topLeft: Radius.circular(15))),
        child: Directionality(
          textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      tr("select_country"),
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontSize: 18, color: Colors.black),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                    child: Divider(),
                  ),
                  ...List<Widget>.generate(
                    countryTypes.length,
                    (int index) {
                      return ListTile(
                        title: Row(
                          children: <Widget>[
                            Container(
                              width: 30,
                              height: 40,
                              clipBehavior: Clip.antiAlias,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: MyImage.assets(
                                url: countryTypes[index].icon!,
                                height: 30,
                                width: 30,
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              tr(countryTypes[index].title!),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(fontSize: 14, color: Colors.black),
                            ),
                            const Spacer(),
                            Text(
                              '+${countryTypes[index].phoneCode}',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                      fontSize: 14,
                                      color: AppColors.blackColor),
                            ),
                          ],
                        ),
                        onTap: () async {
                          sl<CountryTypeCubit>().changeSelectedCountry(index);
                          CustomNavigator.instance.pop();
                        },
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

/**
 * Container(
    margin: const EdgeInsets.symmetric(horizontal: 5),
    padding: const EdgeInsets.only(left: 10),
    child: InkWell(
    onTap: () {},
    child: Row(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
    Container(
    clipBehavior: Clip.antiAlias,
    decoration: const BoxDecoration(
    shape: BoxShape.circle,
    ),
    child: Image.asset(
    'assets/images/login/icons8-saudi-arabia-48.png',
    width: 30,
    height: 30,
    ),
    ),
    const SizedBox(width: 5),
    const Text('+${966}',style: TextStyle(
    fontSize: 12
    )),
    ],
    ),
    ),
    )*/
