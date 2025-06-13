import 'package:credit_cards_app/features/cards/data/models/card_model.dart';

abstract interface class CardsLocalDataSource {
  Future<List<CardModel>> getAllCards();

  Future<CardModel> getCardById({
    required int id
  });

  Future<CardModel> createNewCard({
    required int id,
    required String alias,
    required String nombrePropietario,
    required String numeroTarjeta,
    required String cvv,
    required String mesExpiracion,
    required String anioExpiracion,
  });

  Future<CardModel> updateCardById({
    required int id
  });

  
}

class CardsLocalDataSourceImpl implements CardsLocalDataSource {
  @override
  Future<CardModel> createNewCard({required int id, required String alias, required String nombrePropietario, required String numeroTarjeta, required String cvv, required String mesExpiracion, required String anioExpiracion}) {
    // TODO: implement createNewCard
    throw UnimplementedError();
  }

  @override
  Future<List<CardModel>> getAllCards() {
    // TODO: implement getAllCards
    throw UnimplementedError();
  }

  @override
  Future<CardModel> getCardById({required int id}) {
    // TODO: implement getCardById
    throw UnimplementedError();
  }

  @override
  Future<CardModel> updateCardById({required int id}) {
    // TODO: implement updateCardById
    throw UnimplementedError();
  }
  
}
