import 'package:credit_cards_app/core/error/failure.dart';
import 'package:credit_cards_app/features/cards/domain/entities/credit_card.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class CardsRepository {
  Future<Either<Failure, List<CreditCard>>> getAllCards();

  Future<Either<Failure, CreditCard>> getCardById({required int id});

  Future<Either<Failure, CreditCard>> createNewCard({
    required String alias,
    required String nombrePropietario,
    required String numeroTarjeta,
    required String cvv,
    required String mesExpiracion,
    required String anioExpiracion,
  });

  Future<Either<Failure, CreditCard>> updateCardById({
    required int id,
    required String alias,
    required String nombrePropietario,
    required String numeroTarjeta,
    required String cvv,
    required String mesExpiracion,
    required String anioExpiracion,
  });

  Future<Either<Failure, void>> deleteCardById({required int id});
}
