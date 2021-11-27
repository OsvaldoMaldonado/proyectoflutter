import 'package:flutter/material.dart';
import 'package:servicios_vic/model/modelo_servicios_cuentas.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class FinancesEmployeeScreen extends StatefulWidget{
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
    double screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        shadowColor: Colors.transparent,
        foregroundColor: const Color(0xFFF96332),
        title: const Text('Finanzas', style: TextStyle(fontSize: 20.0,color: Colors.black,),)
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[    
          SizedBox(height: screenheight * 0.01),
          Container(
            margin: const EdgeInsets.only(left: 10.0),
            child: const  Text("Fechar corte: ", style: TextStyle(fontSize: 18,), textAlign: TextAlign.start,),
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
          Expanded(
            child: FutureBuilder<TotalMes?>(
              future: fetchTotalMes(http.Client(), id, 'finalizado'),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text('Ningun Resultado!'),
                  );
                } else if (snapshot.hasData) {
                   return  Text("Saldo a corte: \$" + snapshot.data!.total.toString() + "MXN" ,style: const TextStyle(fontSize: 14.0,color: Colors.black,),);
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

class HistorialServiciosEmpleadoFList extends StatelessWidget {
  const HistorialServiciosEmpleadoFList({Key? key,required this.historialServiciosEmpleado});

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
                    Text("Finalizado el: " + historialServiciosEmpleado[index].fecha_aceptacion, textAlign: TextAlign.left,style: const TextStyle(fontSize: 14),),
                  ],
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
              const Divider(color: Color(0xFFF96332),thickness: 0.5),           
            ],
          ),    
        );    
      },
    );
  }
}