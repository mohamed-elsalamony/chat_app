import 'package:chat_app/models/message.dart';
import 'package:chat_app/screens/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../widgets/ChatBubble.dart';
import '../widgets/constant.dart';

class ChatPage extends StatelessWidget {
  ChatPage({super.key, required this.email});
  final String email;
  bool isLoadng = true;

  final ScrollController _controller = ScrollController();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy("createdAt").snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Messsage> messageList = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            messageList.add(Messsage.fromjson(snapshot.data!.docs[i]));
          }
          return Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: kPrimaryColor,
                title: Padding(
                  padding: const EdgeInsets.only(left: 100),
                  child: ListTile(
                    leading: Image.asset("assets/images/scholar.png"),
                    title: const Text(
                      "Chat",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              body: Column(children: [
                Expanded(
                  child: ListView.builder(
                      controller: _controller,
                      itemCount: messageList.length,
                      itemBuilder: (context, index) {
                        return messageList[index].id == email
                            ? ChatBubble(
                                messsage: messageList[index],
                              )
                            : ChatBubbleForFriend(
                                messsage: messageList[index],
                              );
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: controller,
                    onSubmitted: (value) {
                      messages.add({
                        "messages": value,
                        "createdAt": DateTime.now(),
                        "id": email
                      });
                      controller.clear();
                      _controller.animateTo(
                        _controller.position.maxScrollExtent,
                        duration: const Duration(seconds: 1),
                        curve: Curves.fastOutSlowIn,
                      );
                    },
                    decoration: InputDecoration(
                        hintText: "send message",
                        suffixIcon: const Icon(
                          Icons.send,
                          size: 30,
                          color: kPrimaryColor,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: kPrimaryColor))),
                  ),
                )
              ]));
        } else {
          return ModalProgressHUD(
            inAsyncCall: true,
            child: Text("loading...."),
          );
        }
      },
    );
  }
}
