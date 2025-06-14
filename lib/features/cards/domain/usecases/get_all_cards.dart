import 'package:credit_cards_app/core/error/failure.dart';
import 'package:credit_cards_app/core/usecase/usecase.dart';
import 'package:credit_cards_app/features/cards/domain/entities/credit_card.dart';
import 'package:credit_cards_app/features/cards/domain/repository/cards_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetAllCards implements Usecase<List<CreditCard>, NoParams> {
  final CardsRepository cardsRepository;
  const GetAllCards(this.cardsRepository);

  @override
  Future<Either<Failure, List<CreditCard>>> call(NoParams params) async {
    return await cardsRepository.getAllCards();
  }
}
