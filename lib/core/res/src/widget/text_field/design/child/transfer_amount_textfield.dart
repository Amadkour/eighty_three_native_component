part of 'amount_text_field.dart';

class _TransactionAmountTextField extends AmountTextField {
  const _TransactionAmountTextField({
    super.key,
    bool withCurrency = true,
    TextAlign textAlign = TextAlign.start,
    String? label,
    bool isLocal = false,
    ValueChanged<String>? onChanged,
    bool readOnly = false,
    TextEditingController? controller,
    String? defaultValue,
    bool autoFocus = false,
  }) : super(
          withCurrency: withCurrency,
          textAlign: textAlign,
          label: label,
          onChanged: onChanged,
          readOnly: readOnly,
          defaultValue: defaultValue,
          autoFocus: autoFocus,
          controller: controller,
          isLocal: isLocal,
        );
  @override
  Widget build(BuildContext context) {
    //sl<TransactionAmountCubit>().amount = null;
    return BlocProvider<TransactionAmountCubit>.value(
      value: sl<TransactionAmountCubit>(),
      child: BlocBuilder<TransactionAmountCubit, TransactionAmountState>(
        builder: (BuildContext context, Object? state) {
          final TransactionAmountCubit amountCubit =
              context.read<TransactionAmountCubit>();
          return Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Text(
                  tr(label ?? "enter_amount"),
                  style: descriptionStyle.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                ),
              ),
              Theme(
                data: Theme.of(context).copyWith(
                  colorScheme: const ColorScheme.light(
                    secondary: Colors.black,
                    primary: Colors.black,
                  ),
                ),
                child: ParentTextField(
                  key: key,
                  enableCopy: false,
                  autoFocus: autoFocus,
                  readOnly: readOnly,
                  cursorWidth: 0,
                  maxLength: 6,
                  textInputAction: TextInputAction.go,
                  onChanged: onChanged,
                  textInputFormatter: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                    LengthLimitingTextInputFormatter(6)
                  ],
                  validator: MoneyAmountValidator().getValidation(),
                  keyboardType: TextInputType.number,
                  style: currencyFieldStyle,
                  controller: controller,
                  textAlign: textAlign,
                  verticalPadding: 0,
                  padding: 0,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.blackColor.withOpacity(0.2),
                      ),
                    ),
                    suffixIconConstraints: const BoxConstraints(
                      maxWidth: 60,
                      maxHeight: 40,
                    ),
                    suffixIcon: withCurrency
                        ? CurrencyDropdown(
                            isLocal: isLocal,
                            onChanged: (currency) {
                              amountCubit.changeCurrency(currency);
                            },
                            value: amountCubit.currentCurrency,
                          )
                        : const SizedBox(),
                    hintText: tr("0.00"),
                    hintStyle: currencyFieldStyle.copyWith(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
