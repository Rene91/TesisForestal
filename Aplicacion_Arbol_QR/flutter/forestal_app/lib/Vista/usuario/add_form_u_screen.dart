import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:forestal_app/Modelo/Usuario.dart';
import 'package:forestal_app/Vista/usuario/rounded_button_user.dart';
import 'package:forestal_app/componentsGeneral/constants.dart';
import 'package:forestal_app/componentsGeneral/rounded_date_time.dart';
import 'package:forestal_app/componentsGeneral/rounded_email_input.dart';
import 'package:forestal_app/componentsGeneral/rounded_password_input.dart';
import 'package:forestal_app/componentsGeneral/rounded_text_input.dart';

class AddFormUserScreen extends StatelessWidget {
  AddFormUserScreen({
    Key? key,
    required this.isLogin,
    required this.animationDuration,
    required this.size,
    required this.defaultLoginSize,
    required this.getTextNomnbres_User,
    required this.getTextApllidos_User,
    required this.getTextEmail_User,
    required this.getTextFechaNacimiento_User,
    required this.getTextPassoword_User,
    required this.getConfirtTextPassoword_User,
    required this.globalFormkey,
  }) : super(key: key);

  bool isLogin;
  final Duration animationDuration;
  final Size size;
  final double defaultLoginSize;
  final TextEditingController getTextNomnbres_User;
  final TextEditingController getTextApllidos_User;
  final TextEditingController getTextEmail_User;
  final TextEditingController getTextFechaNacimiento_User;
  final TextEditingController getTextPassoword_User;
  final TextEditingController getConfirtTextPassoword_User;
  final globalFormkey;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: isLogin ? 0.0 : 1.0,
      duration: animationDuration * 5,
      child: Visibility(
        visible: !isLogin,
        child: Align(
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: SizedBox(
              width: size.width,
              height: defaultLoginSize,
              child: Form(
                key: globalFormkey,
                child: ListView(
                  //vista forma de columnas
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      //cargamos elementos en columna

                      children: <Widget>[
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'Formulario de Registro',
                          //'¡Bienvenido a Forestal App!',
                          //creamos titulo de bien
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              //ponemos en negrita el texto
                              fontSize: 24 //aumentamos letra
                              ),
                        ),
                        const SizedBox(
                          height: 5,
                        ), //salto de linea
                        //creamos caja de texto user

                        RoundTextInput(
                          icon: FontAwesomeIcons.idCard,
                          hint: 'Nombres',
                          obtenerDatos: getTextNomnbres_User,
                        ),

                        RoundTextInput(
                          icon: FontAwesomeIcons.addressCard,
                          hint: 'Apellidos',
                          obtenerDatos: getTextApllidos_User,
                        ),

                        RoundEmailtInput(
                          icon: Icons.mail,
                          hint: 'Correo Electrónico',
                          obtenerDatos: getTextEmail_User,
                        ), //creamos caja de texto user

                        RoundDateTimeInput(
                          icon: Icons.arrow_drop_down,
                          hint: 'Fecha Nacimiento',
                          obtenerDatos: getTextFechaNacimiento_User,
                        ), //creamos caja de texto user

                        RoundPasswordInput(
                          icon: Icons.lock,
                          hint: 'Contraseña',
                          obtenerDatos: getTextPassoword_User,
                        ), //creamos caja de texto password
                        RoundPasswordInput(
                          icon: Icons.lock,
                          hint: 'Confirmar Contraseña',
                          obtenerDatos: getConfirtTextPassoword_User,
                        ), //creamos caja de texto password

                        const SizedBox(
                          height: 10,
                        ),
                        RoundeButtonUser(
                          title: 'REGISTRARSE',
                          Metodo: "registroUsuario",
                          objUser: Usuario(
                              0,
                              getTextNomnbres_User.text,
                              getTextApllidos_User.text,
                              getTextEmail_User.text,
                              getTextPassoword_User.text,
                              getConfirtTextPassoword_User.text,
                              getTextFechaNacimiento_User.text,
                              "usuario",
                              "P",
                              ""),
                          globalFormkey: globalFormkey,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
