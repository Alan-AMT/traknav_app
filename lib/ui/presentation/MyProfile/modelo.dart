class Usuario {
  String? nombre;
  String? correo;
  String? ubicacion;
  String? telefono;

  Usuario(this.nombre, this.correo, this.ubicacion, this.telefono);

  String nombreStr() {
    return "$nombre";
  }

  String correoStr() {
    return "$correo";
  }

  String ubicacionStr() {
    return "$ubicacion";
  }

  String telefonoStr() {
    return "$telefono";
  }
}
