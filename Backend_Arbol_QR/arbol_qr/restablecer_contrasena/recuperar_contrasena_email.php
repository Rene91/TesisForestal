<!DOCTYPE html>
<!--
Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
Click nbfs://nbhost/SystemFileSystem/Templates/Scripting/EmptyPHPWebPage.php to edit this template
-->
<?php
if (isset($_REQUEST["server"])) {
    $server = $_REQUEST["server"];
    ?>
    <html>
        <head>
            <meta charset="UTF-8">
            <title></title>
            <link rel="stylesheet" href="estilo.css"/> 
        </head>
        <body>
            <div class="container">
                <div class="regisFrm">
                    <center>
                        <h1>Árbol QR</h1>
                        <img class="logo" src="https://raw.githubusercontent.com/Rene91/TesisForestal/main/ico.png"/>
                    </center>
                    <form action="../Modelo/Datos.php" method="POST" enctype="multipart/form-data">
                        <h2>Restablecer contraseña</h2>            
                        <p>
                            Hola, se enviará correo electrónico para restablecer tu contraseña 
                        </p>
                        <input type="email" name="email" placeholder="Correo Electrónico" required="">
                        <input type="hidden" name="accionContrasena" value="linkRestablecerContrasena">
                        <div class="send-button">
                            <input type="submit" name="forgotSubmit" value="Enviar correo electrónico">
                        </div>
                    </form>
                </div>
            </div>
        </body>
    </html>
    <?php
} else {
    header("Location: https://arbol-loja.000webhostapp.com/");
}
?>
