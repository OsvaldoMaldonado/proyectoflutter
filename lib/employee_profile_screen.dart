import 'package:flutter/material.dart';
import 'package:servicios_vic/model/modelo_perfil_cuentas.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class EmployeeProfileScreen extends StatefulWidget {
  const EmployeeProfileScreen({Key? key}) : super(key: key);

  @override
  EmployeeProfileState createState() => EmployeeProfileState();
}


class EmployeeProfileState extends State<EmployeeProfileScreen> {

    String idEmployee = '';

    Future<void> getId() async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String id = prefs.getString('id') ?? '';

      setState(() => idEmployee = id);
    }
  
  @override
  Widget build(BuildContext context) {
    if (idEmployee == ''){
      getId();
    }

    double screenSize = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
  
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        shadowColor: Colors.transparent,
        foregroundColor: const Color(0xFFF96332),
        title: const Text('Mi perfil', style: TextStyle(fontSize: 20.0,color: Colors.black,),)
      ),
      body: Center(
          child: Container(
            alignment: Alignment.topCenter,  
            width: screenSize * 0.90,
            child: FutureBuilder<Employee?>(   
              future: fetchEmployee(http.Client(), idEmployee),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text('An error has occurred!'),
                  );
                } else if (snapshot.hasData) {
                  //return Text(snapshot.data!.correo);
                  return Perfil(perfil: snapshot.data!);
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
      ),
    );
  }
}

class Perfil extends StatelessWidget {
  const Perfil({Key? key, required this.perfil}) : super(key: key);

  final Employee perfil;
  @override
  Widget build(BuildContext context) {
    double screenSize = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    return Column(
      children: <Widget>[
        SizedBox(height: screenheight * 0.05),
        const Positioned(top: 0,left: 0,right: 0,
          child: Align(
            alignment: Alignment.topCenter,
            child: CircleAvatar(
              radius: 80,
              backgroundImage: NetworkImage('imagen')
            ),
          ),
        ),
        SizedBox(height: screenheight * 0.01),
        Container(
          alignment: Alignment.center,
          child:  Text(perfil.nombre + " " + perfil.apellido, style: const TextStyle(fontSize: 25),)
        ),
        SizedBox(height: screenheight * 0.01),
        Container(
          alignment: Alignment.center, 
          child: Row(
            mainAxisAlignment:  MainAxisAlignment.center,
            children: <Widget>[
              const Icon(Icons.phone, size: 18,),
              Text(perfil.telefono, style: const TextStyle(fontSize: 18),),  
            ]
          )
        ),
        SizedBox(height: screenheight * 0.01),
        Container(
          alignment: Alignment.center,
          child: FutureBuilder<String>(   
            future: getLocacion(double.parse(perfil.latitud), double.parse(perfil.longitud)),
            builder: (context, snapshot){
              if (snapshot.hasError) {
                return const Center(
                  child: Text('An error has occurred!'),
                );
              } else if (snapshot.hasData) {
                return 
                Row(
                    mainAxisAlignment:  MainAxisAlignment.center,
                    children: <Widget>[
                      const Icon(Icons.place, size: 18,),
                      Text(snapshot.data.toString(), style: const TextStyle(fontSize: 18))
                    ]
                  );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
        SizedBox(height: screenheight * 0.01),
        const Divider(color: Colors.black,thickness: 1.0),
        SizedBox(height: screenheight * 0.1),
        const Divider(color: Colors.black,thickness: 1.0),
      ],
    );
  }     
}