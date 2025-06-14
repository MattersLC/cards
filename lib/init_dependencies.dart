import 'package:credit_cards_app/core/database/database_helper.dart';
import 'package:credit_cards_app/features/cards/data/datasources/cards_local_data_source.dart';
import 'package:credit_cards_app/features/cards/data/repositories/cards_repository_impl.dart';
import 'package:credit_cards_app/features/cards/domain/repository/cards_repository.dart';
import 'package:credit_cards_app/features/cards/domain/usecases/card_create.dart';
import 'package:credit_cards_app/features/cards/domain/usecases/delete_card_by_id.dart';
import 'package:credit_cards_app/features/cards/domain/usecases/get_all_cards.dart';
import 'package:credit_cards_app/features/cards/domain/usecases/get_card_by_id.dart';
import 'package:credit_cards_app/features/cards/domain/usecases/update_card_by_id.dart';
import 'package:credit_cards_app/features/cards/presentation/bloc/cards_bloc.dart';
import 'package:get_it/get_it.dart';

part 'init_dependencies.main.dart';
