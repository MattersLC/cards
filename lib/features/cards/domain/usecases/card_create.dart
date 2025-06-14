import 'package:credit_cards_app/core/error/failure.dart';
import 'package:credit_cards_app/core/usecase/usecase.dart';
import 'package:credit_cards_app/features/cards/domain/entities/credit_card.dart';
import 'package:credit_cards_app/features/cards/domain/repository/cards_repository.dart';
import 'package:fpdart/src/either.dart';

class CardCreate implements Usecase<CreditCard, CardCreateParams> {
  final CardsRepository cardsRepository;
  const CardCreate(this.cardsRepository);

  @override
  Future<Either<Failure, CreditCard>> call(CardCreateParams params) async {
    return await cardsRepository.createNewCard(
      alias: params.alias,
      nombrePropietario: params.nombrePropietario,
      numeroTarjeta: params.numeroTarjeta,
      cvv: params.cvv,
      mesExpiracion: params.mesExpiracion,
      anioExpiracion: params.anioExpiracion,
    );
  }
}

class CardCreateParams {
  final String alias;
  final String nombrePropietario;
  final String numeroTarjeta;
  final String cvv;
  final String mesExpiracion;
  final String anioExpiracion;

  CardCreateParams({
    required this.alias,
    required this.nombrePropietario,
    required this.numeroTarjeta,
    required this.cvv,
    required this.mesExpiracion,
    required this.anioExpiracion,
  });
}
