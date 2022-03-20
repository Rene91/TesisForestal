<?php

if (isset($_REQUEST["accion"])) {
////////////////////////////  ADMINSITRAR USUARIO  ////////////
    $obj = new DatosBD();
    require_once './correo.php';
    switch ($_REQUEST["accion"]) {
        case "listar": {
                $obj->listar($_REQUEST["sql"]);
            }
            break;
        case "insertar": {
                $obj->insertar($_REQUEST["sql"]);
            }
            break;
        case "editar": {
                $obj->editar($_REQUEST["sql"]);
            }
            break;
        case "respaldoBD": {
                $obj->respaldoBD();
            }
            break;

        case "enviarEmailAdmin": {
                correo_administrador("Contestar", $_REQUEST['urlServer'], $_REQUEST['nomUsuario'], $_REQUEST['nomAdministrador'], $_REQUEST['emailAdministrador'], $_REQUEST['emailUsuario']);
            }
            break;

        case "enviarEmailUsu": {
                $sql = "UPDATE tb_usuario SET estado_u = 'A' WHERE email_u= '" . $_REQUEST["emailUsuario"] . "' ";

                $obj->editar($sql);
                correo_usuario("No Contestar", $_REQUEST['nomUsuario'], $_REQUEST['emailUsuario']);
            }
            break;

        case "cambiar_contrasena": {
                $sql = "UPDATE tb_usuario SET contrasena_u = '" . $_REQUEST["contrena"] . "' WHERE email_u= '" . $_REQUEST["email"] . "' ";
                $obj->editar($sql);
            }
            break;

        default: {
                header("Location: https://arbol-loja.000webhostapp.com/");
            }
            break;
    }
} else {

    if (isset($_REQUEST["accionContrasena"])) {

        require_once './correo.php';
        switch ($_REQUEST["accionContrasena"]) {
            case "linkRestablecerContrasena": {

                    if (isset($_SERVER['HTTPS'])) {
                        // Codigo a ejecutar si se navega bajo entorno seguro.
                        $link = "https://" . $_SERVER['HTTP_HOST'] . $_SERVER['REQUEST_URI'];
                    } else {
                        // Codigo a ejecutar si NO se navega bajo entorno seguro.                        
                        $link = "https://" . $_SERVER['HTTP_HOST'] . $_SERVER['REQUEST_URI'];
                    }
                    $pantallaContrasena = str_replace("Modelo/Datos.php", "restablecer_contrasena/recuperar_contrasena.php", $link);
                    link_restablecer_contraseña("Restablecer Clave", $pantallaContrasena, $link, $_REQUEST['email']);
                }
                break;

            default: {
                    header("Location: https://arbol-loja.000webhostapp.com/");
                }
                break;
        }
    } else {
        header("Location: https://arbol-loja.000webhostapp.com/");
    }
}

class DatosBD {

    public function __construct() {
        include'./Conexion.php';
        $this->objConexion = new \Modelo\ConexionBD();
    }

    function listar($sql) {
        $datos = $this->objConexion->consultaRetorno($sql); //consultamos y obtenemos datos de consulta
        $resultado = array(); //creamos array vacio
        while (($fila = $datos->fetch_array(MYSQLI_ASSOC))) {
            $resultado[] = $fila; //obtenomos los datos en forma de arry de lectura
        }
        echo json_encode($resultado);
    }

    function insertar($sql) {//consultamos y obtenemos datos de consulta        
        ////////////////////////  creamos foto y transformamos despues /////////////
        //if ($_REQUEST['fotoBase64'] != "") {
        file_put_contents($_REQUEST['carpetafoto'], base64_decode($_REQUEST['fotoBase64']));
        $nuevoPesoArchivo = $this->pesoArchivo($_REQUEST['carpetafoto']); ///encimaos el archivo a tranformar  
        // }
        $datos = $this->objConexion->consultaSimple($sql); //consultamos y obtenemos datos de consulta
        echo json_encode($datos);
    }

    public function respaldoBD() {
        $datos = $this->objConexion->respaldoBD(); //consultamos y obtenemos datos de consulta
        echo json_encode($datos);
    }

    function editar($sql) {
        $datos = $this->objConexion->consultaSimple($sql); //consultamos y obtenemos datos de consulta        
        ////////////////////////  creamos foto y transformamos despues /////////////
        if ($_REQUEST['fotoBase64'] != "") {
            file_put_contents($_REQUEST['carpetafoto'], base64_decode($_REQUEST['fotoBase64']));
            $nuevoPesoArchivo = $this->pesoArchivo($_REQUEST['carpetafoto']); ///encimaos el archivo a tranformar  
        }
        //$nuevoPesoArchivo = $this->pesoArchivo($_REQUEST['nomfoto']);///encimaos el archivo a tranformar  

        echo json_encode($datos);
    }

    private function pesoArchivo($archivo) {
        if (isset($archivo)) {

            $rtOriginal = $archivo;

            //Crear variable
            $original = @imagecreatefromjpeg($rtOriginal);

            //Ancho y alto máximo
            //$max_ancho = 200;
            //$max_alto = 150;
            $max_ancho = 720;
            $max_alto = 1280;

            //Medir la imagen
            list($ancho, $alto) = getimagesize($rtOriginal);

            //Ratio
            $x_ratio = $max_ancho / $ancho;
            $y_ratio = $max_alto / $alto;

            //Proporciones
            if (($ancho <= $max_ancho) && ($alto <= $max_alto)) {
                $ancho_final = $ancho;
                $alto_final = $alto;
            } else if (($x_ratio * $alto) < $max_alto) {
                $alto_final = ceil($x_ratio * $alto);
                $ancho_final = $max_ancho;
            } else {
                $ancho_final = ceil($y_ratio * $ancho);
                $alto_final = $max_alto;
            }

            //Crear un lienzo coloeres de foto
            $lienzo = imagecreatetruecolor($ancho_final, $alto_final);

            //Copiar original en lienzo
            imagecopyresampled($lienzo, $original, 0, 0, 0, 0, $ancho_final, $alto_final, $ancho, $alto);

            //Destruir la original
            imagedestroy($original);

            //Crear la imagen y guardar en directorio upload/
            imagejpeg($lienzo, $archivo);

            return $archivo;
        }
    }

}

?>
