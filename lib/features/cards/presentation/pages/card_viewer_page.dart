import 'package:credit_cards_app/core/theme/app_pallete.dart';
import 'package:credit_cards_app/features/cards/domain/entities/credit_card.dart';
import 'package:credit_cards_app/features/cards/presentation/pages/edit_card_page.dart';
import 'package:credit_cards_app/features/cards/presentation/widgets/credit_card_widget.dart';
import 'package:flutter/material.dart';

class CardViewerPage extends StatefulWidget {
  static route(CreditCard card, Gradient gradient) => MaterialPageRoute(
    builder: (context) => CardViewerPage(card: card, gradient: gradient),
  );
  final CreditCard card;
  final Gradient gradient;
  const CardViewerPage({super.key, required this.card, required this.gradient});

  @override
  State<CardViewerPage> createState() => _CardViewerPageState();
}

class _CardViewerPageState extends State<CardViewerPage> {
  bool _showDetails = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.card.alias,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => EditCardPage(card: widget.card),
                ),
              );
            },
          ),
        ],
      ),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: SizedBox(
                    width: 370,
                    height: 230,
                    child: CreditCardWidget(
                      card: widget.card,
                      gradient: widget.gradient,
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                // Unified Show Details Button
                AnimatedContainer(
                  duration: const Duration(milliseconds: 350),
                  curve: Curves.easeInOut,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    gradient:
                        _showDetails
                            ? const LinearGradient(
                              colors: [Color(0xFF232526), Color(0xFF414345)],
                            )
                            : const LinearGradient(
                              colors: [Color(0xFFe0eafc), Color(0xFFcfdef3)],
                            ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.08),
                        blurRadius: 16,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(18),
                      onTap: () {
                        setState(() {
                          _showDetails = !_showDetails;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 16,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              _showDetails
                                  ? Icons.visibility_off_rounded
                                  : Icons.visibility_rounded,
                              color:
                                  _showDetails ? Colors.white : Colors.black87,
                            ),
                            const SizedBox(width: 12),
                            AnimatedDefaultTextStyle(
                              duration: const Duration(milliseconds: 350),
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color:
                                    _showDetails
                                        ? Colors.white
                                        : Colors.black87,
                                letterSpacing: 1.2,
                              ),
                              child: Text(
                                _showDetails ? 'Hide Details' : 'Show Details',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 350),
                  child:
                      _showDetails
                          ? Container(
                            key: const ValueKey('details'),
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 20,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.black.withValues(alpha: 0.88),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.13),
                                  blurRadius: 16,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SelectableText(
                                  widget.card.numeroTarjeta,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 2.0,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 18),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'CVV:',
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    SelectableText(
                                      widget.card.cvv,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 8,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                          : const SizedBox.shrink(),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
