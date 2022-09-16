import 'package:flutter/material.dart';
import 'package:flutterd/state/post_state.dart';
import 'package:provider/provider.dart';

import '../widgets/single_Post.dart';

//-----------------------------home_screens copy--------------------------

class CategoryScreens extends StatefulWidget {
  static const routeName =
      '/category-screens'; // ek screen theke arek screen e zawai holo route
  @override
  State<CategoryScreens> createState() => _CategoryScreensState();
}

class _CategoryScreensState extends State<CategoryScreens> {
  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments;
    final posts =
        Provider.of<PostState>(context).categorypost(id); //list of posts
    print(id);
    return posts.length == 0
        ? Scaffold(
            appBar: AppBar(
              title: Text("No Post for This Category"),
            ),
            body: Center(child: Text("No Post")),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text("All Post for ${posts[0].category.title}"),
              centerTitle: true,
            ),
            body: ListView.builder(
                itemCount: posts.length,
                itemBuilder: (context, i) {
                  return SinglePost(
                    posts[i],
                  ); //single_post er vitore post send kore dicchi
                }),
          );
  }
}
