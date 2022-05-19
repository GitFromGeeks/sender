<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->

It is easy to use flutter package that you will need to built a chating application,
where this package "Sender" will provide you the TextField along with the emoji reaction
option with animatedContainer. you will have to pass ONPressed so when you click on it. it 
will send the message to the backend/Firestore.

## Features

 you will have to pass these requested parameters atleast.
  messageController;
  final Function onPressed;

## Getting started


flutter pub get sender
import 'package:sender/sender.dart';


sender.messageController = "pass you message controller here "
sender.onPressed = " pass your onPressed function to be executed when emoji is been clicked on send message button"

## Usage

TODO: Include short and useful examples for package users. Add longer examples
to `/example` folder. 

```dart
import 'package:flutter/material.dart';
import 'package:sender/sender.dart';

class Chatroom extends StatelessWidget {
  Chatroom({Key? key, required this.docId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController messageController = TextEditingController();
    bool isEmojiUp = Provider.of<IsEmoji>(context).isEmojiUp;
    return Scaffold(
      appBar: AppBar(
        title: Text(docId!),
      ),
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.83,
            child: StreamBuilder<QuerySnapshot>(
              stream: FirestoreDatabase.getChating(docId: docId!),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        return (snapshot.data!.docs[index]['user'] != usern)
                            ? ListTile(
                                leading: CircleAvatar(
                                    child: Text(
                                  snapshot.data!.docs[index]['user'],
                                  style: const TextStyle(fontSize: 12),
                                )),
                                title: Card(
                                    color: const Color.fromARGB(
                                        255, 202, 198, 198),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(snapshot.data!.docs[index]
                                          ['message']),
                                    )),
                              )
                            : sendingCard(snapshot.data!.docs[index]['user'],
                                snapshot.data!.docs[index]['message']);
                      },
                    ),
                  );
                } else {
                  return const Text("EMPTY ");
                }
              },
            ),
          ),
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
                        emojiButton(context, isEmojiUp, docId!, "😃"),
                        emojiButton(context, isEmojiUp, docId!, "😡"),
                        emojiButton(context, isEmojiUp, docId!, "😍"),
                        emojiButton(context, isEmojiUp, docId!, "🤣"),
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
                          Provider.of<IsEmoji>(context, listen: false)
                              .changeIsEmojiUp(!isEmojiUp);
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
                              controller: messageController,
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
                          FirestoreDatabase.sendMessage(
                              docId: docId!, message: messageController.text);
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
      ),
    );
  }
}

Widget sendingCard(String user, message) {
  return Row(
    children: [
      Expanded(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
              color: const Color.fromARGB(255, 202, 198, 198),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(message),
              )),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(right: 8),
        child: CircleAvatar(
            child: Text(
          user,
          style: const TextStyle(fontSize: 12),
        )),
      ),
    ],
  );
}

```

## Additional information

To get to know more about the package. head towards github repositories
 GitHub : https://github.com/GitFromGeeks/sender
get feel free to share your thoughts with me on my email "mohammadaltamashusain@gmail.com"
