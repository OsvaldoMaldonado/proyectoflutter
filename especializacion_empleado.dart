import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(especializacion_empleado());
}

class especializacion_empleado extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'Flutter Checkbox Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({this.title = 'Demo'});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Map<String, bool?> lightSwitches = {
    'Electricista': false,
    'Carpintero': false,
    'Cerrajero': false,
    'Coach de futbol': false,
    'Fumigador': false,
    'Limpieza de muebles': false,
    'Mariachi': false,
    'Masajista': false,
    'Mecanica': false,
  };

  @override
  Widget build(BuildContext context) {
    double screenSize = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    return Scaffold(



        body: Column(children: [
          Stack(
            children: <Widget>[
              new RotationTransition(
                turns: new AlwaysStoppedAnimation(180 / 360),
                child: Container(
                  width: screenSize,
                  height: screenheight * 0.22,
                  child: const DecoratedBox(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.vertical(bottom: Radius.circular(20.0)),
                      color: Color(0xFFF96332),
                    ),
                  ),
                ),
              ),

              Positioned(
                bottom : 0,
                child: RotationTransition(
                  turns: new AlwaysStoppedAnimation(180 / 360),
                  child: Container(
                    width: screenSize,
                    height: screenheight * 0.02,
                    child: const DecoratedBox(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.vertical(bottom: Radius.circular(20.0)),
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),


            ],
          ),
          Container(
            alignment: Alignment.centerLeft,
            child:Text(
              '  En que te especializas',
              style: const TextStyle(fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          ),
          Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: lightSwitches.keys
                      .map((roomName) => CheckboxListTile(
                    title: Text(roomName),
                    value: lightSwitches[roomName],
                    onChanged: (bool? value) {
                      setState(() {
                        lightSwitches[roomName] = value;
                      });
                    },
                  ))
                      .toList(),
                ),
              ),
              flex: 1),
          SizedBox(height: screenheight * 0.03,),
          OutlinedButton(

            onPressed: () {

            },
            child: const Text('Crear Cuenta',
              style: TextStyle(color: Colors.white),),
            style: OutlinedButton.styleFrom(
              shape: StadiumBorder(),
              //  padding: EdgeInsets.all(60),
              minimumSize: Size(screenSize * 0.50, screenheight * 0.10,),
              backgroundColor: Color(0xFF102C4D),
            ),
          ),
        ]
        )
    );
  }

}




