import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:forestal_app/Controlador/AccionesRecomendadasDB.dart';
import 'package:forestal_app/Modelo/AccionesRecomendadas.dart';
import 'package:forestal_app/componentsGeneral/constants.dart';
import 'package:forestal_app/componentsGeneral/rounded_button_cancelar.dart';
import 'package:forestal_app/componentsGeneral/rounded_text_descrip_input.dart';

class EditFormAccionesRecomendadasScreen extends StatefulWidget {
  const EditFormAccionesRecomendadasScreen({Key? key}) : super(key: key);

  @override
  _EditFormAccionesRecomendadasScreen createState() =>
      _EditFormAccionesRecomendadasScreen();
}

class _EditFormAccionesRecomendadasScreen
    extends State<EditFormAccionesRecomendadasScreen> {
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

    AccionesRecomendadas? objArgumento;
    objArgumento =
        ModalRoute.of(context)!.settings.arguments as AccionesRecomendadas?;

    if (_boolInicio) {
      getTextDescricion.text = objArgumento!.getDescripcion_ar!;
      _boolInicio = false;
    }

    int? idPe = objArgumento!.getId_ar;
    return WillPopScope(
        onWillPop: () async => willPopCallback(context),
        child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              centerTitle: true,
              title: const Text('Acciones Recomendadas'),
              actions: <Widget>[
                IconButton(
                  onPressed: () {
                    try {
                      setState(() async {
                        AccionesRecomendadasDB objBD = AccionesRecomendadasDB();
                        String accion = await objBD.Eliminar_AR(idPe!);

                        if (accion == "ACCIÓN CORRECTA") {
                          Navigator.pop(context);
                          Navigator.of(context)
                              .pushReplacementNamed('/list_form_a_r_screen');

                          _Mensaje("Dato eliminado");
                        } else {
                          _Mensaje(
                              "Error al Editar: Revise su conexion de Internet");
                        }
                      });
                    } on Exception catch (exception) {
                      _Mensaje("Error on server-> " + exception.toString());
                      //throw Exception("Error on server");
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
              key: globalFormkey_AccionesRecomendadas,
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
                              if (globalFormkey_AccionesRecomendadas
                                  .currentState!
                                  .validate()) {
                                if (getTextDescricion.text.length > 3) {
                                  setState(() async {
                                    AccionesRecomendadas obj =
                                        AccionesRecomendadas(
                                            idPe, getTextDescricion.text, "A");
                                    AccionesRecomendadasDB objBD =
                                        AccionesRecomendadasDB();

                                    const Center(
                                      child: CircularProgressIndicator(),
                                    );

                                    String accion = await objBD.Editar_AR(obj);
                                    if (accion == "ACCIÓN CORRECTA") {
                                      _Mensaje(
                                          "Datos Actualizados");
                                      Navigator.pop(context);
                                      Navigator.of(context)
                                          .pushReplacementNamed(
                                              '/list_form_a_r_screen');
                                    } else {
                                      _Mensaje(
                                          "Error al Editar: Revise su conexion de Internet");
                                    }
                                  });
                                }
                              }
                            } on Exception catch (exception) {
                              _Mensaje(
                                  "Error on server-> " + exception.toString());
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
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
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
