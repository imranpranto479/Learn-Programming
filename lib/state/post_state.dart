import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'package:flutterd/model/post_model.dart';
import 'package:localstorage/localstorage.dart';

// global state or global class create korechi poststate name e
// poststate ke globally send krte hobe
class PostState with ChangeNotifier {
  List<Post> _posts; // data processing hoye data chole zabe posts er vitore
  // global state create krlam
  // function run hole ey request ta zabe
  List<Category> _category;

  // instance create local storage er zonno
  LocalStorage storage =
      LocalStorage("usertoken"); //user token name e local storage
  // storage er vitore token save krbo

  //-----------------Get Post------------------------------------------------------

  Future<bool> getPostData() async {
    // then function create krlam (asynchronus function)  // kichoi return krbe na
    try {
      var token = storage.getItem('token');

      // try er vitore url dilam
      String url = "http://127.0.0.1:8000/api/posts/";
      http.Response response = await http.get(url, headers: {
        'Authorization': 'token $token'
      }); // get request pathalam url diye
      var data = json.decode(response.body)
          as List; // data gulo string --> json e convert kre --> postmodel e pass krbo
      List<Post> temp = []; //empty demo list create
      data.forEach((element) {
        Post post = Post.fromJson(
            element); // json er vitor diye element pass krbo seta post class e convert krbe
        temp.add(post);
      });
      _posts = temp;
      notifyListeners();
      return true; // get request successfully hoile
    } catch (e) {
      print("error getPostData");
      print(e);
      return false; // get request successfully na hoile
    }
  }

  //-----------------Get Category data------------------------------------------------------

  Future<void> getCategoryData() async {
    // then function create krlam (asynchronus function)  // kichoi return krbe na
    try {
      var token = storage.getItem('token');

      // try er vitore url dilam
      String url = "http://127.0.0.1:8000/api/categorys/";
      http.Response response = await http.get(
        url,
        headers: {'Authorization': 'token $token'},
      ); // get request pathalam url diye
      var data = json.decode(response.body)
          as List; // data gulo string --> json e convert kre --> postmodel e pass krbo
      List<Category> temp = []; //empty demo list create
      data.forEach((element) {
        Category category = Category.fromJson(
            element); // json er vitor diye element pass krbo seta post class e convert krbe
        temp.add(category);
      });
      _category = temp;
      notifyListeners();
    } catch (e) {
      print("error getCategoryData");
      print(e);
    }
  }

//----------------------------------Add Like-----------------------------------------
  Future<void> addlike(int id) async {
    // function e call hole url borabor http request zabe.---> token diye authorization hbe--> body r vitore post er id

    try {
      var token = storage.getItem('token');

      // try er vitore url dilam
      String url = "http://127.0.0.1:8000/api/addlike/";
      http.Response response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'token $token',
        },
        body: json.encode({
          "id": id,
        }), // get request pathalam url diye}
      );
      var data = jsonDecode(response.body);
      if (data['error'] == false) {
        //data error na thakle like niye nibe
        getPostData();
      }
    } catch (e) {
      print(e);
      print("error addlike");
    }
  }

//-------------------------------Add Comment---------------------------
//----------------------- send korar process----------------------

  Future<void> addcomment(int id, String commenttext) async {
    // function e call hole url borabor http request zabe.---> token diye authorization hbe--> body r vitore post er id

    try {
      var token = storage.getItem('token');

      // try er vitore url dilam
      String url = "http://127.0.0.1:8000/api/addcomment/";
      http.Response response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'token $token',
        },
        body: json.encode({
          "id": id, //id dhora hoise id diye (model e zvabe ache)
          "comment": commenttext,
        }), // get request pathalam url diye}
      );
      var data = jsonDecode(response.body);
      if (data['error'] == false) {
        //data error na thakle like niye nibe
        getPostData();
      }
    } catch (e) {
      print(e);
      print("error addcomment");
    }
  }
//-----------------------------Comment er reply-----------------------

  Future<void> addreply(int commentid, String replytext) async {
    // function e call hole url borabor http request zabe.---> token diye authorization hbe--> body r vitore post er id

    try {
      var token = storage.getItem('token');

      // try er vitore url dilam
      String url = "http://127.0.0.1:8000/api/addreply/";
      http.Response response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'token $token',
        },
        body: json.encode({
          "commentid": commentid, //id dhora hoise id diye (model e zvabe ache)
          "replytext": replytext,
        }), // get request pathalam url diye}
      );
      var data = jsonDecode(response.body);
      if (data['error'] == false) {
        //data error na thakle like niye nibe
        getPostData();
      }
    } catch (e) {
      print(e);
      print("error addreply");
    }
  }

//-----------------------log in hole page ke redirect korbo-------------------
  Future<bool> loginNow(String username, String password) async {
    try {
      String url =
          'http://127.0.0.1:8000/api/login/'; // url borar por post request dicchi
      http.Response response = await http.post(url,
          headers: {
            "Content-Type":
                "application/json", // ki type er data send korchi post request e application/json
          },
          body: json.encode({
            // ki data send kortechi --username,--passsword
            "username": username,
            "password": password,
          }));
      var data = json.decode(response.body)
          as Map; //data map e convert kre dilam map means :dictionary (key:value)
      //print(data);
      if (data.containsKey('token')) {
        // zodi token dey successful
        // token local storage e save kre rakhtehbe
        //print(data['token']);
        storage.setItem(
            'token',
            data[
                'token']); // token ekhane set kore rakha hoyeche local storage e
        //print(storage.getItem('token')); // local storage er data
        return false;
      }
      return true;
    } catch (e) {
      print(e);
      print("error login now");
      return true; // meaning error ache

    }
  }

  //------------------------Register Now---------------------

  Future<bool> registerNow(String username, String password) async {
    try {
      String url =
          'http://127.0.0.1:8000/api/register/'; // url borar por post request dicchi
      http.Response response = await http.post(url,
          headers: {
            "Content-Type":
                "application/json", // ki type er data send korchi post request e application/json
          },
          body: json.encode({
            // ki data send kortechi --username,--passsword
            "username": username,
            "password": password,
          }));
      var data = json.decode(response.body)
          as Map; //data map e convert kre dilam map means :dictionary (key:value)

      return data["error"];
    } catch (e) {
      print(e);
      print("error register now");
      return true; // meaning error ache

    }
  }

  //post private variable e tai
  List<Post> get post {
    if (_posts != null) {
      return [..._posts];
    } else {
      return null;
    }
  }

  List<Category> get category {
    if (_category != null) {
      return [..._category];
    } else {
      return null;
    }
  }
//-------------------Post retreive kora (alada page e z post dekhabe)-----------------

  Post singlepost(int id) {
    return _posts.firstWhere((element) => element.id == id);
    //single post ke dhore return kore diyechi
    //id r upr depend kre single post dhora hoyeche
  }

  //------------------category r under e post-----------------

  List<Post> categorypost(int id) {
    return [
      ..._posts.where((element) => element.category.id == id)
    ]; //...posts er copy create korbe then copy theke filter krbe
    //list of post ke dhore return kore diyechi
    //category r id r upr depend kre  sob post return kora hoyeche
  }
}
