import 'package:flutter/material.dart';
import 'package:servicios_vic/model/modelo_servicios_cuentas.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ServicesEmployeeScreen extends StatefulWidget{
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
    double screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        shadowColor: Colors.transparent,
        foregroundColor: const Color(0xFFF96332),
        title: const Text('Historial de servicios', style: TextStyle(fontSize: 20.0,color: Colors.black,),)
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[   
          SizedBox(height: screenheight * 0.01),
          Container(
            margin: const EdgeInsets.only(left: 10.0),
            child: const Text("Servicios Pendientes de aprobación: ", style: TextStyle(fontSize: 18,),),
          ),   
          SizedBox(height: screenheight * 0.01),
          Expanded(
            child: FutureBuilder<List<HistorialServiciosEmpleadoP>?>(
              future: fetchHistorialServiciosEmpleadoP(http.Client(), id, 'pendiente'),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text('Ningun Resultado!'),
                  );
                } else if (snapshot.hasData) {
                  return HistorialServiciosEmpleadoPList(historialServiciosEmpleado: snapshot.data!);
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
          const Divider(color: Colors.black,thickness: 1),     
          SizedBox(height: screenheight * 0.01),
          Container(
            margin: const EdgeInsets.only(left: 10.0),
            child: const Text("Servicios Activos: ", style: TextStyle(fontSize: 18,)),
          ),   
          SizedBox(height: screenheight * 0.01),
          Expanded(
            child: FutureBuilder<List<HistorialServiciosEmpleadoP>?>(
              future: fetchHistorialServiciosEmpleadoP(http.Client(), id, 'activo'),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text('Ningun Resultado!'),
                  );
                } else if (snapshot.hasData) {
                  return HistorialServiciosEmpleadoAList(historialServiciosEmpleado: snapshot.data!);
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
          const Divider(color: Colors.black,thickness: 1),     
          SizedBox(height: screenheight * 0.01),
          Container(
            margin: const EdgeInsets.only(left: 10.0),
            child: const  Text("Servicios Finalizados: ", style: TextStyle(fontSize: 18,), textAlign: TextAlign.start,),
          ),  
          SizedBox(height: screenheight * 0.01),
          Expanded(
            child: FutureBuilder<List<HistorialServiciosEmpleadoP>?>(
              future: fetchHistorialServiciosEmpleadoP(http.Client(), id, 'finalizado'),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text('Ningun Resultado!'),
                  );
                } else if (snapshot.hasData) {
                  return HistorialServiciosEmpleadoFList(historialServiciosEmpleado: snapshot.data!);
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class HistorialServiciosEmpleadoPList extends StatelessWidget {
  const HistorialServiciosEmpleadoPList({Key? key, required this.historialServiciosEmpleado});

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
          margin: EdgeInsets.only(
            left: screenSize * 0.05,
            right: screenSize * 0.05,
            bottom: 10.0,
            top: 10.0
          ),
          child: Column(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(top: 2.0,),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(historialServiciosEmpleado[index].nombre_servicio, textAlign: TextAlign.left,style: const TextStyle(fontSize: 16),),
                    Text("Emitido el: " + historialServiciosEmpleado[index].fecha_publicacion, textAlign: TextAlign.left,style: const TextStyle(fontSize: 14),),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 2.0,),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(historialServiciosEmpleado[index].nombre + " " + historialServiciosEmpleado[index].apellido, textAlign: TextAlign.left,style: const TextStyle(fontSize: 14),),
                    //Text("Aceptado el: " + historialServiciosEmpleado[index].fecha_aceptacion, textAlign: TextAlign.left,style: const TextStyle(fontSize: 14),),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                margin: const EdgeInsets.only(top: 2.0,),
                child: FutureBuilder<String>(   
                  future: getLocacion(double.parse(historialServiciosEmpleado[index].latitud), double.parse(historialServiciosEmpleado[index].longitud)),
                  builder: (context, snapshot){
                    if (snapshot.hasError) {
                      return const Center(
                        child: Text('An error has occurred!'),
                      );
                    } else if (snapshot.hasData) {
                      return Flexible(
                        child: Text(snapshot.data.toString(), maxLines: 15, style: const TextStyle(fontSize: 14))
                      );
                    } else {
                      return const Center(
                        child: LinearProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 2.0,),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("\$" + historialServiciosEmpleado[index].costo + " MXN", textAlign: TextAlign.left,style: const TextStyle(fontSize: 14),),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                margin: const EdgeInsets.only(top: 2.0,),
                child: Flexible(
                  child: Text("Descripción: " + historialServiciosEmpleado[index].descripcion, maxLines: 15, textAlign: TextAlign.left,style: const TextStyle(fontSize: 14),),
                ),
              ),
              /*Container(
                margin: const EdgeInsets.only(top: 2.0,),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Calificación: " + historialServiciosEmpleado[index].valoracion, textAlign: TextAlign.left,style: const TextStyle(fontSize: 14),),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 2.0,),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Reseña: " +historialServiciosEmpleado[index].resena, textAlign: TextAlign.left,style: const TextStyle(fontSize: 14),),
                  ],
                ),
              ),*/
              const Divider(color: Color(0xFFF96332),thickness: 0.5),           
            ],
          ),    
        );    
      },
    );
  }
}

class HistorialServiciosEmpleadoAList extends StatelessWidget {
  const HistorialServiciosEmpleadoAList({Key? key, required this.historialServiciosEmpleado});

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
          margin: EdgeInsets.only(
            left: screenSize * 0.05,
            right: screenSize * 0.05,
            bottom: 10.0,
            top: 10.0
          ),
          child: Column(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(top: 2.0,),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(historialServiciosEmpleado[index].nombre_servicio, textAlign: TextAlign.left,style: const TextStyle(fontSize: 16),),
                    Text("Emitido el: " + historialServiciosEmpleado[index].fecha_publicacion, textAlign: TextAlign.left,style: const TextStyle(fontSize: 14),),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 2.0,),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(historialServiciosEmpleado[index].nombre + " " + historialServiciosEmpleado[index].apellido, textAlign: TextAlign.left,style: const TextStyle(fontSize: 14),),
                    Text("Aceptado el: " + historialServiciosEmpleado[index].fecha_aceptacion, textAlign: TextAlign.left,style: const TextStyle(fontSize: 14),),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                margin: const EdgeInsets.only(top: 2.0,),
                child: FutureBuilder<String>(   
                  future: getLocacion(double.parse(historialServiciosEmpleado[index].latitud), double.parse(historialServiciosEmpleado[index].longitud)),
                  builder: (context, snapshot){
                    if (snapshot.hasError) {
                      return const Center(
                        child: Text('An error has occurred!'),
                      );
                    } else if (snapshot.hasData) {
                      return Flexible(
                        child: Text(snapshot.data.toString(), maxLines: 15, style: const TextStyle(fontSize: 14))
                      );
                    } else {
                      return const Center(
                        child: LinearProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 2.0,),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("\$" + historialServiciosEmpleado[index].costo + " MXN", textAlign: TextAlign.left,style: const TextStyle(fontSize: 14),),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                margin: const EdgeInsets.only(top: 2.0,),
                child: Flexible(
                  child: Text("Descripción: " + historialServiciosEmpleado[index].descripcion, maxLines: 15, textAlign: TextAlign.left,style: const TextStyle(fontSize: 14),),
                ),
              ),
              /*Container(
                margin: const EdgeInsets.only(top: 2.0,),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Calificación: " + historialServiciosEmpleado[index].valoracion, textAlign: TextAlign.left,style: const TextStyle(fontSize: 14),),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 2.0,),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Reseña: " +historialServiciosEmpleado[index].resena, textAlign: TextAlign.left,style: const TextStyle(fontSize: 14),),
                  ],
                ),
              ),*/
              const Divider(color: Color(0xFFF96332),thickness: 0.5),           
            ],
          ),    
        );    
      },
    );
  }
}


class HistorialServiciosEmpleadoFList extends StatelessWidget {
  const HistorialServiciosEmpleadoFList({Key? key, required this.historialServiciosEmpleado});

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
          margin: EdgeInsets.only(
            left: screenSize * 0.05,
            right: screenSize * 0.05,
            bottom: 10.0,
            top: 10.0
          ),
          child: Column(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(top: 2.0,),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(historialServiciosEmpleado[index].nombre_servicio, textAlign: TextAlign.left,style: const TextStyle(fontSize: 16),),
                    Text("Emitido el: " + historialServiciosEmpleado[index].fecha_publicacion, textAlign: TextAlign.left,style: const TextStyle(fontSize: 14),),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 2.0,),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(historialServiciosEmpleado[index].nombre + " " + historialServiciosEmpleado[index].apellido, textAlign: TextAlign.left,style: const TextStyle(fontSize: 14),),
                    Text("Aceptado el: " + historialServiciosEmpleado[index].fecha_aceptacion, textAlign: TextAlign.left,style: const TextStyle(fontSize: 14),),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                margin: const EdgeInsets.only(top: 2.0,),
                child: FutureBuilder<String>(   
                  future: getLocacion(double.parse(historialServiciosEmpleado[index].latitud), double.parse(historialServiciosEmpleado[index].longitud)),
                  builder: (context, snapshot){
                    if (snapshot.hasError) {
                      return const Center(
                        child: Text('An error has occurred!'),
                      );
                    } else if (snapshot.hasData) {
                      return Flexible(
                        child: Text(snapshot.data.toString(), maxLines: 15, style: const TextStyle(fontSize: 14))
                      );
                    } else {
                      return const Center(
                        child: LinearProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 2.0,),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("\$" + historialServiciosEmpleado[index].costo + " MXN", textAlign: TextAlign.left,style: const TextStyle(fontSize: 14),),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                margin: const EdgeInsets.only(top: 2.0,),
                child: Flexible(
                  child: Text("Descripción: " + historialServiciosEmpleado[index].descripcion, maxLines: 15, textAlign: TextAlign.left,style: const TextStyle(fontSize: 14),),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 2.0,),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Calificación: " + historialServiciosEmpleado[index].valoracion, textAlign: TextAlign.left,style: const TextStyle(fontSize: 14),),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 2.0,),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Reseña: " +historialServiciosEmpleado[index].resena, textAlign: TextAlign.left,style: const TextStyle(fontSize: 14),),
                  ],
                ),
              ),
              const Divider(color: Color(0xFFF96332),thickness: 0.5),           
            ],
          ),    
        );    
      },
    );
  }
}