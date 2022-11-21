import 'package:flutterbloc/data/models/Characters.dart';
import 'package:flutterbloc/data/models/Quotes.dart';
import 'package:flutterbloc/data/web_services/characters_web_services.dart';

class CharacterRepository{
  final CharactersWebServices charactersWebServices;

  CharacterRepository(this.charactersWebServices);
  Future<List<Character>> getAllCharacters() async {
   final  characters=await charactersWebServices.getAllCharacters();
   return characters.map((character) => Character.fromJson(character)).toList();
  }

  Future<List<Quote>> getQuotes(String name) async {
   final  quotes=await charactersWebServices.getQuotes(name);
   return quotes.map((quote) => Quote.fromJson(quote)).toList();
  }

}