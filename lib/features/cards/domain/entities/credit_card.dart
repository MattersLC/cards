class CreditCard {
  final int id;
  final String alias;
  final String nombrePropietario;
  final String numeroTarjeta;
  final String cvv;
  final String mesExpiracion;
  final String anioExpiracion;

  CreditCard({
    required this.id,
    required this.alias,
    required this.nombrePropietario,
    required this.numeroTarjeta,
    required this.cvv,
    required this.mesExpiracion,
    required this.anioExpiracion,
  });
}
