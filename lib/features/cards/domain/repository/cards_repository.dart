import 'package:credit_cards_app/core/error/failure.dart';
import 'package:credit_cards_app/features/cards/domain/entities/card.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class CardsRepository {
  Future<Either<Failure, Card>> getAllCards();
}