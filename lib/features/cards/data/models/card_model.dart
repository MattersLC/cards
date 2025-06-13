import 'package:credit_cards_app/features/cards/domain/entities/card.dart';

class CardModel extends Card {
  CardModel({
    required super.id,
    required super.alias,
    required super.nombrePropietario,
    required super.numeroTarjeta,
    required super.cvv,
    required super.mesExpiracion,
    required super.anioExpiracion,
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
    );
  }
}
