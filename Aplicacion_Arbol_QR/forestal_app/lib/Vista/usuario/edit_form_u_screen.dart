import 'dart:convert';
import 'dart:io';
import 'dart:io' as Io;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:forestal_app/Controlador/UsuarioDB.dart';
import 'package:forestal_app/Modelo/Usuario.dart';
import 'package:forestal_app/componentsGeneral/constants.dart';
import 'package:forestal_app/componentsGeneral/rounded_button_cancelar.dart';
import 'package:forestal_app/componentsGeneral/rounded_date_time.dart';
import 'package:forestal_app/componentsGeneral/rounded_email_input.dart';
import 'package:forestal_app/componentsGeneral/rounded_text_input.dart';
import 'package:image_picker/image_picker.dart';

class EditFormUserScreen extends StatefulWidget {
  const EditFormUserScreen({Key? key}) : super(key: key);

  @override
  _EditFormUserScreen createState() => _EditFormUserScreen();
}

enum ImageSourceType { gallery, camera }

class _EditFormUserScreen extends State<EditFormUserScreen> {
  bool boolInicio = false;
  var _FileImage;
  var _ImagePicker;
  int? _idUsuario;
  late String _linkImagen = "";
  late String _ImagenBase64Aux = "";

  /*   --------------- Parametros para Editar Usuario --------------*/
  late TextEditingController getTextNomnbres_U = TextEditingController();
  late TextEditingController getTextApllidos_U = TextEditingController();
  late TextEditingController getTextEmail_U = TextEditingController();
  late TextEditingController getTextFechaNacimiento_U = TextEditingController();

  @override
  void initState() {
    super.initState();
    /*Obtenemos los datos del Usuario*/
    _ImagePicker = new ImagePicker();
    boolInicio = true;
  }

  @override
  void dispose() {
    getTextNomnbres_U.dispose();
    getTextApllidos_U.dispose();
    getTextEmail_U.dispose();
    getTextFechaNacimiento_U.dispose();

    super.dispose();
  }

  /*Metodos camara*/

  _imgFromCamera() async {
    XFile? image = await _ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);
    setState(() {
      _FileImage = File(image!.path);
    });
    final bytes = await Io.File(image!.path).readAsBytesSync();
    _ImagenBase64Aux = base64Encode(bytes);
  }

  _imgFromGallery() async {
    XFile? image = await _ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _FileImage = File(image!.path);
    });
    final bytes = await Io.File(image!.path).readAsBytesSync();
    _ImagenBase64Aux = base64Encode(bytes);
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: Wrap(
                children: <Widget>[
                  ListTile(
                      leading: const Icon(Icons.photo_library),
                      title: const Text('Libreria de Fotos'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  ListTile(
                    leading: const Icon(Icons.photo_camera),
                    title: const Text('Cámara'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    Size size =
        MediaQuery.of(context).size; //obtenemos todo el ancho de la pantalla
    try {
      Usuario? objUsuario;
      objUsuario = ModalRoute.of(context)!.settings.arguments
          as Usuario?; //atraemos datos enviados
      if (boolInicio) {
        _idUsuario = objUsuario!.getId_u!;
        getTextNomnbres_U =
            TextEditingController(text: objUsuario.getNombre_u!.toString());
        getTextApllidos_U =
            TextEditingController(text: objUsuario.getApellido_u!.toString());
        getTextEmail_U =
            TextEditingController(text: objUsuario.getEmail_u!.toString());
        getTextFechaNacimiento_U = TextEditingController(
            text: objUsuario.getFechaNacimiento_u!.toString());
        _linkImagen = objUsuario.getFoto_u!.toString();
        boolInicio = false;
      }
    } catch (e) {
      print(e);
    }
    /*Uint8List imagen_bytes = Base64Codec()
        .decode(_linkImagen);*/ //convertir base64 en formato imagen

    return WillPopScope(
        onWillPop: () async => willPopCallback(context),
        child:  Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: const Text('Editar Usuario'),
          actions: <Widget>[
            IconButton(
              onPressed: () {},
              color: kPrimaryColor,
              icon: const Icon(FontAwesomeIcons.userCircle),
              //icon: Icon(Icons.person),
              tooltip: 'Grid',
            ),
          ],
        ),
        body: Form(
          autovalidateMode: AutovalidateMode.disabled,
          key: globalFormkey_EditarU,
          child: SingleChildScrollView(
            //vista forma de columnas
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(
                  height: 5,
                ),
                /*metodos para cargar foto*/

                SizedBox(
                    width: 200,
                    height: 200,
                    child: _FileImage != null
                        ? ClipOval(
                            child: Material(
                              color: kPrimaryColor,
                              child: InkWell(
                                onTap: () async {
                                  _showPicker(context);
                                },
                                child: Image.file(
                                  _FileImage,
                                  //color: Colors.white,
                                  //size: 50,
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          )
                        : ClipOval(
                            child: _linkImagen != ""
                                ? Material(
                                    color: kPrimaryColor,
                                    child: InkWell(
                                      onTap: () async {
                                        _showPicker(context);
                                      },
                                      child: Image.network(
                                        _linkImagen,
                                        //color: Colors.white,
                                        //size: 50,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  )
                                : Container(
                                    width: 200,
                                    height: 200,
                                    color: kPrimaryColor,
                                    child: InkWell(
                                      onTap: () async {
                                        _showPicker(context);
                                      },
                                      child: const Icon(
                                        Icons.add_a_photo_outlined,
                                        color: Colors.white,
                                        size: 100,
                                      ),
                                    ),
                                  ),
                          )),
                const SizedBox(
                  height: 10,
                ),

                const Text(
                  'Formulario de Edición',
                  //'¡Bienvenido a Forestal App!',
                  //creamos titulo de bien venidad
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      //ponemos en negrita el texto
                      fontSize: 24 //aumentamos letra
                      ),
                ),
                const SizedBox(
                  height: 10,
                ),
                //salto de linea

                RoundTextInput(
                  icon: FontAwesomeIcons.idCard,
                  hint: 'Nombres',
                  obtenerDatos: getTextNomnbres_U,
                  tipoEscritura: TextCapitalization.words,
                ),

                RoundTextInput(
                  icon: FontAwesomeIcons.addressCard,
                  hint: 'Apellidos',
                  obtenerDatos: getTextApllidos_U,
                  tipoEscritura: TextCapitalization.words,
                ),

                RoundEmailtInput(
                  icon: Icons.mail,
                  hint: 'Correo Electrónico',
                  obtenerDatos: getTextEmail_U,
                ),
                //creamos caja de texto user

                RoundDateTimeInput(
                  icon: Icons.arrow_drop_down,
                  hint: 'Fecha Nacimiento',
                  obtenerDatos: getTextFechaNacimiento_U,
                ),
                //creamos caja de texto user//creamos caja de texto password

                const SizedBox(
                  height: 10,
                ),

                /*   ++++++++  Actualizar  +++++++     */
                Container(
                  alignment: Alignment.center,
                  child: MaterialButton(
                    onPressed: () {
                      try {
                        if (globalFormkey_EditarU.currentState!.validate()) {
                          if (getTextNomnbres_U.text.length > 3 &&
                              getTextApllidos_U.text.length > 3 &&
                              getTextEmail_U.text.length > 3 &&
                              getTextFechaNacimiento_U.text.length > 3) {
                            setState(() async {
                              Usuario objUser = Usuario(
                                  _idUsuario,
                                  getTextNomnbres_U.text,
                                  getTextApllidos_U.text,
                                  getTextEmail_U.text,
                                  "getTextPassoword_User.text",
                                  "getConfirtTextPassoword_User.text",
                                  getTextFechaNacimiento_U.text,
                                  "admin",
                                  "A",
                                  _ImagenBase64Aux);
                              UsuarioDB objBD = UsuarioDB();
                              String accion = await objBD.Editar_U(objUser);

                              if (accion == "ACCIÓN CORRECTA") {
                                Navigator.of(context).pushReplacementNamed("/");
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
              ],
            ),
          ),
        )));
  }

  void _Mensaje(String testo) {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(testo)));
  }
}
