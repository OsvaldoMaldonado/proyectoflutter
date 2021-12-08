import 'package:flutter/material.dart';
import 'package:servicios_vic/model/modelo_servicios_cuentas.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ServicesUserScreen extends StatefulWidget {
  const ServicesUserScreen({Key? key}) : super(key: key);

  @override
  ServicesUserState createState() => ServicesUserState();
}

class ServicesUserState extends State<ServicesUserScreen> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  String locacion = "";
  String id = '2';
  double latitud = 0.0, longitud = 0.0;

  void _getiD() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String idUser = prefs.getString('id') ?? '';

    setState(() => id = idUser);
  }

  @override
  void initState() {
    _getiD();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenSize = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        key: _globalKey,
        body: Container(
          color: Color(0xFFF1F0F5),
          child: Column(
            children: <Widget>[
              SizedBox(height: screenHeight * 0.01),
              Expanded(
                child: FutureBuilder<List<HistorialServicios>?>(
                  future: fetchHistorialServiciosUsuario(http.Client(), id),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Center(
                        child: Text('Ningun Resultado!'),
                      );
                    } else if (snapshot.hasData) {
                      return HistorialServiciosUsuarioList(
                          historialServiciosUsuario: snapshot.data!);
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Color(0xFFF96332))),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ));
  }
}

class HistorialServiciosUsuarioList extends StatelessWidget {
  const HistorialServiciosUsuarioList(
      {Key? key, required this.historialServiciosUsuario});

  final List<HistorialServicios> historialServiciosUsuario;
  @override
  Widget build(BuildContext context) {
    double screenSize = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: historialServiciosUsuario.length,
      itemBuilder: (context, index) {
        return Container(
          padding: EdgeInsets.only(top: 12, bottom: 12, right: 18, left: 18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 3,
                blurRadius: 2,
                offset: Offset(0, 1), // changes position of shadow
              ),
            ],
          ),
          margin: EdgeInsets.only(
              left: screenSize * 0.02,
              right: screenSize * 0.02,
              bottom: 10.0,
              top: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(
                  top: 2.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      historialServiciosUsuario[index].nombre_servicio,
                      textAlign: TextAlign.left,style: const TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                    ),
                    Text(
                      "Emitido el: " +
                          historialServiciosUsuario[index].fecha_publicacion,
                      textAlign: TextAlign.left,
                      style:const TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  top: 2.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      historialServiciosUsuario[index].nombre +
                          " " +
                          historialServiciosUsuario[index].apellido,
                      textAlign: TextAlign.left,
                      style:const TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                    Text(
                      "Aceptado el: " +
                          historialServiciosUsuario[index].fecha_aceptacion,
                      textAlign: TextAlign.left,
                      style:const TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                margin: const EdgeInsets.only(
                  top: 2.0,
                ),
                child: FutureBuilder<String>(
                  future: getLocacion(
                      double.parse(historialServiciosUsuario[index].latitud),
                      double.parse(historialServiciosUsuario[index].longitud)),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Center(
                        child: Text('An error has occurred!'),
                      );
                    } else if (snapshot.hasData) {
                      return Flexible(
                          child: Text(snapshot.data.toString(),
                              maxLines: 15,
                      style:const TextStyle(fontSize: 14, color: Colors.black54)));
                    } else {
                      return const Center(
                        child: LinearProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  top: 2.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "\$" + historialServiciosUsuario[index].costo + " MXN",
                      textAlign: TextAlign.left,
                      style:const TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                margin: const EdgeInsets.only(
                  top: 2.0,
                ),
                child: Flexible(
                  child: Text(
                    "Descripción: " +
                        historialServiciosUsuario[index].descripcion,
                    maxLines: 15,
                    textAlign: TextAlign.left,
                      style:const TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  top: 2.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Calificación: " +
                          historialServiciosUsuario[index].valoracion,
                      textAlign: TextAlign.left,
                      style:const TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  top: 2.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Reseña: " + historialServiciosUsuario[index].resena,
                      textAlign: TextAlign.left,
                      style:const TextStyle(fontSize: 14, color: Colors.black54),
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
