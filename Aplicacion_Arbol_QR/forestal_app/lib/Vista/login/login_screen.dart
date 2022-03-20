import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forestal_app/Controlador/DispositivoDB.dart';
import 'package:forestal_app/componentsGeneral/constants.dart';

import '../usuario/add_form_u_screen.dart';
import 'components/login_form.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  //static String id = 'principal_screen';
  @override
  _LoginSreenState createState() => _LoginSreenState();
}

class _LoginSreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  /*   --------------- Parametros para Registro Usuario --------------*/
  late TextEditingController getTextNombres_User = TextEditingController();
  late TextEditingController getTextApellidos_User = TextEditingController();
  late TextEditingController getTextEmail_User = TextEditingController();
  late TextEditingController getTextPassword_User = TextEditingController();
  late TextEditingController getTextConfirtPassword_User =
      TextEditingController();
  late TextEditingController getTextFechaNacimiento_User =
      TextEditingController();

  GlobalKey<FormState> globalFormkeyUser = new GlobalKey<FormState>();
  GlobalKey<FormState> globalFormkeyUserLogin = new GlobalKey<FormState>();
  //variables para animaciones de pantalla
  bool isLogin = true;
  late Animation<double> containerSize;
  late AnimationController animationController;
  Duration animationDuration = const Duration(milliseconds: 270);

  // Nota: Esto es un GlobalKey<FormState>, no un GlobalKey<MyCustomFormState>!
  //final _formKey = GlobalKey<FormState>();

  /* Cargamos las animaciones con este metodo que permite hacer cambios en el sistema */
  @override
  void initState() {
    super.initState();
    getTextNombres_User.text = "";
    getTextApellidos_User.text = "";
    getTextEmail_User.text = "";
    getTextPassword_User.text = "";
    getTextConfirtPassword_User.text = "";
    getTextFechaNacimiento_User.text = "";

    SystemChrome.setEnabledSystemUIOverlays([]);
    animationController =
        AnimationController(vsync: this, duration: animationDuration); //o
  }

  @override
  void dispose() {
    animationController.dispose(); //activamos o desactivamos la animacion

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size =
        MediaQuery.of(context).size; /*obtenemos todo el ancho de la pantalla*/

    // ignore: unused_local_variable
    double viewInset = MediaQuery.of(context)
        .viewInsets
        .bottom; //lo utilizamos para determinar si el teclado está abierto o no
    double defaultLoginSize =
        size.height - (size.height * 0.2); //ubicacion de caja login en centro
    // ignore: unused_local_variable
    double defaultRegisterSize = size.height -
        (size.height * 0.1); //ubicacion de caja register en centro

    // variable para comenzar la animacion de desplazamiento de registro
    containerSize = Tween<double>(
            begin: size.height * 0.1,
            end: defaultRegisterSize) //container expandible
        .animate(
            CurvedAnimation(parent: animationController, curve: Curves.linear));

    verificarLogin(context); //verificar si usuario ya esta logueado

    return WillPopScope(
        onWillPop: () async => willPopCallbackSalirSistema(context),
        child: Scaffold(
          body: Stack(
            children: [
              //vamos a añadir algunas decoraciones
              /*creamos circuilo derecho */
              Positioned(
                  top: 100,
                  right: -50,
                  child: Container(
                    //creamos circulo
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: kPrimaryColor),
                  )),

              /*creamos circuilo izquierda */
              Positioned(
                top: -50,
                left: -50,
                child: Container(
                  //creamos circulo
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: kPrimaryColor),
                ),
              ),

              /*  Cancel button */
              AnimatedOpacity(
                  opacity: isLogin ? 0.0 : 1.0,
                  duration: animationDuration,
                  child: Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        width: size.width,
                        height: size.height * 0.1,
                        alignment: Alignment.bottomCenter,
                        child: IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: isLogin
                              ? null
                              : () {
                                  animationController.reverse();
                                  setState(() {
                                    isLogin = !isLogin;
                                    limpiarContenedor(getTextNombres_User);
                                    limpiarContenedor(getTextApellidos_User);
                                    limpiarContenedor(getTextEmail_User);
                                    limpiarContenedor(getTextPassword_User);
                                    limpiarContenedor(
                                        getTextConfirtPassword_User);
                                    limpiarContenedor(
                                        getTextFechaNacimiento_User);
                                    //Navigator.of(context).pop();
                                    //Navigator.of(context).pushNamed("/");
                                  });
                                },
                          color: kPrimaryColor,
                        ),
                      ))),

              /*      Login Form */

              LoginForm(
                isLogin: isLogin,
                animationDuration: animationDuration,
                size: size,
                defaultLoginSize: defaultLoginSize,
                getTextEmail_Login: getTextEmail_User,
                getTextPassword_login: getTextPassword_User,
                globalFormkey: globalFormkeyUserLogin,
              ),
              /* Register Container animacion*/
              AnimatedBuilder(
                animation: animationController, //obtenemos animacion
                builder: (context, child) {
                  //condicion para ocultar container inferior cuando se desplega teclado
                  if (viewInset == 0 && isLogin) {
                    print(isLogin);
                    return buildRegisterContainer();
                  } else if (!isLogin) {
                    return buildRegisterContainer();
                  }
                  //devolver el contenedor vacío para ocultar el widget o contenedor ultimo
                  return Container();
                },
              ),

              /* Register Form User */
              AddFormUserScreen(
                isLogin: isLogin,
                animationDuration: animationDuration,
                size: size,
                defaultLoginSize: defaultLoginSize,
                getTextNomnbres_User: getTextNombres_User,
                getTextApllidos_User: getTextApellidos_User,
                getTextEmail_User: getTextEmail_User,
                getTextFechaNacimiento_User: getTextFechaNacimiento_User,
                getTextPassoword_User: getTextPassword_User,
                getConfirtTextPassoword_User: getTextConfirtPassword_User,
                globalFormkey: globalFormkeyUser,
              ),
            ],
          ),
        ));
  }

  Widget buildRegisterContainer() {
    return Align(
      alignment: Alignment.bottomCenter,
      /*creamos contorno sombreado de container*/
      child: Container(
        width: double.infinity,
        height: containerSize.value,
        //obtiene el ancho de la pantalla
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(100),
            topRight: Radius.circular(100),
          ),
          color: kGroundColorColor,
        ),
        alignment: Alignment.center,

        /*creamos los datos intenos del container*/
        child: GestureDetector(
          onTap: !isLogin
              ? null
              : () {
                  animationController.forward(); //comenzamos la animacion
                  setState(() {
                    isLogin = !isLogin; //verificamos si es diferente de true
                  });
                },
          child: isLogin
              ? const Text(
                  /*verifacomos si es login o pantalla usuario */
                  "¿No tiene una cuenta? Regístrate",
                  style: TextStyle(color: kPrimaryColor, fontSize: 18),
                )
              : null,
        ),
      ),
    );
  }


  void verificarLogin(BuildContext context) {
    try {
      DispositivoDB dispositivo = DispositivoDB();
      dispositivo.BuscarId_D(context);
    } catch (e) {
      print("Error al verificar login-> " + e.toString());
    }
  }
}

void limpiarContenedor(TextEditingController contenedor) {
  contenedor.text = "";
}
