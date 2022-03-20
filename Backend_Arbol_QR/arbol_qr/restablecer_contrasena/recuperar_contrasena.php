<?php
if (isset($_REQUEST["email"])) {
    ?>
    <!DOCTYPE html>
    <!--
    Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
    Click nbfs://nbhost/SystemFileSystem/Templates/Scripting/EmptyPHPWebPage.php to edit this template
    -->
    <html>
        <head>
            <meta charset="UTF-8">
            <title></title>
            <link rel="stylesheet" href="estilo.css"/> 
            <script>
                function comprobarClave() {
                    clave1 = document.f1.confirm_password.value
                    clave2 = document.f1.password.value
                    email = document.f1.email.value

                    if (clave1 == clave2)
                    {
                    window.location.href = "https://arbol-loja.000webhostapp.com/arbol_qr/Modelo/Datos.php?accion=cambiar_contrasena&contrena=" + clave2 + "&email=" + email;

                    } else
                        alert("Las dos claves son distintas...\nIngrese clase iguales")
                }
            </script>
        </head>
        <body>
            <div class="container">
                <div class="regisFrm">
                    <center>
                        <h1>Árbol QR</h1>
                        <img class="logo" src="https://raw.githubusercontent.com/Rene91/TesisForestal/main/ico.png"/>
                    </center>
                    <form action="" name="f1">
                        <h2>Restablecer Contraseña</h2>       
                        <p>
                            Hola, ingresa tu nueva contraseña 
                        </p>
                        <input type="password" name="password" placeholder="Contraseña" required="" >
                        <input type="password" name="confirm_password" placeholder="Repetir Contraseña" required="">
                        <div class="send-button">
                            <input type="hidden" name="email" value="<?php echo $_REQUEST['email']; ?>"/>
                            <input type="button" name="resetSubmit" onClick="comprobarClave()"" value="Restablecer contraseña">
                        </div>
                    </form>
                </div>
            </div>
        </body>
        <
    </html>
    <?php
} else {
    header("Location: https://arbol-loja.000webhostapp.com/");
}
?>
