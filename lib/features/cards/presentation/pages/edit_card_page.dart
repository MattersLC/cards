import 'package:credit_cards_app/features/cards/domain/entities/credit_card.dart';
import 'package:flutter/material.dart';

class EditCardPage extends StatefulWidget {
  final CreditCard card;
  const EditCardPage({super.key, required this.card});

  @override
  State<EditCardPage> createState() => _EditCardPageState();
}

class _EditCardPageState extends State<EditCardPage> {
  late TextEditingController aliasController;
  late TextEditingController ownerController;
  late TextEditingController cardNumberController;
  late TextEditingController cvvController;
  late TextEditingController monthController;
  late TextEditingController yearController;

  @override
  void initState() {
    super.initState();
    aliasController = TextEditingController(text: widget.card.alias);
    ownerController = TextEditingController(
      text: widget.card.nombrePropietario,
    );
    cardNumberController = TextEditingController(
      text: widget.card.numeroTarjeta,
    );
    cvvController = TextEditingController(text: widget.card.cvv);
    monthController = TextEditingController(text: widget.card.mesExpiracion);
    yearController = TextEditingController(text: widget.card.anioExpiracion);
  }

  @override
  void dispose() {
    aliasController.dispose();
    ownerController.dispose();
    cardNumberController.dispose();
    cvvController.dispose();
    monthController.dispose();
    yearController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Editar Tarjeta')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: aliasController,
              decoration: const InputDecoration(
                labelText: 'Alias de la tarjeta *',
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: ownerController,
              decoration: const InputDecoration(
                labelText: 'Nombre del propietario *',
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: cardNumberController,
              decoration: const InputDecoration(labelText: 'Número de tarjeta'),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: cvvController,
              decoration: const InputDecoration(labelText: 'CVV'),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: monthController,
                    decoration: const InputDecoration(labelText: 'Mes'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    controller: yearController,
                    decoration: const InputDecoration(labelText: 'Año'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // TODO: Dispatch update event
              },
              child: const Text('Guardar cambios'),
            ),
          ],
        ),
      ),
    );
  }
}
