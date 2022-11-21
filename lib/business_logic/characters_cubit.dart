import 'package:bloc/bloc.dart';
import 'package:flutterbloc/data/models/Quotes.dart';
import 'package:meta/meta.dart';

import '../data/models/Characters.dart';
import '../data/repository/character_repositry.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final CharacterRepository characterRepository;
  CharactersCubit(this.characterRepository) : super(CharactersInitial());
    List<Character> characters=[];

  List<Character> getAllCharacters() {
    characterRepository.getAllCharacters().then((characters){
      emit(CharactersLoaded(characters));
      this.characters=characters;
    });
    return characters;
  }
 void getQuotes(String name) {
    characterRepository.getQuotes(name).then((quote){
      emit(QuotesLoaded(quote));
    });

  }

}
