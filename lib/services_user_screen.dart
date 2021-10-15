import 'dart:convert';

import 'package:flutter/material.dart';
import 'model/modelo.dart';
import 'navigation_home_screen.dart';
import 'navigation_home_employee_screen.dart';
import 'register_employee_jobs_screen.dart';
import 'package:http/http.dart' as http;
class _ArticleDescription extends StatelessWidget {
  const _ArticleDescription({

    required this.title,
    required this.subtitle,
    required this.author,
    required this.publishDate,
    required this.readDuration,
  }) : super();

  final String title;
  final String subtitle;
  final String author;
  final String publishDate;
  final String readDuration;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Flexible(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 2.0)),
              Text(
                subtitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(
                author,
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.black87,
                ),
              ),
              Text(
                '$publishDate - $readDuration',
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CustomListItemTwo extends StatelessWidget {
  const CustomListItemTwo({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.author,
    required this.publishDate,
    required this.readDuration,
  }) : super();

  final String title;
  final String subtitle;
  final String author;
  final String publishDate;
  final String readDuration;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: SizedBox(
        height: 100,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 0.0, 2.0, 0.0),
                child: _ArticleDescription(
                  title: title,
                  subtitle: subtitle,
                  author: author,
                  publishDate: publishDate,
                  readDuration: readDuration,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ServicesUserScreen extends StatelessWidget{

  ServicesUserScreen({Key? key, }) : super(key: key);
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    double screenSize = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body:
      Column(

        children: <Widget>[
          Stack(
            children: <Widget>[
              RotationTransition(
                turns: const AlwaysStoppedAnimation(180 / 360),
                child: SizedBox(
                  width: screenSize,
                  height: screenheight * 0.10,
                  child: const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFFFF6365),
                          Color(0xFFF96332),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ),
              ),


            ],
          ),
          SizedBox(height: screenheight * 0.02,),
          Row(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(
                    left: 12.0,
                    right: 12.0
                ),
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    color: const Color(0xffe0e0e0)
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => NavigationHomeScreen()));
                  },
                  borderRadius: BorderRadius.circular(30.0),
                  // ignore: prefer_const_constructors
                  child: Center(
                    child: const Icon(Icons.arrow_back, color: Color(0xfff96332)),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                child:const Text(
                  'Servicios',
                  style: TextStyle(fontWeight: FontWeight.bold,
                      fontSize: 25),
                ),
              ),

            ],
          ),
          Container(
            alignment: Alignment.center,
            child:const Text(
              'Solicitados',
              style: TextStyle(fontSize: 18),
            ),
          ),
          FutureBuilder(
            future: datosprestadorservicios(),
            builder: (BuildContext context, AsyncSnapshot snapshot){
              List<dynamic> snapdata = snapshot.data;
              ConnectionState conn = snapshot.connectionState;

              if(conn == ConnectionState.waiting){
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if(snapshot.hasError){
                return Center(
                  child: Text("Error,: ${snapshot.error}"),
                );
              }
              return Flexible(
                flex: 1,
                child: ListView.builder(padding: EdgeInsets.zero,itemCount: snapdata.length,
                  itemBuilder: (context,index){
                    return CustomListItemTwo(
                      title: "${snapshot.data[index]["title"]}",
                      subtitle: "${snapshot.data[index]["body"]}"
                      ,
                      readDuration: 'Ernesto Oropeza',
                      publishDate: '6 jul 2021',
                      author: '500MXN',
                    );
                  },
                ),
              );
            },
          ),



          // floatingActionButton: FloatingActionButton(
          // onPressed: _incrementCounter,
          // tooltip: 'Increment',
          // child: const Icon(Icons.add),
          // ), // This trailing comma makes auto-formatting nicer for build methods.
        ],
      ),
    );
  }
}