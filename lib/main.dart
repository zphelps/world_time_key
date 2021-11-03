import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:world_time_key/views/choose_location.dart';
import 'package:world_time_key/views/home.dart';
import 'package:world_time_key/views/loading.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
      routes: {
        '/': (context) => Loading(),
        '/home': (context) => Home(),
        '/location': (context) => ChooseLocation(),
      }
  ));
}

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {

  String joke = '';

  void getMeme() async {
    try{
      // make the request
      Response response = await get(Uri.parse('https://geek-jokes.sameerkumar.website/api?format=json'));
      Map data = jsonDecode(response.body);

      setState(() {
        joke = data['joke'];
      });
    }
    catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMeme();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          joke,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getMeme();
        },
      ),
    );
  }
}


