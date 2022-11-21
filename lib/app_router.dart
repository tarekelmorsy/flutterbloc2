import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterbloc/business_logic/characters_cubit.dart';
import 'package:flutterbloc/data/repository/character_repositry.dart';
import 'package:flutterbloc/prssentation/screens/characters_details_screen.dart';
import 'package:flutterbloc/prssentation/screens/characters_screen.dart';
import 'constants/strings.dart';
import 'data/models/Characters.dart';
import 'data/web_services/characters_web_services.dart';

class AppRouter {
  late CharacterRepository characterRepository;
  late CharactersCubit charactersCubit;

  AppRouter() {
    characterRepository = CharacterRepository(CharactersWebServices());
    charactersCubit = CharactersCubit(characterRepository);
  }

  Route? generateRouter(RouteSettings settings) {
    switch (settings.name) {
      case charactersScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
              create: (BuildContext context) => charactersCubit,
              child: CharactersScreen()),
        );
      case charactersDetailsScreen:
        final character = settings.arguments as Character;
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (BuildContext context) =>
                    CharactersCubit(characterRepository),
                child: CharactersDetailsScreen(
                  character: character,
                )));


    }
  }
}
