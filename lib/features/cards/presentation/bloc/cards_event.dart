part of 'cards_bloc.dart';

@immutable
sealed class CardsEvent {}

final class CreateCard extends CardsEvent {
  final String alias;
  final String nombrePropietario;
  final String numeroTarjeta;
  final String cvv;
  final String mesExpiracion;
  final String anioExpiracion;
  final String tipo;

  CreateCard({
    required this.alias,
    required this.nombrePropietario,
    required this.numeroTarjeta,
    required this.cvv,
    required this.mesExpiracion,
    required this.anioExpiracion,
    required this.tipo,
  });
}

final class CardsFetchAllCards extends CardsEvent {}

final class CardsUpdateCard extends CardsEvent {
  final int id;
  final String alias;
  final String nombrePropietario;
  final String numeroTarjeta;
  final String cvv;
  final String mesExpiracion;
  final String anioExpiracion;
  final String tipo;

  CardsUpdateCard({
    required this.id,
    required this.alias,
    required this.nombrePropietario,
    required this.numeroTarjeta,
    required this.cvv,
    required this.mesExpiracion,
    required this.anioExpiracion,
    required this.tipo,
  });
}

final class CardsDeleteCard extends CardsEvent {
  final int id;
  CardsDeleteCard(this.id);
}
