import 'package:credit_cards_app/core/error/failure.dart';
import 'package:credit_cards_app/core/usecase/usecase.dart';
import 'package:credit_cards_app/features/cards/domain/entities/credit_card.dart';
import 'package:credit_cards_app/features/cards/domain/repository/cards_repository.dart';
import 'package:fpdart/fpdart.dart';

class UpdateCardByIdParams {
  final int id;
  final String alias;
  final String nombrePropietario;
  final String numeroTarjeta;
  final String cvv;
  final String mesExpiracion;
  final String anioExpiracion;

  UpdateCardByIdParams({
    required this.id,
    required this.alias,
    required this.nombrePropietario,
    required this.numeroTarjeta,
    required this.cvv,
    required this.mesExpiracion,
    required this.anioExpiracion,
  });
}

class UpdateCardById implements Usecase<CreditCard, UpdateCardByIdParams> {
  final CardsRepository cardsRepository;
  const UpdateCardById(this.cardsRepository);

  @override
  Future<Either<Failure, CreditCard>> call(UpdateCardByIdParams params) async {
    return await cardsRepository.updateCardById(
      id: params.id,
      alias: params.alias,
      nombrePropietario: params.nombrePropietario,
      numeroTarjeta: params.numeroTarjeta,
      cvv: params.cvv,
      mesExpiracion: params.mesExpiracion,
      anioExpiracion: params.anioExpiracion,
    );
  }
}
