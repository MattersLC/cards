import 'package:credit_cards_app/core/error/failure.dart';
import 'package:credit_cards_app/features/cards/data/datasources/cards_local_data_source.dart';
import 'package:credit_cards_app/features/cards/domain/entities/credit_card.dart';
import 'package:credit_cards_app/features/cards/domain/repository/cards_repository.dart';
import 'package:fpdart/src/either.dart';

class CardsRepositoryImpl implements CardsRepository {
  final CardsLocalDataSource cardsLocalDataSource;
  CardsRepositoryImpl(this.cardsLocalDataSource);

  @override
  Future<Either<Failure, List<CreditCard>>> getAllCards() async {
    try {
      final cards = await cardsLocalDataSource.getAllCards();
      return Right(cards);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, CreditCard>> createNewCard({
    required String alias,
    required String nombrePropietario,
    required String numeroTarjeta,
    required String cvv,
    required String mesExpiracion,
    required String anioExpiracion,
    required String tipo,
  }) async {
    try {
      final card = await cardsLocalDataSource.createNewCard(
        alias: alias,
        nombrePropietario: nombrePropietario,
        numeroTarjeta: numeroTarjeta,
        cvv: cvv,
        mesExpiracion: mesExpiracion,
        anioExpiracion: anioExpiracion,
        tipo: tipo,
      );
      return Right(card);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, CreditCard>> getCardById({required int id}) async {
    try {
      final card = await cardsLocalDataSource.getCardById(id: id);
      return Right(card);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, CreditCard>> updateCardById({
    required int id,
    required String alias,
    required String nombrePropietario,
    required String numeroTarjeta,
    required String cvv,
    required String mesExpiracion,
    required String anioExpiracion,
    required String tipo,
  }) async {
    try {
      final card = await cardsLocalDataSource.updateCardById(
        id: id,
        alias: alias,
        nombrePropietario: nombrePropietario,
        numeroTarjeta: numeroTarjeta,
        cvv: cvv,
        mesExpiracion: mesExpiracion,
        anioExpiracion: anioExpiracion,
        tipo: tipo,
      );
      return Right(card);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteCardById({required int id}) async {
    try {
      await cardsLocalDataSource.deleteCardById(id: id);
      return const Right(null);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
