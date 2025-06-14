import 'package:credit_cards_app/core/database/database_helper.dart';
import 'package:credit_cards_app/features/cards/data/models/card_model.dart';
import 'package:sqflite/sqflite.dart';

abstract interface class CardsLocalDataSource {
  Future<List<CardModel>> getAllCards();

  Future<CardModel> getCardById({required int id});

  Future<CardModel> createNewCard({
    required String alias,
    required String nombrePropietario,
    required String numeroTarjeta,
    required String cvv,
    required String mesExpiracion,
    required String anioExpiracion,
  });

  Future<CardModel> updateCardById({
    required int id,
    required String alias,
    required String nombrePropietario,
    required String numeroTarjeta,
    required String cvv,
    required String mesExpiracion,
    required String anioExpiracion,
  });

  Future<void> deleteCardById({required int id});
}

class CardsLocalDataSourceImpl implements CardsLocalDataSource {
  final DatabaseHelper dbHelper;
  CardsLocalDataSourceImpl({DatabaseHelper? databaseHelper})
    : dbHelper = databaseHelper ?? DatabaseHelper.instance;

  @override
  Future<CardModel> createNewCard({
    required String alias,
    required String nombrePropietario,
    required String numeroTarjeta,
    required String cvv,
    required String mesExpiracion,
    required String anioExpiracion,
  }) async {
    final db = await dbHelper.database;
    final id = await db.insert(DatabaseHelper.cardsTable, {
      'alias': alias,
      'nombrePropietario': nombrePropietario,
      'numeroTarjeta': numeroTarjeta,
      'cvv': cvv,
      'mesExpiracion': mesExpiracion,
      'anioExpiracion': anioExpiracion,
    });
    return CardModel(
      id: id,
      alias: alias,
      nombrePropietario: nombrePropietario,
      numeroTarjeta: numeroTarjeta,
      cvv: cvv,
      mesExpiracion: mesExpiracion,
      anioExpiracion: anioExpiracion,
    );
  }

  @override
  Future<List<CardModel>> getAllCards() async {
    final db = await dbHelper.database;
    final result = await db.query(DatabaseHelper.cardsTable);
    return result.map((map) => CardModel.fromJson(map)).toList();
  }

  @override
  Future<CardModel> getCardById({required int id}) async {
    final db = await dbHelper.database;
    final result = await db.query(
      DatabaseHelper.cardsTable,
      where: 'id = ?',
      whereArgs: [id],
    );
    if (result.isNotEmpty) {
      return CardModel.fromJson(result.first);
    } else {
      throw Exception('Card not found');
    }
  }

  @override
  Future<CardModel> updateCardById({
    required int id,
    String? alias,
    String? nombrePropietario,
    String? numeroTarjeta,
    String? cvv,
    String? mesExpiracion,
    String? anioExpiracion,
  }) async {
    final db = await dbHelper.database;
    final card = await getCardById(id: id);
    final updated = {
      'alias': alias ?? card.alias,
      'nombrePropietario': nombrePropietario ?? card.nombrePropietario,
      'numeroTarjeta': numeroTarjeta ?? card.numeroTarjeta,
      'cvv': cvv ?? card.cvv,
      'mesExpiracion': mesExpiracion ?? card.mesExpiracion,
      'anioExpiracion': anioExpiracion ?? card.anioExpiracion,
    };
    await db.update(
      DatabaseHelper.cardsTable,
      updated,
      where: 'id = ?',
      whereArgs: [id],
    );
    return getCardById(id: id);
  }

  @override
  Future<void> deleteCardById({required int id}) async {
    final db = await dbHelper.database;
    final deleted = await db.delete(
      DatabaseHelper.cardsTable,
      where: 'id = ?',
      whereArgs: [id],
    );
    if (deleted == 0) {
      throw Exception('Card not found');
    }
  }
}
