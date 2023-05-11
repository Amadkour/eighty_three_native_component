import 'dart:math';

import 'package:eighty_three_native_component/core/res/src/services/navigation.dart';
import 'package:eighty_three_native_component/core/res/src/widget/bottom_sheet/contacts/controller/contacts_cubit.dart';
import 'package:eighty_three_native_component/core/res/src/loading.dart';
import 'package:eighty_three_native_component/core/res/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactsViewBottomSheet extends StatelessWidget {
  const ContactsViewBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ContactsCubit>(
      create: (BuildContext context) => ContactsCubit(),
      child: BlocBuilder<ContactsCubit, ContactsState>(
        builder: (BuildContext context, ContactsState state) {
          final ContactsCubit controller = context.read<ContactsCubit>();
          if (state is FetchLoadingState) {
            return const NativeLoading();
          } else {
            return Column(
              children: <Widget>[
                Padding(
                  padding:
                      const EdgeInsets.only(top: 20.0, left: 20, right: 20),
                  child: SearchBar(
                      verticalPadding: 20,
                      backGroundColor: Colors.white,
                      onClear: () {
                        controller.onClearText();
                      },
                      showClear: controller.searchBarController.text.isEmpty,
                      hintText: "search_contact",
                      onChanged: (String value) {
                        controller.search();
                      },
                      controller: controller.searchBarController),
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: controller.presentedContacts.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: <Widget>[
                            ListTile(
                              onTap: () {
                                CustomNavigator.instance.pop(
                                    result: controller.selectContact(index));
                              },
                              leading: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  color: controller.colorsList[Random()
                                      .nextInt(controller.colorsList.length)],
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Text(
                                    '${controller.presentedContacts[index].givenName?[0] ?? 'x'}${controller.presentedContacts[index].familyName?[0] ?? ''}',
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                ),
                              ),
                              title: Text(
                                controller.presentedContacts[index].givenName!,
                                style: TextStyle(
                                    color: AppColors.blackColor, fontSize: 16),
                              ),
                              subtitle: Text(
                                controller
                                    .presentedContacts[index].phones![0].value!,
                                style: TextStyle(
                                    color: AppColors.otpBorderColor,
                                    fontSize: 14),
                              ),
                            ),
                            Divider(
                              color: AppColors.greyColor,
                            )
                          ],
                        );
                      }),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
