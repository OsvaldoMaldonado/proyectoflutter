import 'dart:convert';

import 'package:flutter/material.dart';
import 'model/modelo.dart';
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

class ServicesEmployeeScreen extends StatefulWidget{
  final Future<String?> id_usuario;
  ServicesEmployeeScreen({Key? key, required this.id_usuario}) : super(key: key);

  @override
  State<ServicesEmployeeScreen> createState() => _ServicesEmployeeScreenState();
}

class _ServicesEmployeeScreenState extends State<ServicesEmployeeScreen> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    int contador = 0;
    String contador2 = "";
    int numero2 = 0;
    String numero="";
    int contador3 = 0;
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
                        MaterialPageRoute(builder: (context) => NavigationEmployeeScreen(id_usuario: widget.id_usuario)));
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
            child: Text(
              'Prestados' ,
              style: TextStyle(fontSize: 18),
            ),
          ),
          FutureBuilder(
            future: datosprestadorservicios2(),
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


              return Container(
                width: screenSize * 0.45,
                height: screenheight * 0.05,
                alignment: Alignment.centerLeft,
                child: ListView.builder(padding: EdgeInsets.zero,itemCount: snapdata.length,

                  itemBuilder: (context,index){
                    numero = "${snapshot.data[index]["costo"]}"; // aqui es cambiar el title por como se llame el monto total
                    numero2 = int.parse(numero);
                    print(numero2);
                    contador = contador + numero2;
                    print(contador);
                    contador2 = contador.toString();
                    print(","+contador2);
                    contador3++;
                    if (snapdata.length == contador3) {
                      return  Container(
                        width: screenSize * 0.45,
                        height: screenheight * 0.05,
                        child:  Text(
                          'Ganancias totales: $contador2                           '   ,
                          style: TextStyle(fontSize: 16),
                        ),

                      );
                    } else {
                      return Visibility (child: Text(""),
                          visible: false);
                    }
                  },

                ),
              );
            },
          ),
          FutureBuilder(
            future: datosprestadorservicios2(),
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
                      title: "${snapshot.data[index]["descripcion"]}",
                      subtitle: "${snapshot.data[index]["resena"]}",
                      readDuration: '',
                      publishDate: 'Monto: '"${snapshot.data[index]["costo"]}",
                      author: "${snapshot.data[index]["fecha_publicacion"]}",

                    );
                  },

                ),
              );
            },
          ),

          Container(
            alignment: Alignment.center,
            child:const Text(
              'En proceso',
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
                      readDuration: '',
                      publishDate: '4 jul 2021',
                      author: '500MXN',
                    );
                  },
                ),
              );
            },
          ),
          Container(
            alignment: Alignment.center,
            child:const Text(
              'Cancelados',
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
                      readDuration: 'Juan',
                      publishDate: '4 jul 2021',
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