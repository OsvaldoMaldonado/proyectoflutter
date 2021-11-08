// ignore_for_file: use_key_in_widget_constructors

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
                  return Perfil(perfil: snapshot.data!, idEmployee: idEmployee);
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
  const Perfil({Key? key, required this.perfil, required this.idEmployee}) : super(key: key);

  final Employee perfil;
  final String idEmployee;
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
          child: Row(
            mainAxisAlignment:  MainAxisAlignment.center,
            children: const <Widget>[
              Icon(Icons.star, color: Colors.yellow, size: 25,),
              Icon(Icons.star, color: Colors.yellow, size: 25,),
              Icon(Icons.star, color: Colors.yellow, size: 25,),
              Icon(Icons.star, color: Colors.yellow, size: 25,),
              Icon(Icons.star_outline, color: Colors.yellow, size: 25,),
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
        Expanded(
            child: FutureBuilder<List<Resenas>?>(   
              future: fetchEmployeeReviews(http.Client(), idEmployee),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text('An error has occurred!'),
                  );
                } else if (snapshot.hasData) {
                  return EmpleadoReviewsList(resenasEmpleado: snapshot.data!);
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
      ],
    );
  }     
}


class EmpleadoReviewsList extends StatelessWidget {
  const EmpleadoReviewsList({Key? key, required this.resenasEmpleado});


  final List<Resenas> resenasEmpleado;
  @override
  Widget build(BuildContext context) {
    double screenSize = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: resenasEmpleado.length,
      itemBuilder: (context, index) {
        return Container(
          alignment: Alignment.topLeft,
          margin: EdgeInsets.only(
              left: screenSize * 0.05,
              right: screenSize * 0.05,
              bottom: 10.0
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(resenasEmpleado[index].nombre + " " + resenasEmpleado[index].apellido, style: const TextStyle(fontSize: 14)),
                  Text (resenasEmpleado[index].fecha_aceptacion, style: const TextStyle(fontSize: 14)),
                ],
              ),
              calificacion(resenasEmpleado[index].valoracion),
              Text(resenasEmpleado[index].resena, style: const TextStyle(fontSize: 12), textAlign: TextAlign.start,),
              const Divider(color: Color(0xFFF96332),thickness: 0.5),           
            ],
          )
        );    
      },
    );
  }

  Widget calificacion (String cantidad){
    double cantidadNumerica = 6; 
    try{
      cantidadNumerica = double.parse(cantidad);
    }catch(e){
      return const Text(" ");
    }
    if(cantidadNumerica < 1.1){
      return Row(
        children: const <Widget>[
          Icon(Icons.star, color: Colors.yellow, size: 12,),
          Icon(Icons.star_outline, color: Colors.yellow, size: 12,),
          Icon(Icons.star_outline, color: Colors.yellow, size: 12,),
          Icon(Icons.star_outline, color: Colors.yellow, size: 12,),
          Icon(Icons.star_outline, color: Colors.yellow, size: 12,),
        ]
      );
    }
    else if(cantidadNumerica < 2.1){
      return Row(
        children: const <Widget>[
          Icon(Icons.star, color: Colors.yellow, size: 12,),
          Icon(Icons.star, color: Colors.yellow, size: 12,),
          Icon(Icons.star_outline, color: Colors.yellow, size: 12,),
          Icon(Icons.star_outline, color: Colors.yellow, size: 12,),
        Icon(Icons.star_outline, color: Colors.yellow, size: 12,),
        ]
      );
    }
    else if(cantidadNumerica < 3.1){
      return Row(
        children: const <Widget>[
          Icon(Icons.star, color: Colors.yellow, size: 12,),
          Icon(Icons.star, color: Colors.yellow, size: 12,),
          Icon(Icons.star, color: Colors.yellow, size: 12,),
          Icon(Icons.star_outline, color: Colors.yellow, size: 12,),
          Icon(Icons.star_outline, color: Colors.yellow, size: 12,),
        ]
      );
    }
    else if(cantidadNumerica < 4.1){
      return Row(
        children: const <Widget>[
          Icon(Icons.star, color: Colors.yellow, size: 12,),
          Icon(Icons.star, color: Colors.yellow, size: 12,),
          Icon(Icons.star, color: Colors.yellow, size: 12,),
          Icon(Icons.star, color: Colors.yellow, size: 12,),
          Icon(Icons.star_outline, color: Colors.yellow, size: 12,),
        ]
      );
    }
    else {
      return Row(
        children: const <Widget>[
          Icon(Icons.star, color: Colors.yellow, size: 12,),
          Icon(Icons.star, color: Colors.yellow, size: 12,),
          Icon(Icons.star, color: Colors.yellow, size: 12,),
          Icon(Icons.star, color: Colors.yellow, size: 12,),
          Icon(Icons.star, color: Colors.yellow, size: 12,),
        ]
      );
    }
  }
}