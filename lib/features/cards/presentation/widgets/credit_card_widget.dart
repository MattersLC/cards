import 'package:credit_cards_app/features/cards/domain/entities/credit_card.dart';
import 'package:flutter/material.dart';

class CreditCardWidget extends StatelessWidget {
  final CreditCard card;
  final Gradient gradient;
  final Function()? onTap;
  const CreditCardWidget({
    super.key,
    required this.card,
    this.onTap,
    required this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //onTap: () => Navigator.push(context, CardViewerPage.route(card, gradient)),
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: gradient,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(50),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Stack(
            children: [
              // Contenido de la tarjeta
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    card.alias,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                  Text(
                    '**** **** **** *${card.numeroTarjeta.substring(card.numeroTarjeta.length - 3)}',
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                      letterSpacing: 2,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        card.nombrePropietario.toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text(
                            'VIGENCIA',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1.1,
                            ),
                          ),
                          Text(
                            '${card.mesExpiracion}/${card.anioExpiracion}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              // Logo de la tarjeta
              Positioned(
                top: 0,
                right: 0,
                child: Builder(
                  builder: (context) {
                    if (card.tipo.toUpperCase() == 'VISA') {
                      return Image.asset('assets/VISA-Logo.png', height: 36);
                    } else if (card.tipo.toUpperCase() == 'MASTERCARD') {
                      return Image.asset(
                        'assets/MASTERCARD-Logo.png',
                        height: 36,
                      );
                    } else if (card.tipo.toUpperCase() == 'AMEX') {
                      return Image.asset('assets/AMEX-Logo.png', height: 56);
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
