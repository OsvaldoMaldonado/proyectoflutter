// ignore_for_file: non_constant_identifier_names

import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:servicios_vic/model/modelo.dart';
import 'package:servicios_vic/navigation_home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  UserProfileState createState() => UserProfileState();
}


class UserProfileState extends State<UserProfileScreen> {

    String idUser = '';

    Future<void> getPhone() async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String id = prefs.getString('id') ?? '';

      setState(() => idUser = id);
    }
  
  @override
  Widget build(BuildContext context) {
    if (idUser == ''){
      getPhone();
    }
    double screenSize = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: <Widget>[
          // TOP HEADER
          Container(
            alignment: Alignment.topCenter,
            margin: const EdgeInsets.only(top: 45.0),
            child: Row(
              // ignore: prefer_const_literals_to_create_immutables
              children: <Widget>[
                // ignore: prefer_const_constructors
                Container(
                  margin: const EdgeInsets.only(
                    left: 12.0,
                    right: 12.0
                  ),
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    color: const Color(0xffe0e0e0)
                  ),
                  child: InkWell(
                    onTap: () {
                       Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const NavigationHomeScreen()));
                    },
                    borderRadius: BorderRadius.circular(30.0),
                      // ignore: prefer_const_constructors
                    child: Center(
                      child: const Icon(Icons.arrow_back, color: Color(0xfff96332)),
                    ),
                  ),
                ),
                const Text('Mi cuenta', 
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.black,
                    ),
                  )
              ],
            ),
          ),
          // PROFESIONES
          Container(
            alignment: Alignment.topLeft,  
            width: screenSize * 0.90,
            child: FutureBuilder<List<User>?>(   
              future: fetchUser(http.Client(), idUser),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text('An error has occurred!'),
                  );
                } else if (snapshot.hasData) {
                  return Perfil(perfil: snapshot.data!);
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
       ],
      ),
    );
  }
}

class Perfil extends StatelessWidget {
  const Perfil({Key? key, required this.perfil}) : super(key: key);

  final List<User> perfil;
  @override
  Widget build(BuildContext context) {
    double screenSize = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: perfil.length,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(
              left: 6.0,
              right: 6.0,
              bottom: 10.0
          ),
          height: screenheight * .70,
          width: screenSize * .90,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                width: 100.0,
                height: 100.0,
                // ignore: prefer_const_constructors
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: const DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(
                          "https://t2.uc.ltmcdn.com/images/7/0/0/img_como_saber_si_un_hombre_es_maduro_34007_600_square.jpg")
                          )
                ) 
              ),
              Container(
                margin: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                alignment: Alignment.centerLeft,
                child: Row(
                  children: <Widget>[
                    Text("Correo Electronico >   " + perfil[index].correo, textAlign: TextAlign.left,style: const TextStyle(fontSize: 18),),
                    SizedBox(width: screenSize * 0.1,),
                    const InkWell(
                      child: Text('Editar', style: TextStyle(color: Colors.grey, fontSize: 14),textAlign: TextAlign.end,),
                    ),
                  ],
                ),
              ),
              const Divider(color: Color(0xFFF96332),thickness: 2.0),
              Container(
                margin: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                alignment: Alignment.centerLeft,
                child: Row(
                  children: <Widget>[
                  Text("Nombre >   " + perfil[index].nombre, textAlign: TextAlign.left,style: const TextStyle(fontSize: 18),),
                  SizedBox(width: screenSize * 0.46,),
                  const InkWell(
                      child: Text('Editar', style: TextStyle(color: Colors.grey, fontSize: 14),textAlign: TextAlign.end,),
                    ),
                  ],
                ),
              ),
              const Divider(color: Color(0xFFF96332),thickness: 2.0),
              Container(
                margin: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                alignment: Alignment.centerLeft,
                child: Row(
                  children: <Widget>[
                  Text("Apellido >   " + perfil[index].apellido, textAlign: TextAlign.left,style: const TextStyle(fontSize: 18),),
                  SizedBox(width: screenSize * 0.36,),
                  const InkWell(
                      child: Text('Editar', style: TextStyle(color: Colors.grey, fontSize: 14),textAlign: TextAlign.end,),
                    ),
                  ],
                ),
             ),
              const Divider(color: Color(0xFFF96332),thickness: 2.0),
              Container(
                margin: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                alignment: Alignment.centerLeft,
                child: Row(
                  children: <Widget>[
                  Text("Telefono >  " + perfil[index].telefono, textAlign: TextAlign.left,style: const TextStyle(fontSize: 18),),
                  SizedBox(width: screenSize * 0.52,),
                  const InkWell(
                      child: Text('Editar', style: TextStyle(color: Colors.grey, fontSize: 14),textAlign: TextAlign.end,),
                    ),
                  ],
                ),
               ),
              const Divider(color: Color(0xFFF96332),thickness: 2.0),
              Container(
                margin: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                alignment: Alignment.centerLeft,
                child: Row(
                  children: <Widget>[
                  const Text("Contraseña >", textAlign: TextAlign.left,style: TextStyle(fontSize: 18),),
                  SizedBox(width: screenSize * 0.531),
                  const InkWell(
                      child: Text('Editar', style: TextStyle(color: Colors.grey, fontSize: 14),textAlign: TextAlign.end,),
                    ),
                  ],
                ),
              ),
            ],
           ),
        ); 
      },
    );
  }
}