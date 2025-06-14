part of 'init_dependencies.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  // Bloc
  _initCards();

  // Database Helper
  serviceLocator.registerLazySingleton(() => DatabaseHelper.instance);
}

void _initCards() {
  serviceLocator
    // Data Source
    ..registerFactory<CardsLocalDataSource>(
      () => CardsLocalDataSourceImpl(
        databaseHelper: serviceLocator<DatabaseHelper>(),
      ),
    )
    // Repository
    ..registerFactory<CardsRepository>(
      () => CardsRepositoryImpl(serviceLocator<CardsLocalDataSource>()),
    )
    // Use Cases
    ..registerFactory<GetAllCards>(
      () => GetAllCards(serviceLocator<CardsRepository>()),
    )
    ..registerFactory<GetCardById>(
      () => GetCardById(serviceLocator<CardsRepository>()),
    )
    ..registerFactory<CardCreate>(
      () => CardCreate(serviceLocator<CardsRepository>()),
    )
    ..registerFactory<UpdateCardById>(
      () => UpdateCardById(serviceLocator<CardsRepository>()),
    )
    ..registerFactory<DeleteCardById>(
      () => DeleteCardById(serviceLocator<CardsRepository>()),
    )
    // Bloc
    ..registerFactory<CardsBloc>(
      () => CardsBloc(
        getAllCards: serviceLocator<GetAllCards>(),
        getCardById: serviceLocator<GetCardById>(),
        cardCreate: serviceLocator<CardCreate>(),
        updateCardById: serviceLocator<UpdateCardById>(),
        deleteCardById: serviceLocator<DeleteCardById>(),
      ),
    );
}
