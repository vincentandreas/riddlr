import 'package:flutter/material.dart';

class ArticleTextArea extends StatelessWidget {
  const ArticleTextArea(
      {Key? key, required this.controller, this.isEditable = true})
      : super(key: key);
  final bool isEditable;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        maxLines: null,
        expands: true,
        textAlignVertical: TextAlignVertical.top,
        controller: controller,
        enabled: this.isEditable,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderSide: BorderSide(width: 2.0),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }
}
