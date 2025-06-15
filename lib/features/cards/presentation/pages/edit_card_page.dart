import 'package:credit_cards_app/core/common/widgets/loader.dart';
import 'package:credit_cards_app/core/utils/show_snackbar.dart';
import 'package:credit_cards_app/features/cards/domain/entities/credit_card.dart';
import 'package:credit_cards_app/features/cards/presentation/bloc/cards_bloc.dart';
import 'package:credit_cards_app/features/cards/presentation/pages/card_viewer_page.dart';
import 'package:credit_cards_app/features/cards/presentation/pages/cards_page.dart';
import 'package:credit_cards_app/features/cards/presentation/widgets/credit_card_editor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:credit_cards_app/features/cards/presentation/utils/card_type_detector.dart';
import 'package:provider/provider.dart';

class EditCardPage extends StatefulWidget {
  final CreditCard card;
  final Gradient gradient;
  const EditCardPage({super.key, required this.card, required this.gradient});

  @override
  State<EditCardPage> createState() => _EditCardPageState();
}

class _EditCardPageState extends State<EditCardPage> {
  final formKey = GlobalKey<FormState>();
  final cardNumberKey = GlobalKey<FormFieldState<String>>();
  final cvvCodeKey = GlobalKey<FormFieldState<String>>();
  final expiryDateKey = GlobalKey<FormFieldState<String>>();
  final cardHolderKey = GlobalKey<FormFieldState<String>>();
  final aliasHolderKey = GlobalKey<FormFieldState<String>>();

  late TextEditingController aliasController;
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  String cardType = '';
  bool isCvvFocused = false;

  @override
  void initState() {
    super.initState();
    aliasController = TextEditingController(text: widget.card.alias);
    cardNumber = widget.card.numeroTarjeta;
    expiryDate = '${widget.card.mesExpiracion}/${widget.card.anioExpiracion}';
    cardHolderName = widget.card.nombrePropietario;
    cvvCode = widget.card.cvv;
    cardType = widget.card.tipo;
  }

  @override
  void dispose() {
    aliasController.dispose();
    super.dispose();
  }

  void saveChanges() {
    if (formKey.currentState!.validate()) {
      final expParts = expiryDate.split('/');
      final mesExpiracion = expParts.isNotEmpty ? expParts[0].trim() : '';
      final anioExpiracion = expParts.length > 1 ? expParts[1].trim() : '';
      final tipo = CardTypeDetector.detectType(cardNumber);

      context.read<CardsBloc>().add(
        CardsUpdateCard(
          id: widget.card.id,
          alias: aliasController.text.trim(),
          numeroTarjeta: cardNumber,
          mesExpiracion: mesExpiracion,
          anioExpiracion: anioExpiracion,
          nombrePropietario: cardHolderName,
          cvv: cvvCode,
          tipo: tipo,
        ),
      );

      // Mostrar un mensaje de éxito
      /*ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cambios guardados exitosamente')),
      );

      // Navegar hacia atrás para regresar a la pantalla anterior
      Navigator.pop(context);*/
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('EDITAR TARJETA')),
      body: BlocConsumer<CardsBloc, CardsState>(
        listener: (context, state) {
          if (state is CardsFailure) {
            showSnackBar(context, state.error);
          } else if (state is CardUpdateSuccess) {
            Navigator.pushAndRemoveUntil(
              context,
              CardsPage.route(),
              (route) => false,
            );
          }
        },
        builder: (context, state) {
          if (state is CardsLoading) {
            return const Loader();
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 700),
                    curve: Curves.easeInOut,
                    child: CreditCardWidget(
                      cardNumber: cardNumber,
                      expiryDate: expiryDate,
                      cardHolderName: cardHolderName,
                      cvvCode: cvvCode,
                      showBackView: isCvvFocused,
                      obscureCardNumber: false,
                      obscureCardCvv: false,
                      isHolderNameVisible: true,
                      cardBgColor: Colors.black87,
                      glassmorphismConfig: Glassmorphism(
                        blurX: 0.0,
                        blurY: 0.0,
                        gradient: widget.gradient,
                      ),
                      enableFloatingCard: true,
                      floatingConfig: FloatingConfig(
                        isGlareEnabled: true,
                        isShadowEnabled: true,
                        shadowConfig: FloatingShadowConfig(
                          offset: Offset(10, 10),
                          color: Colors.black87.withValues(alpha: 0.5),
                          blurRadius: 15,
                        ),
                      ),
                      labelValidThru: 'VENCE\nFIN DE',
                      labelExpiredDate: 'MM/AA',
                      labelCardHolder: 'NOMBRE DEL PROPIETARIO',
                      isSwipeGestureEnabled: true,
                      animationDuration: const Duration(milliseconds: 1000),
                      onCreditCardWidgetChange: (_) {},
                    ),
                  ),
                  const SizedBox(height: 16),
                  CreditCardForm(
                    formKey: formKey,
                    cardNumber: cardNumber,
                    expiryDate: expiryDate,
                    cardHolderName: cardHolderName,
                    cvvCode: cvvCode,
                    cardNumberKey: cardNumberKey,
                    cvvCodeKey: cvvCodeKey,
                    expiryDateKey: expiryDateKey,
                    cardHolderKey: cardHolderKey,
                    onCreditCardModelChange: (CreditCardModel data) {
                      setState(() {
                        cardNumber = data.cardNumber;
                        expiryDate = data.expiryDate;
                        cardHolderName = data.cardHolderName;
                        if (data.cvvCode.length > 3) {
                          data.cvvCode = data.cvvCode.substring(0, 3);
                        } else {
                          cvvCode = data.cvvCode;
                        }
                        isCvvFocused = data.isCvvFocused;
                        cardType = CardTypeDetector.detectType(data.cardNumber);
                      });
                    },
                    obscureCvv: true,
                    obscureNumber: false,
                    isCardNumberVisible: true,
                    isExpiryDateVisible: true,
                    enableCvv: true,
                    cvvValidationMessage: 'Por favor ingresa un CVV válido',
                    dateValidationMessage: 'Por favor ingresa una fecha válida',
                    numberValidationMessage:
                        'Por favor ingresa un número válido',
                    isCardHolderNameUpperCase: true,
                    onFormComplete: () {},
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    disableCardNumberAutoFillHints: false,
                    inputConfiguration: const InputConfiguration(
                      cardNumberDecoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Número de tarjeta',
                        hintText: 'XXXX XXXX XXXX XXXX',
                      ),
                      expiryDateDecoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Fecha de expiración',
                        hintText: 'MM/AA',
                      ),
                      cvvCodeDecoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'CVV',
                        hintText: 'CVV',
                      ),
                      cardHolderDecoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Nombre del propietario',
                      ),
                    ),
                    cardNumberValidator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingresa un número de tarjeta válido';
                      }
                      if (value.replaceAll(' ', '').length != 16) {
                        return 'El número de tarjeta debe tener 16 dígitos';
                      }
                      return null;
                    },
                    cardHolderValidator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingresa el nombre del propietario';
                      }
                      return null;
                    },
                    cvvValidator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingresa un CVV válido';
                      }
                      if (value.length != 3) {
                        return 'El CVV debe tener exactamente 3 dígitos';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: CreditCardEditor(
                      controller: aliasController,
                      hintText: "Alias de la tarjeta",
                    ),
                  ),
                  const SizedBox(height: 32),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 350),
                      curve: Curves.easeInOut,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        gradient: const LinearGradient(
                          colors: [Color(0xFF232526), Color(0xFF414345)],
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
                          onTap: saveChanges,
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 32,
                              vertical: 18,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Guardar cambios',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    letterSpacing: 1.2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
