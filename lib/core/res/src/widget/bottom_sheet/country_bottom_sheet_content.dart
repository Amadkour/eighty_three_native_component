import 'package:eighty_three_native_component/core/res/src/cubit/country_type/controller/country_type_cubit.dart';
import 'package:eighty_three_native_component/core/res/src/cubit/country_type/provider/model/country_type.dart';
import 'package:eighty_three_native_component/core/res/src/services/dependency_jnjection.dart';
import 'package:eighty_three_native_component/core/res/src/services/navigation.dart';
import 'package:eighty_three_native_component/core/res/src/widget/custom_search_bar.dart';
import 'package:eighty_three_native_component/core/res/src/widget/images/my_image.dart';
import 'package:eighty_three_native_component/core/utils/extenstions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CountryBottomSheet {
  static final CountryBottomSheet _instance = CountryBottomSheet._internal();
  CountryBottomSheet._internal();

  static CountryBottomSheet get instance => _instance;

  Future<void> show(
      {required BuildContext context,
        required CountryType country,
        String? searchIconPath,
        bool ? haveSearchBar,
        required ValueChanged<CountryType> onChangeSelectedCountry}) async {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) => CountryBottomSheetContent(
        onChangeSelectedCountry: onChangeSelectedCountry,
        country: country,
        searchIconPath: searchIconPath,
        haveSearchBar: haveSearchBar ?? false,
      ),
    );
  }
}

class CountryBottomSheetContent extends StatelessWidget {
  final String? title;
  final CountryType country;
  final String? searchIconPath;
  const CountryBottomSheetContent({
    required this.onChangeSelectedCountry,
    required this.country,
    this.title,
    super.key, this.haveSearchBar=false,
    this.searchIconPath,
  });
  final bool haveSearchBar;
  final void Function(CountryType) onChangeSelectedCountry;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CountryTypeCubit>.value(
      value: sl<CountryTypeCubit>(),
      child: Builder(builder: (BuildContext context) {
        final CountryTypeCubit controller = context.read<CountryTypeCubit>();
        return Container(
          margin:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          // height: MediaQuery.of(context).size.height * 0.6,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(15), topLeft: Radius.circular(15))),
          child: BlocBuilder<CountryTypeCubit, CountryTypeState>(
            builder: (BuildContext context, CountryTypeState index) {
              return SingleChildScrollView(
                child: SafeArea(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      if(haveSearchBar)...[
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            title ?? ' ',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(fontSize: 18, color: Colors.black),
                          ),
                        ),
                        CustomSearchBar(
                          searchIconPath: searchIconPath,
                          verticalPadding: 20,
                          backGroundColor: Colors.white,
                          showClear: true,
                          hintText: "searchHer",
                          onChanged: (String value) {
                            controller.search(value);
                          },
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                          child: Divider(),
                        ),
                      ],
                      BlocBuilder<CountryTypeCubit, CountryTypeState>(
                        builder: (BuildContext context, CountryTypeState state) =>
                            Column(
                              children: getList(controller.displayedList, context),
                            ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }

  List<Widget> getList(List<CountryType> data, BuildContext context) =>
      List<Widget>.generate(
        data.length,
            (int index) {
          return ListTile(
            key: Key("country_$index"),
            title: Row(
              children: <Widget>[
                Container(
                  width: 30,
                  height: 40,
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: MyImage.svgNetwork(
                    url: data[index].icon ?? "",
                    height: 30,
                    width: 30,
                    fit: BoxFit.fitHeight,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  data[index].title!,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontSize: 14, color: Colors.black),
                ),
                const Spacer(),
                Text(
                  '${data[index].phoneCode}+',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontSize: 14, color: context.theme.primaryColor),
                ),
              ],
            ),
            onTap: () async {
              onChangeSelectedCountry.call(data[index]);
              CustomNavigator.instance.pop();
            },
          );
        },
      );
}
