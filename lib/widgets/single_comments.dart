import 'package:flutter/material.dart';
import 'package:flutterd/model/post_model.dart';
import 'package:flutterd/state/post_state.dart';
import 'package:flutterd/widgets/single_Reply.dart';
import 'package:provider/provider.dart';

class SingleComment extends StatefulWidget {
  final Comment comment; //Comment object ta astese (model er comment e theke )
  SingleComment(
      this.comment); // constructor create kora hoise single comment zate nite pare
  @override
  State<SingleComment> createState() => _SingleCommentState();
}

class _SingleCommentState extends State<SingleComment> {
  bool _showReply = false; // reply dekhanor condition e use
  String replytext = '';
  final replycontroller = TextEditingController();
  // comment submit howar por zate comment box faka hoye zay
  void _addreply() {
    if (replytext.length <= 0) {
      return;
    }
    Provider.of<PostState>(context, listen: false)
        .addreply(widget.comment.id, replytext); // server e data pathanor zonno
    replycontroller.text = '';
    replytext = '';
    setState(() {}); // comment box faka howar por button e disable hoye gese
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          //----------------------------comment er box create----------------------
          children: [
            Text(
              " By ${widget.comment.user.username} at ${widget.comment.time}",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            Container(
              margin: EdgeInsets.only(left: 10),
              padding: EdgeInsets.all(4),
              child: Text(
                widget.comment.title,
                style: TextStyle(
                  fontSize: 13,
                ),
              ),
            ),
            //-----------------reply box creation----------------
            FlatButton(
              onPressed: () {
                setState(() {
                  _showReply =
                      !_showReply; //false thake true or true thakle false
                });
              },
              child: Text(
                "Reply(${widget.comment.reply.length})", //Widget. Dewa lage karon—> Stateful widget e zodi stateful er field e variable or constructor delcare kri. sekhan theke zodi niche sey variable ta dhorte chai sekhane widget. Use hoy

                style: TextStyle(
                    backgroundColor: Colors.blue[200],
                    color: Colors.black,
                    fontSize: 10,
                    fontWeight: FontWeight.bold),
              ),
            ),
            //-------------------reply button e click krle reply dekhabe
            if (_showReply) // true hole
              Container(
                margin: EdgeInsets.only(left: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: TextField(
                        controller: replycontroller,
                        onChanged: (value) {
                          setState(() {
                            replytext = value; //value diye update kora hoyeche
                          });
                        },
                        decoration: InputDecoration(
                            hintText: "Reply",
                            suffix: IconButton(
                              onPressed: replytext.length <= 0
                                  ? null
                                  : () {
                                      _addreply();
                                    },
                              icon: Icon(Icons.send),
                              color: Colors.blue,
                            )),
                      ),
                    ),
                    //----------------comment er reply------------------
                    if (widget.comment.reply.length != 0)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: widget.comment.reply
                            .map(
                              (r) => SingleReply(
                                  r), //single reply pathaiye dewa hoise single_reply e
                            )
                            .toList(),
                      )
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }
}
