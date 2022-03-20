class EstadoFitosanitario {
  int? id_ef;
  String? descripcion_ef;
  String? estado_ef;

  EstadoFitosanitario(this.id_ef, this.descripcion_ef, this.estado_ef);

  int? get getId_ef {
    return id_ef;
  }

  void setId_ef(int id) {
    id_ef = id;
  }

  String? get getDescripcion_ef {
    return descripcion_ef;
  }

  void setDescripcion_ef(String descripcion) {
    descripcion_ef = descripcion;
  }

  String? get getEstado_ef {
    return estado_ef;
  }

  void setEstado_ef(String estado) {
    estado_ef = estado;
  }
}
