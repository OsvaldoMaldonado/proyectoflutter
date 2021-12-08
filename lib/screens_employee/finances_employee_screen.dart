import 'package:flutter/material.dart';
import 'package:servicios_vic/model/modelo_servicios_cuentas.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class FinancesEmployeeScreen extends StatefulWidget {
  const FinancesEmployeeScreen({Key? key}) : super(key: key);

  @override
  FinancesEmployeeState createState() => FinancesEmployeeState();
}

class FinancesEmployeeState extends State<FinancesEmployeeScreen> {
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: screenHeight * 0.01),
              Container(
                margin: const EdgeInsets.only(left: 10.0),
                child: const Text(
                  "Fechar corte: 31 de Diciembre del 2021",
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
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Color(0xFFF96332))),
                      );
                    }
                  },
                ),
              ),
              Expanded(
                child: FutureBuilder<TotalMes?>(
                  future: fetchTotalMes(http.Client(), id, 'finalizado'),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Center(
                        child: Text('Ningun Resultado!'),
                      );
                    } else if (snapshot.hasData) {
                      return Container(
                          alignment: Alignment.center,
                          child: Text(
                            "Saldo a corte: \$" +
                                snapshot.data!.total.toString() +
                                "MXN",
                            style: const TextStyle(
                                fontSize: 18.0,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ));
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

class HistorialServiciosEmpleadoFList extends StatelessWidget {
  const HistorialServiciosEmpleadoFList(
      {Key? key, required this.historialServiciosEmpleado});

  final double sumaTotal = 0.0;
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
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(
                  top: 2.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    Text(
                      "Emitido el: " +
                          historialServiciosEmpleado[index].fecha_publicacion,
                      textAlign: TextAlign.left,
                      style: const TextStyle(fontSize: 14, 
                          color: Colors.black54,),
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
                      historialServiciosEmpleado[index].nombre +
                          " " +
                          historialServiciosEmpleado[index].apellido,
                      textAlign: TextAlign.left,
                      style: const TextStyle(fontSize: 14, 
                          color: Colors.black54,),
                    ),
                    Text(
                      "Finalizado el: " +
                          historialServiciosEmpleado[index].fecha_aceptacion,
                      textAlign: TextAlign.left,
                      style: const TextStyle(fontSize: 14, 
                          color: Colors.black54,),
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                margin: const EdgeInsets.only(
                  top: 5.0,
                ),
                child: Text(
                  "\$" + historialServiciosEmpleado[index].costo + " MXN",
                  textAlign: TextAlign.right,
                  style: const TextStyle(fontSize: 16, 
                      color: Colors.black,
                      fontWeight: FontWeight.bold,)
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
