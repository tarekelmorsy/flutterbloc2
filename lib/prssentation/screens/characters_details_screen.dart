import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterbloc/business_logic/characters_cubit.dart';
import '../../constants/myColors.dart';
import '../../data/models/Characters.dart';
import '../../data/models/Quotes.dart';

class CharactersDetailsScreen extends StatelessWidget {
  final Character character;

  const CharactersDetailsScreen({super.key, required this.character});

  Widget chechAreQuotesLoaded(CharactersState state) {
    if (state is QuotesLoaded) {
      return displayRandomQuotesOrEmptyState(state);
    } else {
      return showProgressInd();
    }
  }

  Widget displayRandomQuotesOrEmptyState(stat) {
    List<Quote> quotes = (stat).quotes;
    if (quotes.length != 0) {
      int randomIndex = Random().nextInt(quotes.length - 1);
      print(quotes[randomIndex].quote);
      return Center(
        child: DefaultTextStyle(
            textAlign: TextAlign.center,
            style: TextStyle(color: MyColors.myWhite, fontSize: 20, shadows: [
              Shadow(
                  blurRadius: 7, color: MyColors.myYellow, offset: Offset(0, 0))
            ]),
            child: AnimatedTextKit(
              repeatForever: true,
              animatedTexts: [
                FlickerAnimatedText(quotes[randomIndex].quote),

              ],
            )),
      );
    } else
      return Container();
  }
Widget showProgressInd(){
    return Center(
      child: CircularProgressIndicator(
        color: MyColors.myYellow,
      ),
    );
}
  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 600,
      pinned: true,
      stretch: true,
      backgroundColor: MyColors.myGrey,
      centerTitle: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          character.nickName,
          style: TextStyle(color: MyColors.myYellow),
        ),
        background: Hero(
          tag: character.charId,
          child: Image.network(
            character.image,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _characterInfo(String title, String value) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(children: [
        TextSpan(
          text: title,
          style: TextStyle(
              color: MyColors.myWhite,
              fontWeight: FontWeight.bold,
              fontSize: 18),
        ),
        TextSpan(
          text: value,
          style: TextStyle(color: MyColors.myWhite, fontSize: 16),
        )
      ]),
    );
  }

  Widget _buildDivider(double endIndent) {
    return Divider(
      color: MyColors.myYellow,
      height: 30,
      endIndent: endIndent,
      thickness: 2,
    );
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CharactersCubit>(context).getQuotes(character.name);

    return Scaffold(
      backgroundColor: MyColors.myGrey,
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(),
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                margin: EdgeInsets.fromLTRB(14, 14, 14, 0),
                padding: EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _characterInfo('Job :', character.jobs.join(" / ")),
                    _buildDivider(290),
                    _characterInfo(
                        'Appeared in  :', character.categoryForTwoSeries),
                    _buildDivider(210),
                    _characterInfo(
                        'Seasons :', character.appearanceOfSeasons.join(" / ")),
                    _buildDivider(240),
                    _characterInfo('Status :', character.statusIfDeadOrAlive),
                    _buildDivider(240),
                    character.betterCallSaulAppearance.isEmpty
                        ? Container()
                        : _characterInfo('Better Call Saul seasons :',
                            character.betterCallSaulAppearance.join(" / ")),
                    character.betterCallSaulAppearance.isEmpty
                        ? Container()
                        : _buildDivider(120),
                    _characterInfo('Actor/Actress :', character.acotrName),
                    _buildDivider(240),
                    SizedBox(
                      height: 20,
                    ),
                    BlocBuilder<CharactersCubit, CharactersState>(
                        builder: (context, state) {
                      return chechAreQuotesLoaded(state);
                    })
                  ],
                ),
              ),
              SizedBox(
                height: 500,
              )
            ]),
          )
        ],
      ),
    );
  }
}
