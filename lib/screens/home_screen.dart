//main.dart --> home_screen.dart

import 'package:flutter/material.dart';
import 'package:flutterd/state/post_state.dart';
import 'package:flutterd/widgets/app_drawer.dart';
import 'package:flutterd/widgets/single_Post.dart';
import 'package:flutterd/widgets/single_category.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

class HomeScreens extends StatefulWidget {
  // smart navigation er zonno
  static const routeName = '/home-screens';
  @override
  _HomeScreensState createState() => _HomeScreensState();
}

class _HomeScreensState extends State<HomeScreens> {
  // main theke ey screen asbe
// did change dependecy--> app er vitore (homepage e scroll, ek page theke arek pagee )-> sob action e reaction dibe (bar e bar e reload dibe). restriction-->home page open krley function zate age run hoy
  bool _init = true;
  bool _isloading = false;

  @override
  void didChangeDependencies() async {
    if (_init) {
      Provider.of<PostState>(context, listen: false)
          .getCategoryData(); // cateogry call hbe

      _isloading = await Provider.of<PostState>(context, listen: false)
          .getPostData(); // data r nirvor kore isloading true hobe
      // data change howar karone set state
      setState(() {});
      //global sstate er daata dhorte pare....listen:false dewana thakle reload hbe
    }
    _init = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final posts = Provider.of<PostState>(context)
        .post; // sb gulo post dhorbo---global state dhorbo --> data gulo global state e ache
    final category = Provider.of<PostState>(context).category;
    // cateogry ke import korte hobe global state theke
    if (_isloading == false || posts == null || category == null)
      return Scaffold(
        body: Center(
            child: CircularProgressIndicator()), // loading er moto ghurar sign
      );
    else
      // ignore: curly_braces_in_flow_control_structures
      return Scaffold(
          drawer: AddDrawer(), // left side button
          appBar: AppBar(
            title: Text("Learn Programming"),
            centerTitle: true,
          ),
          body: Column(
            children: [
              Container(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal, //left to right
                  itemCount: category.length,
                  itemBuilder: (context, i) {
                    return SingleCategory(category[
                        i]); // single category function ey sb category dekhabe
                  },
                ),
              ),
              Divider(),
              Expanded(
                child: ListView.builder(
                    itemCount: posts.length,
                    itemBuilder: (context, i) {
                      return SinglePost(
                        posts[i],
                      );
                    }),
              ), // category r niche zayga purata post er zonno
            ],
          ));
  }
}
