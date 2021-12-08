// ignore_for_file: non_constant_identifier_names

import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:servicios_vic/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfigurationEmployeeScreen extends StatefulWidget {
  const ConfigurationEmployeeScreen({Key? key}) : super(key: key);

  @override
  ConfigurationEmployeeState createState() => ConfigurationEmployeeState();
}

class ConfigurationEmployeeState extends State<ConfigurationEmployeeScreen> {
  String idUser = '';

  Future<void> getId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String id = prefs.getString('id') ?? '';

    setState(() => idUser = id);
  }

  @override
  Widget build(BuildContext context) {
    if (idUser == '') {
      getId();
    }
    double screenSize = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Color(0xFFF1F0F5),
            elevation: 0,
            shadowColor: Colors.transparent,
            foregroundColor: const Color(0xFFF96332),
            title: const Text(
              'Configuraciónes',
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.black,
              ),
            )),
        body: Container(
        color: Color(0xFFF1F0F5),
          child: Column(
            children: <Widget>[
              SizedBox(height:screenHeight * 0.05),
              Container(
                  margin: const EdgeInsets.only(left: 12.0,top: 6.0, bottom: 6.0),
                  child: InkWell(
                    onTap: () async {
                       SharedPreferences prefs = await SharedPreferences.getInstance();
                        prefs.remove('id');
                        prefs.remove('type');
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (BuildContext ctx) => const HomeScreen()));
                    },
                    child: Row(
                      children: <Widget>[
                        const Icon(Icons.logout, size: 30.0),
                        SizedBox(width: screenSize*0.02,),
                        const Text('Cerrar Sesión',style: TextStyle(fontSize: 18.0,color: Colors.black,),),
                      ],
                    )
                  )
                ),
              Divider(thickness: 1,),
              Container(
                  margin: const EdgeInsets.only(left: 12.0,top: 6.0, bottom: 6.0),
                  child: InkWell(
                    onTap: () {
                       
                    },
                    child: Row(
                      children: <Widget>[
                        const Icon(Icons.question_answer, size: 30.0),
                        SizedBox(width: screenSize*0.02,),
                        const Text('Comentarios',style: TextStyle(fontSize: 18.0,color: Colors.black,),),
                      ],
                    )
                  )
                ),
              Divider(thickness: 1,),
            ],
          ),
        ));
  }
}
