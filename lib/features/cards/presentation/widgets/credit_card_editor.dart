import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CreditCardEditor extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  const CreditCardEditor({
    super.key,
    required this.controller,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: hintText, hintText: hintText),
      maxLines: null,
      textCapitalization: TextCapitalization.characters,
      inputFormatters: [UpperCaseTextFormatter()],
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor ingresa el campo $hintText';
        }
        return null;
      },
    );
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return newValue.copyWith(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
