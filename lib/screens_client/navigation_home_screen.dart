// ignore_for_file: non_constant_identifier_names

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:servicios_vic/home_screen.dart';
import 'package:servicios_vic/model/colors.dart';
import 'package:servicios_vic/model/modelo_navegacion_usuario.dart';
import 'package:servicios_vic/screens_client/services_user_screen.dart';
import 'package:servicios_vic/screens_client/user_profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'navigation_category_screen.dart';

class NavigationHomeScreen extends StatefulWidget {
  const NavigationHomeScreen({Key? key}) : super(key: key);

  @override
  NavigationHomeState createState() => NavigationHomeState();
}

class NavigationHomeState extends State<NavigationHomeScreen> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  int _selectedIndex = 0;
  String _title = '¿Que necesitas hoy?';
  String _color = 'F1F0F5';

  var appBarTitleText = Text("¿Que necesitas hoy?");
  static const List<Widget> _widgetOptions = <Widget>[
    NavigationHomeScreenTab(),
    UserProfileScreen(),
    ServicesUserScreen(),
  ];
  
  @override
  Widget build(BuildContext context) {
    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
        switch (index) {
          case 0:
            {
              _title = '¿Que necesitas hoy?';
              _color = 'F1F0F5';
            }
            break;
          case 1:
            {
              _title = 'Mi perfil';
              _color = 'F1F0F5';
            }
            break;
          case 2:
            {
              _title = 'Historial de servicios';
              _color = 'F1F0F5';
            }
            break;
        }
      });
    }

    @override
    initState() {
      _title = 'Bienvenido a Servicios Vic';
      _color = 'F1F0F5';
    }

    return Scaffold(
        key: _globalKey,
        appBar: AppBar(
          backgroundColor: HexColor(_color),
          elevation: 0,
          shadowColor: Colors.transparent,
          foregroundColor: Colors.black38,
          title: Text(
            _title,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.black,
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.help),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () 
                async {
                       SharedPreferences prefs = await SharedPreferences.getInstance();
                        prefs.remove('id');
                        prefs.remove('type');
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (BuildContext ctx) => const HomeScreen()));
                    
              },
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Color(0xFFF96332),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home, size: 25.0, color: Color(0xFFF96332)),
              label: 'Inicio',
            ),
            BottomNavigationBarItem(
              icon:
                  Icon(Icons.person_pin, size: 25.0, color: Color(0xFFF96332)),
              label: 'Mi cuenta',
            ),
            BottomNavigationBarItem(
              icon:
                  Icon(Icons.access_time, size: 25.0, color: Color(0xFFF96332)),
              label: 'Historial',
            ),
           
          ],
          currentIndex: _selectedIndex, //New
          onTap: _onItemTapped,
        ),
        body: Container(
          child: _widgetOptions.elementAt(_selectedIndex),
        ));
  }
}

class NavigationHomeScreenTab extends StatefulWidget{
   const NavigationHomeScreenTab ({Key? key}) : super(key: key);

  @override
  NavigationHomeTabState createState() => NavigationHomeTabState();
}


class NavigationHomeTabState extends State<NavigationHomeScreenTab> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  String busqueda = "";
  final controllerBusqueda = TextEditingController();


  Future<void> setBuscador(String textoBuscador) async {
    //print(textoBuscador);
    setState(() => busqueda = textoBuscador);
  }


  @override
  Widget build(BuildContext context) {
    
    double screenSize = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      key: _globalKey,
      /*drawer: Drawer(
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
                child: const Text(""),
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
                        MaterialPageRoute(builder: (context) => const UserProfileScreen()));
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
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ServicesUserScreen()));
                    },
                    child: Row(
                      children: <Widget>[
                        const Icon(Icons.access_time,size: 30.0),
                        SizedBox(width: screenSize*0.02,),
                        const Text('Mi Historial de servicios',style: TextStyle(fontSize: 18.0,color: Colors.black,),),
                      ],
                    )
                  )
                ),
                Container(
                  margin: const EdgeInsets.only(left: 12.0,top: 12.0),
                  child: InkWell(
                    child: Row(
                      children: <Widget>[
                        const Icon(Icons.location_on,size: 30.0),
                        SizedBox(width: screenSize*0.02,),
                        const Text('Mis ubicaciones',style: TextStyle(fontSize: 18.0,color: Colors.black,),),
                      ],
                    )
                  )
                ),
                Container(
                  margin: const EdgeInsets.only(left: 12.0,top: 12.0),
                  child: InkWell(
                    child: Row(
                      children: <Widget>[
                        const Icon(Icons.credit_card, size: 30.0),
                        SizedBox(width: screenSize*0.02,),
                        const Text('Mis metodos de pago',style: TextStyle(fontSize: 18.0,color: Colors.black,),),
                      ],
                    )
                  )
                ),
                Container(
                  margin: const EdgeInsets.only(left: 12.0,top: 12.0),
                  child: InkWell(
                    child: Row(
                      children: <Widget>[
                        const Icon(Icons.account_balance, size: 30.0),
                        SizedBox(width: screenSize*0.02,),
                        const Text('Terminos y condiciones',style: TextStyle(fontSize: 18.0,color: Colors.black,),),
                      ],
                    )
                  )
                ),
                Container(
                  margin: const EdgeInsets.only(left: 12.0,top: 12.0),
                  child: InkWell(
                    child: Row(
                      children: <Widget>[
                        const Icon(Icons.help, size: 30.0),
                        SizedBox(width: screenSize*0.02,),
                        const Text('Ayuda',style: TextStyle(fontSize: 18.0,color: Colors.black,),),
                      ],
                    )
                  )
                ),
                Container(height: screenHeight*.40,),
                Container(
                  margin: const EdgeInsets.only(left: 12.0,top: 6.0),
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
              ],
            ),
          ],
        ),
      ), */
      body: Container(
      color: Color(0xFFF1F0F5),
      child: Column(
        children: <Widget>[
          SizedBox(height: screenHeight * 0.01),
          Container(
            alignment: Alignment.topLeft,  
            width: screenSize * 0.92,
            height: screenHeight * 0.07,
            child: TextFormField(
              onFieldSubmitted: (textoBuscador){
                setBuscador(textoBuscador);
              },
              decoration: const InputDecoration(
                hintText: 'Buscar profesiones...',
                labelText: 'Buscar profesiones...',
                border: OutlineInputBorder(),
                suffixIcon: Icon(
                  Icons.search,
                ),
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.01),
          Container(
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.only(top:10, left: 20.0),
            child: const Text('Profesiones populares', 
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                    ),
                  ),  
          ), 
          SizedBox(height: screenHeight * 0.01),
          Container(
            alignment: Alignment.topLeft,  
            width: screenSize * 0.90,
            child: FutureBuilder<List<Categorias>?>(
              future: fetchCategorias(http.Client(), busqueda),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text('Ningun Resultado!'),
                  );
                } else if (snapshot.hasData) {
                  return CategoriasList(categorias: snapshot.data!);
                } else {
                  return const Center(
                    child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFF96332))),
                  );
                }
              },
            ),
          ),
          SizedBox(height: screenHeight * 0.01),
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
      )
    );
  }
}

class CategoriasList extends StatelessWidget {
  const CategoriasList({Key? key,required this.categorias}) : super(key: key);

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
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 3,
                blurRadius: 2,
                offset: Offset(0, 1), // changes position of shadow
              ),
            ],
          ),
          child: InkWell(
            onTap: () {
              Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NavigationCategoryScreen(
                      profesion: categorias[index].nombre, id_profesion: int.parse(categorias[index].id,))),
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
                  child: Icon(IconData(int.parse(categorias[index].icono)), size: 40.0,),
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
                    color: Colors.white
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