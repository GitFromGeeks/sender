library sender;

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Sender extends StatefulWidget {
  TextEditingController messageController;
  final Function onPressed;
  Sender({Key? key, required this.messageController, required this.onPressed})
      : super(key: key);

  @override
  State<Sender> createState() => _SenderState();
}

class _SenderState extends State<Sender> {
  late bool isEmojiUp;
  @override
  void initState() {
    super.initState();
    isEmojiUp = false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 65),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: AnimatedContainer(
              duration: const Duration(seconds: 1),
              curve: Curves.fastLinearToSlowEaseIn,
              decoration: BoxDecoration(
                  color: Colors.amber[100],
                  borderRadius: BorderRadius.circular(30.0)),
              // width: 250,
              width: (isEmojiUp) ? 275 : 0,
              child: FittedBox(
                fit: BoxFit.contain,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      emojiButton(context, "😃", widget.onPressed),
                      emojiButton(context, "😡", widget.onPressed),
                      emojiButton(context, "😍", widget.onPressed),
                      emojiButton(context, "🤣", widget.onPressed),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            color: Colors.grey,
            height: MediaQuery.of(context).size.height * 0.07,
            child: SingleChildScrollView(
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        setState(() {
                          isEmojiUp = true;
                        });
                      },
                      icon: const Icon(Icons.emoji_emotions)),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: TextFormField(
                            controller: widget.messageController,
                            keyboardType: TextInputType.streetAddress,
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: "                   Message"),
                          ),
                        ),
                      )),
                  const Spacer(),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          isEmojiUp = false;
                        });
                        widget.onPressed;
                      },
                      icon: const Icon(
                        Icons.send,
                        color: Colors.blueAccent,
                      ))
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}

Widget emojiButton(context, String msg, Function onPressed) {
  return TextButton(
    onPressed: () {
      onPressed;
    },
    child: Text(
      msg,
      style: const TextStyle(fontSize: 30),
    ),
  );
}
