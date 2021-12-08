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
    if (idEmployee == '') {
      getId();
    }

    double screenSize = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Center(
        child: Container(
          alignment: Alignment.topCenter,
          width: screenSize,
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
                  child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFF96332))),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

class Perfil extends StatefulWidget {
  const Perfil({Key? key, required this.perfil, required this.idEmployee})
      : super(key: key);

  final Employee perfil;
  final String idEmployee;

  @override
  // ignore: no_logic_in_create_state
  State<Perfil> createState() => _PerfilState(idEmployee: idEmployee);
}

class _PerfilState extends State<Perfil> {
  _PerfilState({Key? key, required this.idEmployee});

  final String idEmployee;
  String getvalue = "";
  TextEditingController entrada_nombre = TextEditingController();
  TextEditingController entrada_apellido = TextEditingController();
  TextEditingController entrada_correo = TextEditingController();
  TextEditingController entrada_telefono = TextEditingController();

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenSize = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          children: <Widget>[
            Container(
              height: screenHeight * 0.2,
              decoration: BoxDecoration(
                borderRadius:
                BorderRadius.vertical(bottom: Radius.elliptical(250, 100)),
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
                width: double.infinity,
                height: 220,
                child: Container(
                  alignment: Alignment(0.0, 3.5),
                  child: CircleAvatar(
                    backgroundImage:
                        NetworkImage("Add you profile DP image URL here "),
                    radius: 65.0,
                  ),
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.06),
            Container(
              margin: const EdgeInsets.only(top: 4.0, bottom: 4.0),
              alignment: Alignment.center,
              child: Text(
                widget.perfil.nombre + " " + widget.perfil.apellido,
                style: TextStyle(fontSize: 25),
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              const Icon(
                Icons.phone,
                size: 16,
              ),
              Text(
                widget.perfil.telefono,
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 14, color: Colors.black54),
              )
            ]),
            SizedBox(height: screenHeight * 0.01),
            Container(
              alignment: Alignment.center,
              child: FutureBuilder<String>(
                future: getLocacion(double.parse(widget.perfil.latitud),
                    double.parse(widget.perfil.longitud)),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text('An error has occurred!'),
                    );
                  } else if (snapshot.hasData) {
                    return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Icon(
                            Icons.place,
                            size: 16,
                          ),
                          Text(snapshot.data.toString(),
                              style: const TextStyle(fontSize: 16))
                        ]);
                  } else {
                    return const Center(
                    );
                  }
                },
              ),
            ),
            Row(
              children: <Widget>[
                Container(
                  width: screenSize * 0.26,
                  height: screenHeight * 0.10,
                  alignment: Alignment.centerLeft,
                ),
                Container(
                  width: screenSize * 0.10,
                  height: screenHeight * 0.10,
                  alignment: Alignment.centerLeft,
                  child: Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                ),
                Container(
                  width: screenSize * 0.10,
                  height: screenHeight * 0.10,
                  alignment: Alignment.centerLeft,
                  child: Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                ),
                Container(
                  width: screenSize * 0.10,
                  height: screenHeight * 0.10,
                  alignment: Alignment.centerLeft,
                  child: Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                ),
                Container(
                  width: screenSize * 0.10,
                  height: screenHeight * 0.10,
                  alignment: Alignment.centerLeft,
                  child: Icon(
                    Icons.star_half,
                    color: Colors.amber,
                  ),
                ),
                Container(
                  width: screenSize * 0.10,
                  height: screenHeight * 0.10,
                  alignment: Alignment.centerLeft,
                  child: Icon(
                    Icons.star_border_outlined,
                    color: Colors.amber,
                  ),
                ),
                SizedBox(width: screenSize * 0.03),
              ],
            ),
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
                      child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFF96332))),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
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
                bottom: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(children: <Widget>[
                      Text(
                          resenasEmpleado[index].nombre +
                              " " +
                              resenasEmpleado[index].apellido,
                          style: const TextStyle(fontSize: 15)),
                      SizedBox(
                        width: 5,
                      ),
                      calificacion(resenasEmpleado[index].valoracion),
                    ]),
                    Text(resenasEmpleado[index].fecha_aceptacion,
                        style: const TextStyle(fontSize: 12, color: Colors.black54)),
                  ],
                ),
                Text(
                  resenasEmpleado[index].resena,
                  style: const TextStyle(fontSize: 14, color: Colors.black54),
                  textAlign: TextAlign.start,
                ),
                const Divider(color: Color(0xFFF96332), thickness: 0.5),
              ],
            ));
      },
    );
  }

  Widget calificacion(String cantidad) {
    double cantidadNumerica = 6;
    try {
      cantidadNumerica = double.parse(cantidad);
    } catch (e) {
      return const Text(" ");
    }
    if (cantidadNumerica < 1.1) {
      return Row(children: const <Widget>[
        Icon(
          Icons.star,
          color: Colors.yellow,
          size: 14,
        ),
        Icon(
          Icons.star_outline,
          color: Colors.yellow,
          size: 14,
        ),
        Icon(
          Icons.star_outline,
          color: Colors.yellow,
          size: 14,
        ),
        Icon(
          Icons.star_outline,
          color: Colors.yellow,
          size: 14,
        ),
        Icon(
          Icons.star_outline,
          color: Colors.yellow,
          size: 14,
        ),
      ]);
    } else if (cantidadNumerica < 2.1) {
      return Row(children: const <Widget>[
        Icon(
          Icons.star,
          color: Colors.yellow,
          size: 14,
        ),
        Icon(
          Icons.star,
          color: Colors.yellow,
          size: 14,
        ),
        Icon(
          Icons.star_outline,
          color: Colors.yellow,
          size: 14,
        ),
        Icon(
          Icons.star_outline,
          color: Colors.yellow,
          size: 14,
        ),
        Icon(
          Icons.star_outline,
          color: Colors.yellow,
          size: 14,
        ),
      ]);
    } else if (cantidadNumerica < 3.1) {
      return Row(children: const <Widget>[
        Icon(
          Icons.star,
          color: Colors.yellow,
          size: 14,
        ),
        Icon(
          Icons.star,
          color: Colors.yellow,
          size: 14,
        ),
        Icon(
          Icons.star,
          color: Colors.yellow,
          size: 14,
        ),
        Icon(
          Icons.star_outline,
          color: Colors.yellow,
          size: 14,
        ),
        Icon(
          Icons.star_outline,
          color: Colors.yellow,
          size: 14,
        ),
      ]);
    } else if (cantidadNumerica < 4.1) {
      return Row(children: const <Widget>[
        Icon(
          Icons.star,
          color: Colors.yellow,
          size: 14,
        ),
        Icon(
          Icons.star,
          color: Colors.yellow,
          size: 14,
        ),
        Icon(
          Icons.star,
          color: Colors.yellow,
          size: 14,
        ),
        Icon(
          Icons.star,
          color: Colors.yellow,
          size: 14,
        ),
        Icon(
          Icons.star_outline,
          color: Colors.yellow,
          size: 14,
        ),
      ]);
    } else {
      return Row(children: const <Widget>[
        Icon(
          Icons.star,
          color: Colors.yellow,
          size: 14,
        ),
        Icon(
          Icons.star,
          color: Colors.yellow,
          size: 14,
        ),
        Icon(
          Icons.star,
          color: Colors.yellow,
          size: 14,
        ),
        Icon(
          Icons.star,
          color: Colors.yellow,
          size: 14,
        ),
        Icon(
          Icons.star,
          color: Colors.yellow,
          size: 14,
        ),
      ]);
    }
  }
}
