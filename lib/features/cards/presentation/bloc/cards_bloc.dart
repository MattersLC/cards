import 'dart:io';
import 'package:credit_cards_app/core/usecase/usecase.dart';
import 'package:credit_cards_app/features/cards/domain/entities/credit_card.dart';
import 'package:credit_cards_app/features/cards/domain/usecases/card_create.dart';
import 'package:credit_cards_app/features/cards/domain/usecases/delete_card_by_id.dart';
import 'package:credit_cards_app/features/cards/domain/usecases/get_all_cards.dart';
import 'package:credit_cards_app/features/cards/domain/usecases/get_card_by_id.dart';
import 'package:credit_cards_app/features/cards/domain/usecases/update_card_by_id.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'cards_event.dart';
part 'cards_state.dart';

class CardsBloc extends Bloc<CardsEvent, CardsState> {
  final GetAllCards _getAllCards;
  final GetCardById _getCardById;
  final CardCreate _cardCreate;
  final UpdateCardById _updateCardById;
  final DeleteCardById _deleteCardById;
  CardsBloc({
    required GetAllCards getAllCards,
    required GetCardById getCardById,
    required CardCreate cardCreate,
    required UpdateCardById updateCardById,
    required DeleteCardById deleteCardById,
  }) : _getAllCards = getAllCards,
       _getCardById = getCardById,
       _cardCreate = cardCreate,
       _updateCardById = updateCardById,
       _deleteCardById = deleteCardById,
       super(CardsInitial()) {
    on<CardsEvent>((event, emit) => emit(CardsLoading()));
    on<CreateCard>(_onCardCreate);
    on<CardsFetchAllCards>(_onFetchAllCards);
  }

  void _onFetchAllCards(
    CardsFetchAllCards event,
    Emitter<CardsState> emit,
  ) async {
    //emit(CardsLoading());
    final result = await _getAllCards(NoParams());
    result.fold(
      (failure) => emit(CardsFailure(failure.message)),
      (cards) => emit(CardsDisplaySuccess(cards)),
    );
  }

  Future<void> _onCardCreate(CreateCard event, Emitter<CardsState> emit) async {
    final result = await _cardCreate(
      CardCreateParams(
        alias: event.alias,
        nombrePropietario: event.nombrePropietario,
        numeroTarjeta: event.numeroTarjeta,
        cvv: event.cvv,
        mesExpiracion: event.mesExpiracion.toString(),
        anioExpiracion: event.anioExpiracion.toString(),
        tipo: event.tipo,
      ),
    );
    result.fold(
      (failure) => emit(CardsFailure(failure.message)),
      (card) => emit(CardCreateSuccess()),
    );
  }
}
