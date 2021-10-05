import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:servicios_vic/model/modelo.dart';
import 'package:servicios_vic/user_profile_screen.dart';
import 'model/colors.dart';
import 'navigation_category_screen.dart';



class NavigationHomeScreen extends StatelessWidget {
  final Future<String?> id_usuario;
  NavigationHomeScreen({Key? key, required this.id_usuario}) : super(key: key);
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {
    
    double screenSize = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
      key: _globalKey,
      drawer: Drawer(
         child: ListView(
          // Important: Remove any padding from the ListView.
          
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFF96332),
                    Color(0xFFFF6365),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Container(
                alignment: Alignment.bottomLeft,
                child: Text(""),
              ),  
            ),
            Column(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(left: 12.0,top: 6.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => UserProfileScreen(id_usuario: id_usuario)));
                    },
                    child: Row(
                      children: <Widget>[
                        const Icon(Icons.person_pin, size: 30.0),
                        SizedBox(width: screenSize*0.02,),
                        const Text('Mi cuenta',style: TextStyle(fontSize: 18.0,color: Colors.black,),),
                      ],
                    )
                  )
                ),
                Container(
                  margin: const EdgeInsets.only(left: 12.0,top: 12.0),
                  child: InkWell(
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.access_time,size: 30.0),
                        SizedBox(width: screenSize*0.02,),
                        Text('Mi Historial de servicios',style: TextStyle(fontSize: 18.0,color: Colors.black,),),
                      ],
                    )
                  )
                ),
                Container(
                  margin: const EdgeInsets.only(left: 12.0,top: 12.0),
                  child: InkWell(
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.location_on,size: 30.0),
                        SizedBox(width: screenSize*0.02,),
                        Text('Mis ubicaciones',style: TextStyle(fontSize: 18.0,color: Colors.black,),),
                      ],
                    )
                  )
                ),
                Container(
                  margin: const EdgeInsets.only(left: 12.0,top: 12.0),
                  child: InkWell(
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.credit_card, size: 30.0),
                        SizedBox(width: screenSize*0.02,),
                        Text('Mis metodos de pago',style: TextStyle(fontSize: 18.0,color: Colors.black,),),
                      ],
                    )
                  )
                ),
                Container(
                  margin: const EdgeInsets.only(left: 12.0,top: 12.0),
                  child: InkWell(
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.account_balance, size: 30.0),
                        SizedBox(width: screenSize*0.02,),
                        Text('Terminos y condiciones',style: TextStyle(fontSize: 18.0,color: Colors.black,),),
                      ],
                    )
                  )
                ),
                Container(
                  margin: const EdgeInsets.only(left: 12.0,top: 12.0),
                  child: InkWell(
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.help, size: 30.0),
                        SizedBox(width: screenSize*0.02,),
                        Text('Ayuda',style: TextStyle(fontSize: 18.0,color: Colors.black,),),
                      ],
                    )
                  )
                ),
                Container(height: screenheight*.40,),
                Container(
                  margin: const EdgeInsets.only(left: 12.0,top: 6.0),
                  child: InkWell(
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.logout, size: 30.0),
                        SizedBox(width: screenSize*0.02,),
                        Text('Cerrar Sesión',style: TextStyle(fontSize: 18.0,color: Colors.black,),),
                      ],
                    )
                  )
                ),
              ],
            ),
          ],
        ),
      ), 
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
                      _globalKey.currentState!.openDrawer();
                      
                    },
                    borderRadius: BorderRadius.circular(30.0),
                      // ignore: prefer_const_constructors
                    child: Center(
                      child: const Icon(Icons.menu, color: Color(0xfff96332)),
                    ),
                  ),
                ),
                const Text('¿Qué necesitas hoy?', 
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
            margin: const EdgeInsets.only(top:20, left: 20.0),
            child: const Text('Profesiones populares', 
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                    ),
                  ),  
            ),
          Container(
            alignment: Alignment.topLeft,  
            width: screenSize * 0.90,
            child: const TextField(
              decoration: InputDecoration(    
                
                focusColor: Colors.grey,  
                hintText: 'Buscar profesiones',
                fillColor: Color(0xffe0e0e0), filled: true,
                hintStyle: TextStyle(color: Colors.black),

              ),  
            )
          ), 
          Container(
            alignment: Alignment.topLeft,  
            width: screenSize * 0.90,
            child: FutureBuilder<List<Categorias>?>(
              future: fetchCategorias(http.Client()),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text('An error has occurred!'),
                  );
                } else if (snapshot.hasData) {
                  return CategoriasList(categorias: snapshot.data!);
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
          Container(
            alignment: Alignment.topRight,
            margin: const EdgeInsets.only(top: 10.0, right: 15.0),
            child: const Text('Mostar mas', 
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.black,
                    ),
                  ),  
            ),
       ],
      ),
    );
  }
}

Widget drawerItems(Icon icono, String itemName){
    return InkWell(
      onTap: () {
      },
      child: Row(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(left: 15.0, top: 5.0, bottom: 5.0),
            child: icono,
          ),
          Container(
            padding: const EdgeInsets.only(left:5.0, top: 5.0, bottom: 5.0),
            child: Text(itemName, style: const TextStyle(
              fontSize: 16.0,
              color: Colors.black,
              )
            ),
          ),
        ],
      ),
    );
  }

class CategoriasList extends StatelessWidget {
  const CategoriasList({Key? key, required this.categorias}) : super(key: key);

  final List<Categorias> categorias;
  @override
  Widget build(BuildContext context) {
    double screenSize = MediaQuery.of(context).size.width;
    return GridView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
      ),
      itemCount: categorias.length,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(
              left: 6.0,
              right: 6.0,
              bottom: 10.0
          ),
          height: screenSize * .28,
          width: screenSize * .28,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 3,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: InkWell(
            onTap: () {
              Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NavigationCategoryScreen(
                      profesion: categorias[index].nombre, id_profesion: int.parse(categorias[index].id,), nombre: null)),
                  );
              },
            borderRadius: BorderRadius.circular(20.0),
            // ignore: prefer_const_constructors
            child: Column(
              children: <Widget>[
                Container(
                  height: screenSize * .20,
                  width: screenSize,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(20.0)),
                    color: HexColor(categorias[index].color),
                  ),
                  child: Icon(IconData(int.parse(categorias[index].icono), fontFamily: 'MaterialIcons'), size: 40.0,),
                ),
                Container(
                  padding: const EdgeInsets.only(
                    top: 6
                  ),
                  height: screenSize * .07,
                  width: screenSize,
                  // ignore: prefer_const_constructors
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20.0)),
                    color: const Color(0xffe0e0e0)
                  ),  
                  child: Text(categorias[index].nombre, textAlign: TextAlign.center),
                ),
              ],
             ),
           ),
         );    
      },
    );
  }
}