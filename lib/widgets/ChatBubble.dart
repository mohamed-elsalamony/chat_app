import 'package:chat_app/models/message.dart';
import 'package:flutter/material.dart';


import 'constant.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({super.key,required this.messsage});
  final Messsage messsage;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        padding: const EdgeInsets.all(22),
        margin: const EdgeInsets.all(7),
        decoration: const BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
              topRight: Radius.circular(20),
            )),
        child:  Text(
         messsage.message,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
class ChatBubbleForFriend extends StatelessWidget {
  const ChatBubbleForFriend({super.key,required this.messsage});
  final Messsage messsage;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.all(22),
        margin: const EdgeInsets.all(7),
        decoration: const BoxDecoration(
            color: Color(0xff006D84),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              // bottomRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            )),
        child:  Text(
         messsage.message,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
