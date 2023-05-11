import 'package:eighty_three_native_component/core/res/src/widget/bottom_sheet/contacts/view/page/contacts_view.dart';
import 'package:flutter/material.dart';

Future<String?> contactsList({
  required BuildContext context,
}) async {
  return showModalBottomSheet<String>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return const ContactsViewBottomSheet();
    },
  );
}
