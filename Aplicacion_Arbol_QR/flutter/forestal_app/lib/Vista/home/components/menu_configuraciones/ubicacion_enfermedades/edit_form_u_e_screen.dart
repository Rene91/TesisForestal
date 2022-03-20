import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:forestal_app/Controlador/UbicacionfermedadesDB.dart';
import 'package:forestal_app/Modelo/UbicacionEnfermedades.dart';
import 'package:forestal_app/componentsGeneral/constants.dart';
import 'package:forestal_app/componentsGeneral/rounded_button_cancelar.dart';
import 'package:forestal_app/componentsGeneral/rounded_text_descrip_input.dart';

class EditFormUbicacionEnfermedadesScreen extends StatefulWidget {
  const EditFormUbicacionEnfermedadesScreen({Key? key}) : super(key: key);

  @override
  _EditFormUbicacionEnfermedadesScreen createState() =>
      _EditFormUbicacionEnfermedadesScreen();
}

class _EditFormUbicacionEnfermedadesScreen
    extends State<EditFormUbicacionEnfermedadesScreen> {
  bool _boolInicio = false;
  /*   --------------- Parametros para Editar Usuario --------------*/
  late TextEditingController getTextDescricion = TextEditingController();

  @override
  void initState() {
    super.initState();
    _boolInicio = true;
    /*Obtenemos los datos del Usuario*/
  }

  @override
  void dispose() {
    //getTextDescricion.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size =
        MediaQuery.of(context).size; //obtenemos todo el ancho de la pantalla

    UbicacionEnfermedades? objArgumento;
    objArgumento =
        ModalRoute.of(context)!.settings.arguments as UbicacionEnfermedades?;

    if (_boolInicio) {
      getTextDescricion.text = objArgumento!.getDescripcion_ue!;
      _boolInicio = false;
    }
    int idPe = objArgumento!.getId_ue!;
    return WillPopScope(
        onWillPop: () async => willPopCallback(context),
        child:  Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: const Text('Ubicación de Enfermedades'),
          actions: <Widget>[
            IconButton(
              onPressed: () {
                try {
                  if (globalFormkey_UbicacionEnfermedades.currentState!
                      .validate()) {
                    if (getTextDescricion.text.length > 3) {
                      setState(() async {
                        UbicacionEnfermedadesDB objBD =
                            UbicacionEnfermedadesDB();
                        String accion = await objBD.Eliminar_UE(idPe);

                        if (accion == "ACCIÓN CORRECTA") {
                          Navigator.pop(context);
                          Navigator.of(context).pushReplacementNamed(
                              '/list_form_u_e_screen');

                          _Mensaje("Dato eliminado");
                        } else {
                          _Mensaje(
                              "Error al Editar: Revise su conexion de Internet");
                        }
                      });
                    }
                  }
                } on Exception catch (exception) {
                  _Mensaje("Error on server-> " + exception.toString());
                  throw Exception("Error on server");
                } catch (error) {
                  //_Mensaje("Error-> " + error.toString());
                }
              },
              color: Colors.red,
              icon: const Icon(FontAwesomeIcons.trash),
              tooltip: 'Grid',
            ),
          ],
        ),
        body: Form(
          key: globalFormkey_UbicacionEnfermedades,
          child: ListView(
            //vista forma de columnas
            children: <Widget>[
              const SizedBox(
                height: 5,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                //cargamos elementos en columna

                children: <Widget>[
                  const SizedBox(
                    height: 10,
                  ),

                  Text(
                    strTituloEdicion,
                    //'¡Bienvenido a Forestal App!',
                    //creamos titulo de bien venidad
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        //ponemos en negrita el texto
                        fontSize: 24 //aumentamos letra
                        ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  //salto de linea
                  RoundTextDescripInput(
                    icon: Icons.assignment_rounded,
                    hint: 'Descripción',
                    obtenerDatos: getTextDescricion,
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  Container(
                    alignment: Alignment.center,
                    child: MaterialButton(
                      onPressed: () {
                        try {
                          if (globalFormkey_UbicacionEnfermedades.currentState!
                              .validate()) {
                            if (getTextDescricion.text.length > 3) {
                              setState(() async {
                                _cargarDatos(context);
                                UbicacionEnfermedades obj =
                                    UbicacionEnfermedades(
                                        idPe, getTextDescricion.text, "A");
                                UbicacionEnfermedadesDB objBD =
                                    UbicacionEnfermedadesDB();
                                String accion = await objBD.Editar_UE(obj);
                                Navigator.pop(context);
                                if (accion == "ACCIÓN CORRECTA") {
                                  Navigator.pop(context);
                                  Navigator.of(context).pushReplacementNamed(
                                      '/list_form_u_e_screen');
                                } else {
                                  _Mensaje(
                                      "Error al Editar: Revise su conexion de Internet");
                                }
                              });
                            }
                          }
                        } on Exception catch (exception) {
                          _Mensaje("Error on server-> " + exception.toString());
                          throw Exception("Error on server");
                        } catch (error) {
                          //_Mensaje("Error-> " + error.toString());
                        }
                      },
                      child: Container(
                        //width: 200.0,
                        width: size.width * 0.8,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: kPrimaryColor,
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        alignment: Alignment.center,
                        child: const Text(
                          "Actualizar",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  const RoundeButtonCancelar(
                    title: "Cancelar",
                    ubicacion: "",
                  ),
                  const SizedBox(
                    height: 5,
                  ),

                  //salto de linea
                ],
              ),
            ],
          ),
        )));
  }

  void _Mensaje(String testo) {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(testo)));
  }
}


void _cargarDatos(context) {
  showDialog<String>(
    barrierDismissible: false,
    //barrierColor: Colors.green,
    context: context,
    builder: (BuildContext context) => AlertDialog(
      backgroundColor: kTreeColor,
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(
              margin: EdgeInsets.only(left: 7),
              child: const Text("Loading...")),
        ],
      ),
      actions: <Widget>[],
    ),
  );
}