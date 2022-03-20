class AccionesRecomendadas {
  int? id_ar;
  String? descripcion_ar;
  String? estado_ar;

  AccionesRecomendadas(this.id_ar, this.descripcion_ar, this.estado_ar);

  int? get getId_ar {
    return id_ar;
  }

  void setId_ar(int id) {
    id_ar = id;
  }

  String? get getDescripcion_ar {
    return descripcion_ar;
  }

  void setDescripcion_ar(String descripcion) {
    descripcion_ar = descripcion;
  }

  String? get getEstado_ar {
    return estado_ar;
  }

  void setEstado_ar(String estado) {
    estado_ar = estado;
  }
}
