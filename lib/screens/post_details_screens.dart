import 'package:flutter/material.dart';
import 'package:flutterd/state/post_state.dart';
import 'package:provider/provider.dart';

import '../widgets/single_comments.dart';

class PostDetailsScreens extends StatefulWidget {
  static const routeName = '/post-details-screens';

  @override
  State<PostDetailsScreens> createState() => _PostDetailsScreensState();
}

class _PostDetailsScreensState extends State<PostDetailsScreens> {
  // -----------------same code as single_post---------------

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
    final id = ModalRoute.of(context).settings.arguments;

    Provider.of<PostState>(context, listen: false)
        .addcomment(id, commenttitle); // server e data pathanor zonno
    commentcontroller.text = '';
    commenttitle = '';
    setState(() {}); // comment box faka howar por button e disable hoye gese
  }

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments;
    // z arguments sent korechi, se argument dhorechi ekhane id variable e
    // karon id er maddhome se post take dhorbo z post er details dekhte chacchi
    final post = Provider.of<PostState>(context).singlepost(id);
    //global state(Post state) theke single post dhore fellam
    return Scaffold(
      appBar: AppBar(
        title: Text(post.title),
      ),
      body: SingleChildScrollView(
        child: Card(
          // -----------------same code as single_post---------------
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
                    Text(
                      post.title,
                      style: TextStyle(fontSize: 18),
                    ),
                    Card(
                        child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Text(post.category.title),
                    )), // post er pase kun cateogry r dekhabe
                  ],
                ),
                //-----------------------------code-------------------------------

                if (post.code.length != 0)
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
                              child: Text(post.code),
                            )),
                      ), // code gulo card e dekhabe
                    ],
                  ),

                //---------------------------content-------------------------
                post.content.length > 100
                    ? Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              post.content,
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      )
                    : Container(
                        child: Text(
                          "${post.content}",
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
                          Provider.of<PostState>(context, listen: false)
                              .addlike(post
                                  .id); // global state e data zacche tai listen false
                        },
                        icon: Icon(
                          post.like
                              ? Icons.favorite
                              : Icons
                                  .favorite_border, //like hole fill dekhabe like na thakle just icon dekhabe
                          color: Colors.red,
                        ),
                        label: Text(
                          "Like(${post.totalLike})", //total koita like
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
                          "Comment(${post.comment.length})", // comment kotogula seta
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
                            children: post.comment
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
        ),
      ),
    );
  }
}
