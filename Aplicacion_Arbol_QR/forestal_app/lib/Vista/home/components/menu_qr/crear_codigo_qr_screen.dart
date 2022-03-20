import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forestal_app/Modelo/Arboles.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class CrearCodigoQrScreen extends StatefulWidget {
  const CrearCodigoQrScreen({Key? key}) : super(key: key);

  @override
  _CrearCodigoQRScreen createState() => _CrearCodigoQRScreen();
}

class _CrearCodigoQRScreen extends State<CrearCodigoQrScreen> {
  Uint8List bytes = Uint8List(0);
  bool boolInicio = false;

  @override
  initState() {
    super.initState();
    boolInicio = true;
  }

  @override
  Widget build(BuildContext context) {
    List? _listArguementos =
        ModalRoute.of(context)!.settings.arguments as List?;
    Arboles? objArbol = _listArguementos![0]; //cargamos datos del arbol
    //Usuario? objUsuario = _listArguementos[1]; //cargamos datos del usuario

    if (boolInicio) {
      String _strTextoQR = objArbol!.getId_a.toString();
      _generateBarCode(_strTextoQR);
      boolInicio = false;
    }

    Widget _buttonGroup() {
      return Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: SizedBox(
              height: 120,
              child: InkWell(
                onTap: () async {
                  try {
                    _guardarQR("arbol_" + objArbol!.getId_a.toString());
                    _Mensaje('¡Almacenacmiento exitoso!');
                  } catch (error) {
                    print("error----->");
                    _Mensaje('¡Almacenacmiento fallido!');
                  }
                },
                child: Card(
                  child: Column(
                    children: const <Widget>[
                      Expanded(
                        flex: 2,
                        child: Icon(Icons.save),
                      ),
                      Divider(height: 20),
                      Expanded(flex: 1, child: Text("Guardar")),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: SizedBox(
              height: 120,
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Card(
                  child: Column(
                    children: const <Widget>[
                      Expanded(
                        flex: 2,
                        child: Icon(Icons.exit_to_app_sharp),
                      ),
                      Divider(height: 20),
                      Expanded(flex: 1, child: Text("Salir")),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    }

    /* Contenedor de QQr*/
    Widget _qrCodeWidget(Uint8List bytes, BuildContext context) {
      return Padding(
        padding: const EdgeInsets.all(10),
        child: Card(
          //elevation: 30,
          child: Column(
            children: <Widget>[
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Icon(Icons.verified_user,
                            size: 70, color: Colors.green),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const Text('  Código QR ',
                                style: TextStyle(fontSize: 25)),
                            Text(
                                '  Nom. Común: ' +
                                    objArbol!.getNombre_comun_a.toString(),
                                style: const TextStyle(fontSize: 15)),
                            Text(
                                '  Nom Cientifico: ' +
                                    objArbol.getNombre_cientifico_a.toString(),
                                style: const TextStyle(fontSize: 15)),
                          ],
                        ),
                        const Spacer(),
                        //Icon(Icons.more_vert, size: 18, color: Colors.black54),
                      ],
                    ),
                    //Icon(Icons.more_vert, size: 18, color: Colors.black54),
                  ],
                ),
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                decoration: const BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(4),
                      topRight: Radius.circular(4)),
                ),
              ),
              Column(
                children: <Widget>[
                  SizedBox(
                    height: 400,
                    child: bytes.isEmpty
                        ? const Center(
                            child: Text('Código vacío ... ',
                                style: TextStyle(color: Colors.black38)),
                          )
                        : Image.memory(bytes),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text('Generar código QR'),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.assignment),
            tooltip: 'Grid',
          ),
        ],
      ),
      body: Builder(
        builder: (BuildContext context) {
          return ListView(
            children: <Widget>[
              _qrCodeWidget(bytes, context),
              const Divider(height: 80),
              _buttonGroup(),
            ],
          );
        },
      ),
    );
  }

//generar codigo QR
  Future _generateBarCode(String inputCode) async {
    //print(inputCode);
    Uint8List result = await scanner.generateBarCode(inputCode);
    setState(() => bytes = result);
  }

  //generar mensaje
  void _Mensaje(String texto) {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(texto)));
  }

  //guardar imagen QR
  Future<void> _guardarQR(String nombreFoto) async {
    await ImageGallerySaver.saveImage(bytes, name: nombreFoto);
  }
}
