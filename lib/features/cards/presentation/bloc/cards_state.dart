part of 'cards_bloc.dart';

@immutable
sealed class CardsState {}

final class CardsInitial extends CardsState {}

final class CardsLoading extends CardsState {}

final class CardsFailure extends CardsState {
  final String error;
  CardsFailure(this.error);
}

final class CardCreateSuccess extends CardsState {}

final class CardsDisplaySuccess extends CardsState {
  final List<CreditCard> cards;
  CardsDisplaySuccess(this.cards);
}
