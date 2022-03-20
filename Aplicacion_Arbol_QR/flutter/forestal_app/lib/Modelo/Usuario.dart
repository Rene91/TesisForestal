class Usuario {
  int? id_u;
  String? nombre_u;
  String? apellido_u;
  String? email_u;
  String? contrasena_u;
  String? contrasenaConfirmar_u;
  String? fecha_nacimiento_u;
  String? nivel_u;
  String? estado_u;
  String? foto_u;

  Usuario(
      this.id_u,
      this.nombre_u,
      this.apellido_u,
      this.email_u,
      this.contrasena_u,
      this.contrasenaConfirmar_u,
      this.fecha_nacimiento_u,
      this.nivel_u,
      this.estado_u,
      this.foto_u);

  //////////////////////////////////////////
  int? get getId_u {
    return id_u;
  }

  void setId_u(int id) {
    id_u = id;
  }

  //////////////////////////////////////////
  String? get getNombre_u {
    return nombre_u;
  }

  void srtNombre_u(String nombre) {
    nombre_u = nombre;
  }

  //////////////////////////////////////////
  void srtApellido_u(String apellido) {
    apellido_u = apellido;
  }

  String? get getApellido_u {
    return apellido_u;
  }

  //////////////////////////////////////////
  String? get getEmail_u {
    return email_u;
  }

  void setEmail_u(String email) {
    email_u = email;
  }

  //////////////////////////////////////////
  String? get getContrasena_u {
    return contrasena_u;
  }

  void setContrasena_u(String contrasena) {
    contrasena_u = contrasena;
  }

  //////////////////////////////////////////
  String? get getContrasenaConfirmar_u {
    return contrasenaConfirmar_u;
  }

  void setContrasenaConfirmar_u(String Confirmar_u) {
    contrasenaConfirmar_u = Confirmar_u;
  }

  //////////////////////////////////////////
  String? get getFechaNacimiento_u {
    return fecha_nacimiento_u;
  }

  void setFechaNacimiento_u(String nacimiento) {
    fecha_nacimiento_u = nacimiento;
  }

  //////////////////////////////////////////
  String? get getNivel_u {
    return nivel_u;
  }

  void setNivel_u(String nivel) {
    nivel_u = nivel;
  }

  //////////////////////////////////////////
  String? get getEstado_u {
    return estado_u;
  }

  void setEstado_u(String estado) {
    estado_u = estado;
  }

  //////////////////////////////////////////
  String? get getFoto_u {
    return foto_u;
  }

  void setFoto_u(String foto) {
    foto_u = foto;
  }
}
