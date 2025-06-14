import 'package:credit_cards_app/core/error/failure.dart';
import 'package:credit_cards_app/core/usecase/usecase.dart';
import 'package:credit_cards_app/features/cards/domain/entities/credit_card.dart';
import 'package:credit_cards_app/features/cards/domain/repository/cards_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetCardByIdParams {
  final int id;
  GetCardByIdParams({required this.id});
}

class GetCardById implements Usecase<CreditCard, GetCardByIdParams> {
  final CardsRepository cardsRepository;
  const GetCardById(this.cardsRepository);

  @override
  Future<Either<Failure, CreditCard>> call(GetCardByIdParams params) async {
    return await cardsRepository.getCardById(id: params.id);
  }
}
