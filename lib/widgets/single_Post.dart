import 'package:flutter/material.dart';
import 'package:flutterd/model/post_model.dart';
import 'package:flutterd/screens/category_screens.dart';
import 'package:flutterd/screens/post_details_screens.dart';
import 'package:flutterd/state/post_state.dart';
import 'package:flutterd/widgets/single_comments.dart';
import 'package:provider/provider.dart';

class SinglePost extends StatefulWidget {
  // stateful karon comment korle update hobe state
  final Post post;
  SinglePost(this.post);
  @override
  State<SinglePost> createState() => _SinglePostState();
}

class _SinglePostState extends State<SinglePost> {
  bool _showComments = false; // comment er khetre
  //constructor create
  String commenttitle = '';
  final commentcontroller = TextEditingController();
  // comment submit howar por zate comment box faka hoye zay

  void _addComment() {
    //button e click krle ey (addComment function cholbe)
    if (commenttitle.length <= 0) {
      return;
    }
    Provider.of<PostState>(context, listen: false).addcomment(
        widget.post.id, commenttitle); // server e data pathanor zonno
    commentcontroller.text = '';
    commenttitle = '';
    setState(() {}); // comment box faka howar por button e disable hoye gese
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          // single post column er under e thakbe
          crossAxisAlignment:
              CrossAxisAlignment.start, // left side e aanar zonno
          children: [
            Row(
              // row te post title dekhacche
              children: [
                GestureDetector(
                  // text e touch krle detect krte pare
                  onTap: () {
                    //print("title is clicked");
                    Navigator.of(context).pushNamed(
                        PostDetailsScreens.routeName,
                        arguments: widget.post
                            .id); //z post er details dekhte chacchi se post er (id) navigation er sathe send kore diyechi
                  },
                  child: Text(
                    widget.post.title,
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(CategoryScreens.routeName,
                        arguments: widget.post.category
                            .id); //z catergory er details dekhte chacchi se category er (id) navigation er sathe send kore diyechi
                  },
                  child: Card(
                      child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Text(widget.post.category.title),
                  )),
                ), // post er pase kun cateogry r dekhabe
              ],
            ),
            //-----------------------------code-------------------------------

            if (widget.post.code.length != 0)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Code: ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    child: Card(
                        color: Theme.of(context).primaryColor,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(widget.post.code),
                        )),
                  ), // code gulo card e dekhabe
                ],
              ),

            //---------------------------content-------------------------
            widget.post.content.length > 100
                ? Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${widget.post.content.substring(0, 100)}...",
                          style: TextStyle(fontSize: 16),
                        ),
                        GestureDetector(
                          onTap: () {
                            //print("Read more CLicked");
                            Navigator.of(context).pushNamed(
                                PostDetailsScreens.routeName,
                                arguments: widget.post
                                    .id); //z post er details dekhte chacchi se post er (id) navigation er sathe send kore diyechi
                          },
                          child: Text(
                            "Read More",
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : Container(
                    child: Text(
                      "${widget.post.content}",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
            Divider(),
            //---------------------------Like button----------------------------------
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment
                    .spaceEvenly, // zayga duisite theke soman nise
                children: [
                  FlatButton.icon(
                    onPressed: () {
                      Provider.of<PostState>(context, listen: false).addlike(
                          widget.post
                              .id); // global state e data zacche tai listen false
                    },
                    icon: Icon(
                      widget.post.like
                          ? Icons.favorite
                          : Icons
                              .favorite_border, //like hole fill dekhabe like na thakle just icon dekhabe
                      color: Colors.red,
                    ),
                    label: Text(
                      "Like(${widget.post.totalLike})", //total koita like
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  //---------------------------Comment button-------------------
                  FlatButton.icon(
                    onPressed: () {
                      setState(() {
                        _showComments =
                            !_showComments; //click krle show comments true hoye zabe rpor condition e giye comment box e zabe
                      });
                    },
                    icon: Icon(
                      Icons.comment,
                      color: Colors.blue[300],
                    ),
                    label: Text(
                      "Comment(${widget.post.comment.length})", // comment kotogula seta
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  )
                ],
              ),
            ),
            //-------------------------Comment box-------------------
            if (_showComments)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: TextField(
                      controller: commentcontroller, //
                      onChanged: (v) {
                        setState(() {
                          commenttitle =
                              v; //z text lekhbo seta chole zabe comment title er vitore
                        });
                      },
                      decoration: InputDecoration(
                        hintText: "Comment...",
                        suffix: IconButton(
                          onPressed: commenttitle.length <= 0
                              ? null
                              : () {
                                  _addComment(); //
                                }, // 0 or 0 er kom length hole button disable thakbe
                          icon: Icon(Icons.send),
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                  //-----------comment gulo card e dekhano zonno-------------
                  Container(
                    child: Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: widget.post.comment
                            .map(
                              (e) => SingleComment(e),
                            )
                            .toList(),
                        // ekhane list of comment ache, map e single comment chole acsche
                        // single comment ke single comment section e pathiye dewa hoise
                      ),
                    ),
                  ),
                ],
              )
          ],
        ),
      ),
    );
  }
}
