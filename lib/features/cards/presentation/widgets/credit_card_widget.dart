import 'package:credit_cards_app/features/cards/domain/entities/credit_card.dart';
import 'package:flutter/material.dart';

class CreditCardWidget extends StatelessWidget {
  final CreditCard card;
  final Color color;
  const CreditCardWidget({super.key, required this.card, required this.color});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: color,
        child: Text(
          card.alias.substring(0, 1).toUpperCase(),
          style: const TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
      title: Text(card.alias),
      subtitle: Text('Owner: ${card.nombrePropietario}'),
      trailing: Text('**** **** **** ${card.numeroTarjeta.substring(12)}'),
    );
  }
}
