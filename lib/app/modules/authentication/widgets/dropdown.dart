import 'package:flutter/material.dart';

import '../../../core/values/keys.dart';

class AppDropDown extends StatelessWidget {
  AppDropDown({super.key});

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      isExpanded: true,
      hint: Text(
        "Choose Your Role",
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      items: [
        DropdownMenuItem(
            value: KeyRoles.management,
            child: Text(
              KeyRoles.management,
              style: Theme.of(context).textTheme.bodyMedium,
            )),
        DropdownMenuItem(
            value: KeyRoles.manager,
            child: Text(
              KeyRoles.manager,
              style: Theme.of(context).textTheme.bodyMedium,
            )),
        DropdownMenuItem(
            value: KeyRoles.staff,
            child: Text(
              KeyRoles.staff,
              style: Theme.of(context).textTheme.bodyMedium,
            )),
      ],
      underline: Container(
        height: 1,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey,
              width: 1.0,
            ),
          ),
        ),
      ),
      onChanged: (String? value) {},
    );
  }
}
