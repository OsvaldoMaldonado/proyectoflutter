import 'package:flutter/material.dart';
import 'package:servicios_vic/navigation_category_screen.dart';


class NavigationHomeScreen extends StatelessWidget{
  NavigationHomeScreen({Key? key}) : super(key: key);
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    double screenSize = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _globalKey,
      drawer: Drawer(
         child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xfff96332),
              ),
              child: Text('Drawer Header', textAlign: TextAlign.end,),
            ),
            Column(
              children: <Widget>[
                drawerItems(const Icon(Icons.person_pin, size: 40.0,), 'Mi cuenta'),
                drawerItems(const Icon(Icons.access_time, size: 40.0,), 'Mis Historial de servicios'),
                drawerItems(const Icon(Icons.location_on,size: 40.0,), 'Mis ubicaciones'),
                drawerItems(const Icon(Icons.credit_card, size: 40.0,), 'Mis metodos de pago'),
                drawerItems(const Icon(Icons.account_balance, size: 40.0,), 'Terminos y condiciones'),
                drawerItems(const Icon(Icons.help, size: 40.0,), 'Ayuda'),
                Container(height: screenSize*.70,),
                drawerItems(const Icon(Icons.logout, size: 40.0,), 'Cerrar Sesión'),
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
            alignment: Alignment.topCenter,
            margin: const EdgeInsets.only(top:20.0,left: 12.0, right: 12.0),
            child: Row(
              // ignore: prefer_const_literals_to_create_immutables
              children: <Widget>[
                professions(const Color(0xff009ece), 'Electricista', 
                const Icon(Icons.electrical_services,size: 40.0,), context),
                professions(const Color(0xffff9e00),'Cerrajero', 
                const Icon(Icons.vpn_key,size: 40.0,), context),
                professions(const Color(0xfff7d708), 'Contador',
                const Icon(Icons.calculate,size: 40.0,), context),
              ],
            ),
          ),
          Container(
            alignment: Alignment.topCenter,
            margin: const EdgeInsets.only(top:20.0,left: 12.0, right: 12.0),
            child: Row(
              // ignore: prefer_const_literals_to_create_immutables
              children: <Widget>[
                professions(const Color(0xffce0000), 'Abogado', 
                const Icon(Icons.business_center,size: 40.0,), context),
                professions(const Color(0xff9ccf31), 'Mecanico', 
                const Icon(Icons.car_repair_rounded,size: 40.0,), context),
                professions(const Color(0xfff0ddaa), 'Carpintero',
                const Icon(Icons.carpenter,size: 40.0,), context),
              ],
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

 

  Widget professions (Color color, String profesion, Icon icono,  BuildContext context){
   double screenSize = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.only(
          left: 6.0,
          right: 6.0
      ),
      height: screenSize * .28,
      width: screenSize * .28,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: color,
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
                MaterialPageRoute(builder: (context) => NavigationCategoryScreen(profesion: profesion)),
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
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: icono
            ),
            Container(
              padding: const EdgeInsets.only(
                top: 6
              ),
              height: screenSize * .08,
              width: screenSize,
              // ignore: prefer_const_constructors
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20.0)),
                color: const Color(0xffe0e0e0)
              ),
              child: Text(profesion, textAlign: TextAlign.center),
            ),
          ],
         ),
       ),
     );    
  }
  
}