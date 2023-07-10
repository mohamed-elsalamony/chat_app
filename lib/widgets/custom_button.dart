import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
   CustomButton({super.key, this.text, this.onTaap});
  String? text;
  VoidCallback? onTaap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTaap ,
      child: Container(
        
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(8)),
        width: double.infinity,
        height: 60,
        child: Center(child: Text(text!)),
      ),
    );
  }
}
