import 'package:credit_cards_app/core/common/widgets/loader.dart';
import 'package:credit_cards_app/core/utils/show_snackbar.dart';
import 'package:credit_cards_app/features/cards/presentation/bloc/cards_bloc.dart';
import 'package:credit_cards_app/features/cards/presentation/pages/cards_page.dart';
import 'package:credit_cards_app/features/cards/presentation/widgets/credit_card_editor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:credit_cards_app/features/cards/presentation/utils/card_type_detector.dart';

class AddNewCardPage extends StatefulWidget {
  static route() =>
      MaterialPageRoute(builder: (context) => const AddNewCardPage());
  const AddNewCardPage({super.key});

  @override
  State<AddNewCardPage> createState() => _AddNewCardPageState();
}

class _AddNewCardPageState extends State<AddNewCardPage> {
  final formKey = GlobalKey<FormState>();
  final aliasController = TextEditingController();
  final cardNumberKey = GlobalKey<FormFieldState<String>>();
  final cvvCodeKey = GlobalKey<FormFieldState<String>>();
  final expiryDateKey = GlobalKey<FormFieldState<String>>();
  final cardHolderKey = GlobalKey<FormFieldState<String>>();
  final aliasHolderKey = GlobalKey<FormFieldState<String>>();
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  String cardType = '';
  bool isCvvFocused = false;

  void uploadCard() {
    if (formKey.currentState!.validate()) {
      final expParts = expiryDate.split('/');
      final mesExpiracion = expParts.isNotEmpty ? expParts[0].trim() : '';
      final anioExpiracion = expParts.length > 1 ? expParts[1].trim() : '';
      final tipo = CardTypeDetector.detectType(cardNumber);
      context.read<CardsBloc>().add(
        CreateCard(
          alias: aliasController.text.trim(),
          nombrePropietario: cardHolderName.trim(),
          numeroTarjeta: cardNumber.trim(),
          cvv: cvvCode.trim(),
          mesExpiracion: mesExpiracion,
          anioExpiracion: anioExpiracion,
          tipo: tipo,
        ),
      );
    }
  }

  @override
  void dispose() {
    aliasController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        /*actions: [
          IconButton(
            onPressed: uploadCard,
            icon: const Icon(Icons.done_rounded),
          ),
        ],*/
        title: const Text('AGREGAR NUEVA TARJETA'),
      ),
      body: BlocConsumer<CardsBloc, CardsState>(
        listener: (context, state) {
          if (state is CardsFailure) {
            showSnackBar(context, state.error);
          } else if (state is CardCreateSuccess) {
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
                  CreditCardWidget(
                    cardNumber: cardNumber,
                    expiryDate: expiryDate,
                    cardHolderName: cardHolderName,
                    cvvCode: cvvCode,
                    showBackView: isCvvFocused,
                    obscureCardNumber: false,
                    obscureCardCvv: false,
                    isHolderNameVisible: true,
                    cardBgColor: Colors.black87,
                    glassmorphismConfig: Glassmorphism.defaultConfig(),
                    enableFloatingCard: true,
                    floatingConfig: FloatingConfig(
                      isGlareEnabled: true,
                      isShadowEnabled: true,
                      shadowConfig: FloatingShadowConfig(),
                    ),
                    labelValidThru: 'VENCE\nFIN DE',
                    labelExpiredDate: 'MM/AA',
                    labelCardHolder: 'NOMBRE DEL PROPIETARIO',
                    isSwipeGestureEnabled: true,
                    animationDuration: Duration(milliseconds: 1000),
                    onCreditCardWidgetChange: (_) {},
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
                    //isHolderNameVisible: true,
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

                  const SizedBox(height: 16),
                  ElevatedButton(onPressed: uploadCard, child: Text('Guardar')),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
