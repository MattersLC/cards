import 'package:credit_cards_app/core/common/widgets/loader.dart';
import 'package:credit_cards_app/core/theme/app_gradients.dart';
import 'package:credit_cards_app/core/utils/show_snackbar.dart';
import 'package:credit_cards_app/features/cards/presentation/bloc/cards_bloc.dart';
import 'package:credit_cards_app/features/cards/presentation/pages/add_new_card_page.dart';
import 'package:credit_cards_app/features/cards/presentation/pages/card_viewer_page.dart';
import 'package:credit_cards_app/features/cards/presentation/widgets/credit_card_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CardsPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const CardsPage());
  const CardsPage({super.key});

  @override
  State<CardsPage> createState() => _CardsPageState();
}

class _CardsPageState extends State<CardsPage> {
  @override
  void initState() {
    super.initState();
    context.read<CardsBloc>().add(CardsFetchAllCards());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CARTERA'),
        actions: [
          IconButton(
            icon: const Icon(CupertinoIcons.add_circled),
            onPressed: () => Navigator.push(context, AddNewCardPage.route()),
          ),
        ],
      ),
      body: BlocConsumer<CardsBloc, CardsState>(
        listener: (context, state) {
          if (state is CardsFailure) {
            showSnackBar(context, state.error);
          }
        },
        builder: (context, state) {
          if (state is CardsLoading) {
            return const Loader();
          }
          if (state is CardsDisplaySuccess) {
            if (state.cards.isEmpty) {
              return Center(child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Text('Da click en el botón + para comenzar a agregar tarjetas.', style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
              ),);
            }
            return ListView.builder(
              itemCount: state.cards.length,
              itemBuilder: (context, index) {
                final cardData = state.cards[index];
                final Gradient gradient =
                    AppGradients().cardGradients[index %
                        AppGradients().cardGradients.length];
                return CreditCardWidget(
                  card: cardData,
                  gradient: gradient,
                  onTap:
                      () => Navigator.push(
                        context,
                        CardViewerPage.route(cardData, gradient),
                      ),
                );
              },
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
