import 'package:flutter/material.dart';

class TagTile extends StatelessWidget {
  String tagName;
  TagTile({Key? key, required this.tagName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(5),
        child: Text(
          tagName,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(20),
          color: Colors.grey[300],
          border: Border.all(),
        ),
      ),
    );
  }
}
