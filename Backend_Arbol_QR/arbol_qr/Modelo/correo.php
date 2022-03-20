<?php

use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

//enviarEmail("hola", "ramiro.rivera@unl.edu", "3", "link", "fechaActivacion", "fechaCaducidad", "usuario", "combo", "precio");

function correo_administrador($Asunto, $urlServer, $nomUsuario, $nomAdministrador, $emailAdministrador, $emailUsuario) {
    require './PHPMailer-master/src/Exception.php';
    require './PHPMailer-master/src/PHPMailer.php';
    require './PHPMailer-master/src/SMTP.php';

    $mail = new PHPMailer(true);

    try {
        $encabezados = "MIME-Version: 1.0" . "\r\n";

# ojo, es una concatenación:
        $encabezados .= "Content-type:text/html; charset=UTF-8" . "\r\n";
        $encabezados .= 'From: Seridor<soporte@r3gsystems.com>' . "\r\n";

        $mensaje = '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//ES"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
        <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport"/>

        <title>Árbol QR</title>
        <style type="text/css">
            h1{
                color: #288c5a;
            }
            a{
                color: #578c28;
            }
            p{
                font-size: 1rem;
            }
            img{
                width: 30rem;
                height: 30rem;
            }
            .logo
            {
                width: 10rem;
                height: 10rem;
            }
        </style>
    </head>
    <body>
        <center>
            <h1>Árbol QR</h1>
            <img class="logo" src="https://raw.githubusercontent.com/Rene91/TesisForestal/main/ico.png"/>
            <p>
                Hola <strong>' . $nomAdministrador . '</strong>, el usuario: ' . $nomUsuario . ' con email: ' . $emailUsuario . '  desea permisos para ingresar al sistema. 
            </p>

            <p>
                <strong>Si desea conceder permisos, clic en "SÍ" de lo contrario no contestar mensaje</strong>
                <br>
            </p> 
            <h2><strong><a href="' . $urlServer . "?accion=enviarEmailUsu&nomUsuario=" . $nomUsuario . "&emailUsuario=" . $emailUsuario . '">SI</a></strong></h2>
            <h1><strong>GRACIAS POR RESPONDER ESTE MENSAJE</strong></h1>
        </center>
    </body>
</html>';
        $mensaje = wordwrap($mensaje, 70, "\r\n");

//    //Server settings
        $mail->SMTPDebug = 0;                      // Enable verbose debug output
        $mail->isSMTP();                                            // Send using SMTP
        $mail->Host = 'smtp.gmail.com';                    // Set the SMTP server to send through
        $mail->SMTPAuth = true;                                    // Enable SMTP authentication
        $mail->Username = 'arbol.qr.loja@gmail.com';                     // SMTP username
        $mail->Password = 'garbolqr2022';                                // SMTP password
        $mail->SMTPSecure = 'LTS';         // Enable TLS encryption; `PHPMailer::ENCRYPTION_SMTPS` encouraged
        $mail->Port = 587;                                    // TCP port to connect to, use 465 for `PHPMailer::ENCRYPTION_SMTPS` above
//    //Recipients
        $mail->setFrom('soporte@arbol.qr.loja.com', 'Árbol QR');
        $mail->addAddress($emailAdministrador, $nomAdministrador);
        //////    $mail->addAddress('ellen@example.com');               // Name is optional
////    $mail->addReplyTo('info@example.com', 'Information');
////    $mail->addCC('cc@example.com');
////    $mail->addBCC('bcc@example.com');
//
////    // Attachments enviar archivos
////    $mail->addAttachment('/var/tmp/file.tar.gz');         // Add attachments
////    $mail->addAttachment('/tmp/image.jpg', 'new.jpg');    // Optional name
//    // Content
//    mail($destinatario,$asunto,  $subject, $message);
        $mail->isHTML(true);                                  // Set email format to HTML
        $mail->Subject = $Asunto;
//    $mail->
        $mail->Body = $mensaje; //con html
////    $mail->AltBody = 'This is the body in plain text for non-HTML mail clients';//sin html
//
        if ($mail->send()) {
            //echo "Mail sent Successfully";
        } else {
            echo "Email no existe";
        }
    } catch (Exception $e) {
        echo "Error . Mailer Error: {$mail->ErrorInfo}";
    }
}

function correo_usuario($Asunto, $nomUsuario, $emailUsuario) {
    require './PHPMailer-master/src/Exception.php';
    require './PHPMailer-master/src/PHPMailer.php';
    require './PHPMailer-master/src/SMTP.php';

    $mail = new PHPMailer(true);

    try {
        $encabezados = "MIME-Version: 1.0" . "\r\n";

# ojo, es una concatenación:
        $encabezados .= "Content-type:text/html; charset=UTF-8" . "\r\n";
        $encabezados .= 'From: Servidor<soporte@r3gsystems.com>' . "\r\n";

        $mensaje = '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//ES"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
        <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport"/>

            <title>Árbol QR</title>
            <style type="text/css">
                h1{
                    color: #288c5a;
                }
                p{
                    font-size: 1rem;
                }
                img{
                    width: 30rem;
                    height: 30rem;
                }
                .logo
                {
                    width: 10rem;
                    height: 10rem;
                }
            </style>
    </head>
    <body>
        <center>
            <h1>Árbol QR</h1>
            <img class="logo" src="https://raw.githubusercontent.com/Rene91/TesisForestal/main/ico.png"/>
                <p>
                    Hola <strong>' . $nomUsuario . '</strong>, su acceso a la aplicación ha sido permitido por un administrador.
                </p>
                <h1><strong>NO CONTESTAR MENSAJE</strong></h1>
        </center>
    </body>
</html>';
        $mensaje = wordwrap($mensaje, 70, "\r\n");

//    //Server settings
        $mail->SMTPDebug = 0;                      // Enable verbose debug output
        $mail->isSMTP();                                            // Send using SMTP
        $mail->Host = 'smtp.gmail.com';                    // Set the SMTP server to send through
        $mail->SMTPAuth = true;                                   // Enable SMTP authentication
        $mail->Username = 'arbol.qr.loja@gmail.com';                     // SMTP username
        $mail->Password = 'garbolqr2022';                                // SMTP password
        $mail->SMTPSecure = 'LTS';         // Enable TLS encryption; `PHPMailer::ENCRYPTION_SMTPS` encouraged
        $mail->Port = 587;                                    // TCP port to connect to, use 465 for `PHPMailer::ENCRYPTION_SMTPS` above
//    //Recipients
        $mail->setFrom('soporte@arbol.qr.loja.com', 'Árbol QR');
        $mail->addAddress($emailUsuario, $nomUsuario);
        //////    $mail->addAddress('ellen@example.com');               // Name is optional
////    $mail->addReplyTo('info@example.com', 'Information');
////    $mail->addCC('cc@example.com');
////    $mail->addBCC('bcc@example.com');
//
////    // Attachments enviar archivos
////    $mail->addAttachment('/var/tmp/file.tar.gz');         // Add attachments
////    $mail->addAttachment('/tmp/image.jpg', 'new.jpg');    // Optional name
//    // Content
//    mail($destinatario,$asunto,  $subject, $message);
        $mail->isHTML(true);                                  // Set email format to HTML
        $mail->Subject = $Asunto;
//    $mail->
        $mail->Body = $mensaje; //con html
////    $mail->AltBody = 'This is the body in plain text for non-HTML mail clients';//sin html
//
        if ($mail->send()) {
            //echo "Mail sent Successfully";
        } else {
            echo "Email no existe";
        }
    } catch (Exception $e) {
        echo "Error . Mailer Error: {$mail->ErrorInfo}";
    }
}

function link_restablecer_contraseña($Asunto, $pantallaContraseña, $urlServer, $emailUsuario) {
    require './PHPMailer-master/src/Exception.php';
    require './PHPMailer-master/src/PHPMailer.php';
    require './PHPMailer-master/src/SMTP.php';

    $mail = new PHPMailer(true);

    try {
        $encabezados = "MIME-Version: 1.0" . "\r\n";

# ojo, es una concatenación:
        $encabezados .= "Content-type:text/html; charset=UTF-8" . "\r\n";
        $encabezados .= 'From: Servidor<soporte@r3gsystems.com>' . "\r\n";

        $mensaje = '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//ES"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
        <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport"/>

        <title>Árbol QR</title>
        <style type="text/css">
            h1{
                color: #288c5a;
            }
            p{
                font-size: 1rem;
            }
            img{
                width: 30rem;
                height: 30rem;
            }
            .logo
            {
                width: 10rem;
                height: 10rem;
            }
            /*** ESTILOS BOTÓN SLIDE TOP ***/
            .ov-btn-slide-top {
                background: #55d741; /* color de fondo */
                color: #fff; /* color de fuente */
                border: 2px solid #4741d7; /* tamaño y color de borde */
                padding: 16px 20px;
                border-radius: 3px; /* redondear bordes */
                position: relative;
                z-index: 1;
                overflow: hidden;
                display: inline-block;
            }
            .ov-btn-slide-top:hover {
                color: #fff; /* color de fuente hover */
            }
            .ov-btn-slide-top::after {
                content: "";
                background: #41d78c; /* color de fondo hover */
                position: absolute;
                z-index: -1;
                padding: 16px 20px;
                display: block;
                left: 0;
                right: 0;
                top: -100%;
                bottom: 100%;
                -webkit-transition: all 0.35s;
                transition: all 0.35s;
            }
            .ov-btn-slide-top:hover::after {
                left: 0;
                right: 0;
                top: 0;
                bottom: 0;
                -webkit-transition: all 0.35s;
                transition: all 0.35s;
            }
        </style>
    </head>
    <body>
        <center>
            <h1>Árbol QR</h1>
            <img class="logo" src="https://raw.githubusercontent.com/Rene91/TesisForestal/main/ico.png"/>
            <p>
                <strong>¿Has solicitado cambiar contraseña?</strong>
            </p>
            <p>
                Hemos recibido un pedido de cambio de contraseña de tu cuenta. Si has sido tú, puedes ingresar una nueva contraseña.
            </p>
            
            <a href="' . $pantallaContraseña . "?email=" . $emailUsuario . '" class="ov-btn-slide-top">INGRESAR NUEVA CONTRASEÑA</a>
            <p>
                Si no quieres ingresar una nueva contraseña o no has sido quien lo ha solicitado, simplemente ignora este mensaje.            </p>
        </center>
    </body>
</html>';
        $mensaje = wordwrap($mensaje, 70, "\r\n");

//    //Server settings
        $mail->SMTPDebug = 0;                      // Enable verbose debug output
        $mail->isSMTP();                                            // Send using SMTP
        $mail->Host = 'smtp.gmail.com';                    // Set the SMTP server to send through
        $mail->SMTPAuth = true;                                   // Enable SMTP authentication
        $mail->Username = 'arbol.qr.loja@gmail.com';                     // SMTP username
        $mail->Password = 'garbolqr2022';                               // SMTP password
        $mail->SMTPSecure = 'LTS';         // Enable TLS encryption; `PHPMailer::ENCRYPTION_SMTPS` encouraged
        $mail->Port = 587;                                    // TCP port to connect to, use 465 for `PHPMailer::ENCRYPTION_SMTPS` above
//    //Recipients
        $mail->setFrom('soporte@arbol.qr.loja.com', 'Árbol QR');
        $mail->addAddress($emailUsuario, $emailUsuario);
        //////    $mail->addAddress('ellen@example.com');               // Name is optional
////    $mail->addReplyTo('info@example.com', 'Information');
////    $mail->addCC('cc@example.com');
////    $mail->addBCC('bcc@example.com');
//
////    // Attachments enviar archivos
////    $mail->addAttachment('/var/tmp/file.tar.gz');         // Add attachments
////    $mail->addAttachment('/tmp/image.jpg', 'new.jpg');    // Optional name
//    // Content
//    mail($destinatario,$asunto,  $subject, $message);
        $mail->isHTML(true);                                  // Set email format to HTML
        $mail->Subject = $Asunto;
//    $mail->
        $mail->Body = $mensaje; //con html
////    $mail->AltBody = 'This is the body in plain text for non-HTML mail clients';//sin html
//
        if ($mail->send()) {
            //echo "Mail sent Successfully";
        } else {
            echo "Email no existe";
        }
    } catch (Exception $e) {
        echo "Error . Mailer Error: {$mail->ErrorInfo}";
    }
}

?>
