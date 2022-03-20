import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forestal_app/Controlador/PresenciaEnfermedadesDB.dart';
import 'package:forestal_app/Modelo/PresenciaEnfermedades.dart';
import 'package:forestal_app/componentsGeneral/rounded_button_cancelar.dart';
import 'package:forestal_app/componentsGeneral/constants.dart';
import 'package:forestal_app/componentsGeneral/rounded_text_descrip_input.dart';

class AddFormPresenciaEnfermedadesScreen extends StatefulWidget {
  const AddFormPresenciaEnfermedadesScreen({Key? key}) : super(key: key);

  @override
  _AddFormPresenciaEnfermedadesScreen createState() =>
      _AddFormPresenciaEnfermedadesScreen();
}

class _AddFormPresenciaEnfermedadesScreen
    extends State<AddFormPresenciaEnfermedadesScreen> {
  /*   --------------- Parametros para Editar Usuario --------------*/
  late TextEditingController getTextDescricion = TextEditingController();

  @override
  void initState() {
    super.initState();
    /*Obtenemos los datos del Usuario*/
  }

  @override
  void dispose() {
    getTextDescricion.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size =
        MediaQuery.of(context).size; //obtenemos todo el ancho de la pantalla

    return WillPopScope(
        onWillPop: () async => willPopCallback(context),
        child:  Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: const Text('Presencia de Enfermedades'),
          actions: <Widget>[
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.assignment),
              tooltip: 'Grid',
            ),
          ],
        ),
        body: Form(
          key: globalFormkey_PresenciaEnfermedades,
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
                    strTituloRegistro,
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
                          if (globalFormkey_PresenciaEnfermedades.currentState!
                              .validate()) {
                            if (getTextDescricion.text.length > 3) {
                              setState(() async {
                                PresenciaEnfermedades obj =
                                    PresenciaEnfermedades(
                                        0, getTextDescricion.text, "A");
                                PresenciaEnfermedadesDB objBD =
                                    PresenciaEnfermedadesDB();

                                const Center(
                                  child: CircularProgressIndicator(),
                                );

                                String accion = await objBD.Agregar_PE(obj);
                                if (accion == "ACCIÓN CORRECTA") {
                                  _Mensaje(
                                      "Datos Registrados");
                                  Navigator.pop(context);
                                  Navigator.of(context).pushReplacementNamed(
                                      '/list_form_p_e_screen');
                                  /*Navigator.of(context).pushNamed(
                                  "/list_form_p_enfermedades_screen");*/
                                } else {
                                  _Mensaje(
                                      "Error al Agregar: Revise su conexion de Internet");
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
                        //child: Row(
                        //mainAxisAlignment: MainAxisAlignment.center,
                        child: const Text(
                          "Guardar",
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
