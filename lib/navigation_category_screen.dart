import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:servicios_vic/navigation_home_screen.dart';
import 'package:servicios_vic/navitagion_job_screen.dart';


class NavigationCategoryScreen extends StatelessWidget{
  final String? profesion;
  const NavigationCategoryScreen({Key? key, required this.profesion}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenSize = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: <Widget>[
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
                        MaterialPageRoute(builder: (context) => NavigationHomeScreen()),
                      );
                    },
                    borderRadius: BorderRadius.circular(30.0),
                      // ignore: prefer_const_constructors
                    child: Center(
                      child: const Icon(Icons.arrow_back, color: Color(0xfff96332)),
                    ),
                  ),
                ),
                const Text('¿Qué categoría estas buscando?', 
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.black,
                    ),
                  )
              ],
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.only(top:20,),  
            width: screenSize * 0.90,
            child: const TextField(
              decoration: InputDecoration(    
                
                focusColor: Colors.grey,  
                hintText: 'Buscar categorias',
                fillColor: Color(0xffe0e0e0), filled: true,
                hintStyle: TextStyle(color: Colors.black),

              ),  
            )
          ),
          Container(
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.only(top: 10.0, left: 20.0),
            child: Text('Profesion > $profesion', 
              style: const TextStyle(
                fontSize: 12.0,
                color: Colors.black,
              ),
            ),
          ),
          Container(
            alignment: Alignment.topCenter,
            margin: const EdgeInsets.only(top:20.0,left: 12.0, right: 12.0),
            child: Column(
              // ignore: prefer_const_literals_to_create_immutables
              children: <Widget>[    
                categories('Cambios', 'Cambios necesarios', context),
                categories('Instalación', 'Instalaciones en casa', context),
                categories('Colocación y conexión', 'Colocación y conexión', context),
              ],
            ),
          ),
         
        ],
      ),
    );
  }

   Widget categories (String categoria, String descripcion,  BuildContext context){
   double screenSize = MediaQuery.of(context).size.width;
    return Container(
      alignment: Alignment.topLeft,
        margin: const EdgeInsets.only(
          left: 6.0,
          right: 6.0,
          bottom: 15.0
        ),
        height: screenSize * .22,
        width: screenSize * .90,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
      child: InkWell( 
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NavigationJobScreen(profesion: profesion, category: categoria,)),
          );
        },
        borderRadius: BorderRadius.circular(20.0),
        // ignore: prefer_const_constructors
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(
                top: 5.0,
                left: 10.0,
              ),
              child: Text( categoria, 
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  color: Colors.black,
                ), 
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                left: 10.0,
              ),
              child: Text( descripcion, 
                style: const TextStyle(
                  fontSize: 14.0,
                  color: Colors.black,
                ), 
              ),
            ),
            Container(
              width: screenSize * .20,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: const Color(0xfff96332),
              ),
              margin: const EdgeInsets.only(
                left: 265.0,
                top: 10.0
              ),
              padding: const EdgeInsets.all(4),
              child: const Text( 'Categoria', 
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.black,
                ), 
              ),
            ),
          ]
         ),
       ),
       
     );    
  }
}
