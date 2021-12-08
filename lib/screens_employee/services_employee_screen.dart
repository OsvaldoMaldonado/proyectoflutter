import 'package:flutter/material.dart';
import 'package:servicios_vic/model/modelo_servicios_cuentas.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ServicesEmployeeScreen extends StatefulWidget {
  const ServicesEmployeeScreen({Key? key}) : super(key: key);

  @override
  ServicesEmployeeState createState() => ServicesEmployeeState();
}

class ServicesEmployeeState extends State<ServicesEmployeeScreen> {
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
        body: Container(
      color: Color(0xFFF1F0F5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: screenHeight * 0.01),
          Container(
            margin: EdgeInsets.only(left: screenSize * 0.05),
            child: const Text(
              "Servicios Finalizados: ",
              style: TextStyle(
                fontSize: 18,
              ),
              textAlign: TextAlign.start,
            ),
          ),
          SizedBox(height: screenHeight * 0.01),
          Expanded(
            child: FutureBuilder<List<HistorialServiciosEmpleadoP>?>(
              future: fetchHistorialServiciosEmpleadoP(
                  http.Client(), id, 'finalizado'),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text('Ningun Resultado!'),
                  );
                } else if (snapshot.hasData) {
                  return HistorialServiciosEmpleadoFList(
                      historialServiciosEmpleado: snapshot.data!);
                } else {
                  return const Center(
                    child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Color(0xFFF96332))),
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

class HistorialServiciosEmpleadoFList extends StatelessWidget {
  const HistorialServiciosEmpleadoFList(
      {Key? key, required this.historialServiciosEmpleado});

  final List<HistorialServiciosEmpleadoP> historialServiciosEmpleado;
  @override
  Widget build(BuildContext context) {
    double screenSize = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: historialServiciosEmpleado.length,
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
                    children: <Widget>[
                      Text(
                        historialServiciosEmpleado[index].nombre_servicio,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )),
              Container(
                margin: const EdgeInsets.only(
                  top: 2.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      historialServiciosEmpleado[index].nombre +
                          " " +
                          historialServiciosEmpleado[index].apellido,
                      textAlign: TextAlign.left,
                      style:
                          const TextStyle(fontSize: 14, color: Colors.black54),
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
                      double.parse(historialServiciosEmpleado[index].latitud),
                      double.parse(historialServiciosEmpleado[index].longitud)),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Center(
                        child: Text('An error has occurred!'),
                      );
                    } else if (snapshot.hasData) {
                      return Flexible(
                          child: Text(snapshot.data.toString(),
                              maxLines: 15,
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.black54)));
                    } else {
                      return const Center(
                        child: LinearProgressIndicator(),
                      );
                    }
                  },
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
                        historialServiciosEmpleado[index].descripcion,
                    maxLines: 15,
                    textAlign: TextAlign.left,
                    style: const TextStyle(fontSize: 14, color: Colors.black54),
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
                          historialServiciosEmpleado[index].valoracion,
                      textAlign: TextAlign.left,
                      style:
                          const TextStyle(fontSize: 14, color: Colors.black54),
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
                      "Reseña: " + historialServiciosEmpleado[index].resena,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
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
                      historialServiciosEmpleado[index].fecha_aceptacion,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                    Text(
                      "\$" + historialServiciosEmpleado[index].costo + " MXN",
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
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
