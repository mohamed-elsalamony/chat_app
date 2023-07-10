import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TextFormFieldd extends StatelessWidget {
  TextFormFieldd({super.key, this.hintTeext, this.onChanged, this.validtor});
  String? hintTeext;
  Function(String)? onChanged;
  String? Function(String?)? validtor;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      validator: validtor,
      decoration: InputDecoration(
        hintStyle: const TextStyle(color: Colors.white),
        hintText: hintTeext,
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
    );
  }
}
