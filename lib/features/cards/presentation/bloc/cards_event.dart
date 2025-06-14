part of 'cards_bloc.dart';

@immutable
sealed class CardsEvent {}

final class CardsFetchAllCards extends CardsEvent {}
