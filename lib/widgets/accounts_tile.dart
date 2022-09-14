import 'package:flutter/material.dart';

class AccountTile extends StatelessWidget {
  final String name;
  final Widget iconType;
  final VoidCallback onTap;
  const AccountTile(
      {Key? key,
      required this.name,
      required this.iconType,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(15),
      elevation: 5,
      child: ListTile(
        onTap: onTap,
        leading: iconType,
        title: Text(name),
      ),
    );
  }
}
