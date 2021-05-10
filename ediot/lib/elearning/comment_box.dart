import 'package:comment_box/comment/comment.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Comment_Box extends StatefulWidget {
  @override
  _TestMeState createState() => _TestMeState();
}

class _TestMeState extends State<Comment_Box> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController commentController = TextEditingController();
  List filedata = [];
  final auth = FirebaseAuth.instance;

  Widget commentChild(data) {
    return ListView(
      children: [
        for (var i = 0; i < data.length; i++)
          Card(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(2.0, 8.0, 2.0, 0.0),
              child: ListTile(
                leading: GestureDetector(
                  onTap: () async {
                    // Display the image in large form.
                    print("Comment Clicked");
                  },
                  child: Container(
                    height: 50.0,
                    width: 50.0,
                    decoration: new BoxDecoration(
                        color: Colors.blue,
                        borderRadius:
                            new BorderRadius.all(Radius.circular(50))),
                    child: CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(data[i]['pic'] + "$i")),
                  ),
                ),
                title: Text(
                  data[i]['name'],
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  data[i]['message'],
                  style: TextStyle(),
                ),
              ),
            ),
          ),
        Row(children: <Widget>[
          Expanded(child: Divider()),
        ])
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Comment Box",
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.purple[400],
      ),
      body: Container(
        child: CommentBox(
          userImage: "",
          child: commentChild(filedata),
          labelText: 'Write a comment...',
          withBorder: false,
          errorText: 'Comment cannot be blank',
          sendButtonMethod: () {
            if (formKey.currentState!.validate()) {
              print(commentController.text);
              setState(() {
                var value = {
                  'name': auth.currentUser!.email!,
                  'pic': '',
                  'message': commentController.text
                };
                filedata.insert(0, value);
              });
              commentController.clear();
              FocusScope.of(context).unfocus();
            } else {
              print("Not validated");
            }
          },
          formKey: formKey,
          commentController: commentController,
          // backgroundColor: Colors.purple,
          // textColor: Colors.white,
          sendWidget:
              Icon(Icons.send_sharp, size: 30, color: Colors.purple[400]),
        ),
      ),
    );
  }
}
