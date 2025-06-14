import 'package:credit_cards_app/features/cards/domain/entities/credit_card.dart';

class CardModel extends CreditCard {
  CardModel({
    required super.id,
    required super.alias,
    required super.nombrePropietario,
    required super.numeroTarjeta,
    required super.cvv,
    required super.mesExpiracion,
    required super.anioExpiracion,
    required super.tipo,
  });

  factory CardModel.fromJson(Map<String, dynamic> map) {
    return CardModel(
      id: map['id'] ?? 0,
      alias: map['alias'] ?? '',
      nombrePropietario: map['nombrePropietario'] ?? '',
      numeroTarjeta: map['numeroTarjeta'] ?? '',
      cvv: map['cvv'] ?? '',
      mesExpiracion: map['mesExpiracion'] ?? '',
      anioExpiracion: map['anioExpiracion'] ?? '',
      tipo: map['tipo'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'alias': alias,
      'nombrePropietario': nombrePropietario,
      'numeroTarjeta': numeroTarjeta,
      'cvv': cvv,
      'mesExpiracion': mesExpiracion,
      'anioExpiracion': anioExpiracion,
      'tipo': tipo,
    };
  }
}
