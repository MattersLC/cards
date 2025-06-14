import 'package:credit_cards_app/core/error/failure.dart';
import 'package:credit_cards_app/core/usecase/usecase.dart';
import 'package:credit_cards_app/features/cards/domain/repository/cards_repository.dart';
import 'package:fpdart/fpdart.dart';

class DeleteCardByIdParams {
  final int id;
  DeleteCardByIdParams({required this.id});
}

class DeleteCardById implements Usecase<void, DeleteCardByIdParams> {
  final CardsRepository cardsRepository;
  const DeleteCardById(this.cardsRepository);

  @override
  Future<Either<Failure, void>> call(DeleteCardByIdParams params) async {
    return await cardsRepository.deleteCardById(id: params.id);
  }
}
