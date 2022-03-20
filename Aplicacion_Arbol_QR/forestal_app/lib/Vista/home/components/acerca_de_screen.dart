import 'package:flutter/material.dart';

class AcercaDeScreen extends StatefulWidget {
  const AcercaDeScreen({Key? key}) : super(key: key);

  @override
  _AcercaDeScreen createState() => _AcercaDeScreen();
}

class _AcercaDeScreen extends State<AcercaDeScreen> {
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Acerca de Nosotros"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              "Acerca de Árbol QR",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              'Árbol QR es una aplicación móvil que forma parte del proyecto de Tesis “Desarrollo de una aplicación móvil para la administración de características dasométricas, morfológicas, ecológicas y servicios ecosistémicos del arbolado urbano de la ciudad de Loja como parte del proyecto de investigación Dinámica de Crecimiento y Servicios Ecosistémicos del Arbolado Urbano de la Ciudad de Loja”.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.justify,
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "El proyecto fue desarrollado por un estudiante de la carrera de Ingeniería en Sistemas de la Universidad de loja, en el aplicativo podremos encontrar imágenes de cada aŕbol registrado y también se puede generar un código QR por cada árbol para tener un mar rápido acceso a la información, actual mente podrás encontrar miles de árboles registrados con sus respectivas características e inconvenientes.",
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.justify,
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "Desarrollador: \n     Ramiro Rene Rivera Guamán\nCelular: \n     0986023910\nCorreo Electrónico: \n    systemsloa@gmail.com",
              style: TextStyle(fontSize: 16),
              //textAlign: TextAlign.right,
            ),
            SizedBox(
              height: 15,
            ),
            RaisedButton(
                padding: EdgeInsets.all(15),
                color: Colors.red,
                textColor: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Salir",
                      style: TextStyle(fontSize: 20),
                    ),
                    Icon(Icons.arrow_forward_ios)
                  ],
                ),
                onPressed: () => {
                      // Aqui por ejemplo podrían guardar un registro de este celular en un base de datos en firebase.

                      Navigator.pop(context)
                    })
          ],
        ),
      ),
    );
  }
}
