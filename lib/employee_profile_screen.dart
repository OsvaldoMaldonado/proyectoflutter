import 'package:flutter/material.dart';
import 'package:servicios_vic/navigation_home_employee_screen.dart';
import 'package:servicios_vic/navigation_home_screen.dart';
import 'model/modelo.dart';

class EmployeeProfileScreen extends StatelessWidget{
  final Future<String?> id_usuario;
  EmployeeProfileScreen({Key? key, required this.id_usuario}) : super(key: key);
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {

    double screenSize = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    Future<String?> id_Usuario;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          children: <Widget>[

            Stack(
              children: <Widget>[
          Container(
          width: screenSize,
          height: screenheight * 0.40,
          child: const DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
          ),
          ),
                RotationTransition(
                  turns: const AlwaysStoppedAnimation(180 / 360),
                  child: SizedBox(
                    width: screenSize,
                    height: screenheight * 0.30,
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

                Positioned(
                  top: 35,
                  child: Container(
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
                          MaterialPageRoute(builder: (context) => NavigationEmployeeScreen(id_usuario: id_usuario)));
                          },
                      borderRadius: BorderRadius.circular(30.0),
                      // ignore: prefer_const_constructors
                      child: Center(
                        child: const Icon(Icons.arrow_back, color: Color(0xfff96332)),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 0,
                  right: 0,
                  child: Align(
                      alignment: Alignment.center,
                    child: CircleAvatar(
                        radius: 80,
                        backgroundImage: NetworkImage('https://i.pinimg.com/originals/77/9e/1f/779e1f2ea40ccf579f3f7ef94225b287.jpg')
                    ),
                  ),
                )
      ],
        ),
            Container(
              alignment: Alignment.center,
              child: Text(
                 id_usuario.toString(),
                style: TextStyle(fontWeight: FontWeight.bold,
                    fontSize: 25),
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                "El mejor en mi chamba", //Escribe la descripcion a lo wey no c esta va pal khioya
                style: TextStyle(
                    fontSize: 20),
              ),
            ),
            Row(
              children: <Widget>[
                Container( width: screenSize * 0.26,
                  height: screenheight * 0.10,
                  alignment: Alignment.centerLeft,
                ),
                Container( width: screenSize * 0.10,
                  height: screenheight * 0.10,
                  alignment: Alignment.centerLeft,
                child: Icon(Icons.star,
                  color: Colors.amber,),
                ),

                Container( width: screenSize * 0.10,
                  height: screenheight * 0.10,
                  alignment: Alignment.centerLeft,
                  child: Icon(Icons.star,
                  color: Colors.amber,),
                ),

                Container( width: screenSize * 0.10,
                  height: screenheight * 0.10,
                  alignment: Alignment.centerLeft,
                  child: Icon(Icons.star,
                    color: Colors.amber,),
                ),

                Container( width: screenSize * 0.10,
                  height: screenheight * 0.10,
                  alignment: Alignment.centerLeft,
                  child: Icon(Icons.star_half,
                  color: Colors.amber,),
                ),

                Container( width: screenSize * 0.10,
                  height: screenheight * 0.10,
                  alignment: Alignment.centerLeft,
                  child: Icon(Icons.star_border_outlined,
                    color: Colors.amber,),
                ),
                SizedBox(width: screenSize * 0.03 ),
              ],
            ),
            Stack(
              children: <Widget>[
              Container( width: screenSize ,
                height: screenheight * 0.18,
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Colors.black,
                      width: 1.0,
                    ),
                    bottom: BorderSide(
                      color: Colors.black,
                      width: 1.0,
                    )
                  )
                ),
                 child: Row(
                    children: <Widget>[
                     Container(
                       width: screenSize*0.14,
                    height: screenheight*0.07,
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(1), // border color
                      shape: BoxShape.circle,
                    ),
               ),

                 Container(
                  width: screenSize*0.14,
                  height: screenheight*0.07,
                  decoration: BoxDecoration(
                    color: Colors.yellow.withOpacity(1), // border color
                    shape: BoxShape.circle,
                  ),
                ),
                      Container(
                        width: screenSize*0.14,
                        height: screenheight*0.07,
                        decoration: BoxDecoration(
                          color: Colors.lightGreenAccent.withOpacity(1), // border color
                          shape: BoxShape.circle,
                        ),
                      ),
                      Container(
                        width: screenSize*0.14,
                        height: screenheight*0.07,
                        decoration: BoxDecoration(
                          color: Colors.lightBlue.withOpacity(1), // border color
                          shape: BoxShape.circle,
                        ),
                      ),
                      Container(
                        width: screenSize*0.14,
                        height: screenheight*0.07,
                        decoration: BoxDecoration(
                          color: Colors.deepPurpleAccent.withOpacity(1), // border color
                          shape: BoxShape.circle,
                        ),
                      ),
                      Container(
                        width: screenSize*0.14,
                        height: screenheight*0.07,
                        decoration: BoxDecoration(
                          color: Colors.blueAccent.withOpacity(1), // border color
                          shape: BoxShape.circle,
                        ),
                      ),
                      Container(
                        width: screenSize*0.14,
                        height: screenheight*0.07,
                        decoration: BoxDecoration(
                          color: Colors.lightBlueAccent.withOpacity(1), // border color
                          shape: BoxShape.circle,
                        ),
                      ),
                ],
              ),
            ),
                  Positioned(
                    bottom: 3,
                    left: 10,
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Carpintero", //Escribe la descripcion a lo wey no c esta va pal khioya
                        style: TextStyle(
                            fontSize: 20),
                      ),
                    ),
                  ),
                Positioned(
                  bottom: 3,
                  left: 165,
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Electricista", //Escribe la descripcion a lo wey no c esta va pal khioya
                      style: TextStyle(
                          fontSize: 20),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 3,
                  right: 10,
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Plomero", //Escribe la descripcion a lo wey no c esta va pal khioya
                      style: TextStyle(
                          fontSize: 20),
                    ),
                  ),
                ),
      ],
            ),
            Container(
              alignment: Alignment.centerLeft,
              child:const Text(
                '  Reseñas de clientes',
                style: TextStyle(fontWeight: FontWeight.bold,
                    fontSize: 21),
              ),
            ),
            SingleChildScrollView(
              child : Container(
                width: screenSize,
                height: screenheight*0.10,
              ),

            ),

      ],
    ),


      // floatingActionButton: FloatingActionButton(
      // onPressed: _incrementCounter,
      // tooltip: 'Increment',
      // child: const Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    ),
    );
  }
}