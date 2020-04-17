import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'dart:convert';

void main() => runApp(COVID19Tracker());


class COVID19Tracker extends StatefulWidget {
  @override
  COVID19TrackerState createState() {
    return COVID19TrackerState();
  }
}

class COVID19TrackerState extends State<COVID19Tracker> {
  // This widget is the root of your application.
  var countries=[];
  List list = List();
  var isLoading = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
          title: Text('COVID-19 Tracker'), backgroundColor: Colors.black),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: RaisedButton(
          child: new Text("Fetch Global Data"),
          onPressed: () => _fecthData()
        ),
      ),
      body: isLoading ?
        Center(
          child:CircularProgressIndicator()
        ) :
      new ListView.builder(
        itemCount: list == null ? 0 : list.length,
        itemBuilder: (BuildContext context, int index){
          return new Card(
            child: new Text("hey"),
          );
        },
      ),
        )


    );

  }

  _fecthData() async{

    print('Starting fetch data');

    setState(() {
      isLoading = true;
    });


    const String url='https://api.covid19api.com';
    const String wolrdTotalService='/world/total';
    Response response = await get(url+wolrdTotalService);
    // sample info available in response
    int statusCode = response.statusCode;

    if(statusCode == 200 ){

      Map<String, String> headers = response.headers;
      String contentType = headers['content-type'];
      print(response.body);
      //this.list = json.decode(response.body) as List;
      Map<String, dynamic> totalCases = jsonDecode(response.body);

      setState(() {
        isLoading = false;
      });

    }
    else {
      throw Exception('Failed to fetch COVID data');
    }



  }




}


