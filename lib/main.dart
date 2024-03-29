import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:parsejson/GoogleService.dart';
import 'package:parsejson/Homepage.dart' as prefix0;


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {

  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

   Future <List<Photo>>  fetchPhoto (Client client) async{

     var url = "https://jsonplaceholder.typicode.com/photos";
     var response = await http.get(url);

     return parsePhotos(response.body);


   }

   List<Photo> parsePhotos(String responseBody){
    final  parsed = json.decode(responseBody).cast<Map<String, dynamic>>();


//    return parsed.map<Photo>((json)=>Photo.fromJson(json)).toList();

     var rest = parsed["title"]
    return rest;

   }






  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: FutureBuilder<List<Photo>>(

        future: fetchPhoto(http.Client()),
        builder: (context,snapshot){
          if (snapshot.hasError) print(snapshot.error);

         return snapshot.hasData
            ? PhotosList(photos:snapshot.data)
            : Center(child: CircularProgressIndicator());

        },
      )
    );
  }
}

class PhotosList extends StatelessWidget{


  final List<Photo> photos;
  PhotosList({Key key,this.photos}):super(key:key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GridView.builder(

      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        
      ),
      itemCount: photos.length,
      itemBuilder: (context,index){
        return Image.network(photos[index].thumbnailUrl);
      },


    );
  }

}
