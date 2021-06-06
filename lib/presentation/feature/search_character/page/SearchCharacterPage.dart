import 'package:flutter/material.dart';
import 'package:flutter_graphql/core/bloc/bloc_provider.dart';
import 'package:flutter_graphql/core/model/result/result.dart';
import 'package:flutter_graphql/di/locator.dart';
import 'package:flutter_graphql/domain/entity/character.dart';
import 'package:flutter_graphql/presentation/feature/search_character/bloc/SearchCharacterBloc.dart';

class SearchCharacterPage extends StatefulWidget {
  const SearchCharacterPage({Key? key}) : super(key: key);

  @override
  _SearchCharacterPageState createState() => _SearchCharacterPageState();
}

class _SearchCharacterPageState extends State<SearchCharacterPage> {
  late SearchCharacterBloc _bloc;
  final _controller = TextEditingController();

  @override
  void initState() {
    _bloc = getIt<SearchCharacterBloc>();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SearchCharacterBloc>(
      child: SafeArea(
        child: Scaffold(
          body: _buildMainBody(),
        ),
      ),
      bloc: _bloc,
    );
  }

  _buildMainBody() {
    return Column(
      children: [
        _buildSearchForm(),
        _buildCharacterCard(),
        _buildCachedList(),
      ],
    );
  }

  _buildSearchForm() {
    return Card(
      margin: EdgeInsets.all(16),
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        child: TextFormField(
          onFieldSubmitted: (query) async {
            _controller.clear();
            _bloc.searchCharacter(query);
          },
          controller: _controller,
          decoration: InputDecoration(border: InputBorder.none, hintText: 'Search Anime Characters'),
        ),
      ),
    );
  }

  _buildCharacterCard() {
    return Expanded(
      child: StreamBuilder<Result<Character>>(
        stream: _bloc.characterStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return _buildStateUI(snapshot);
          } else if (snapshot.hasError) {
            return _buildErrorStateUI();
          } else {
            return Offstage();
          }
        },
      ),
    );
  }

  Widget _buildStateUI(AsyncSnapshot<Result<Character>> snapshot) {
    if (snapshot.data is Success) {
      return _buildSuccessStateUI((snapshot.data as Success).data);
    }

    if (snapshot.data is Loading) {
      return _buildLoadingStateUI();
    }

    if (snapshot.data is Error) {
      return _buildErrorStateUI();
    }

    return Offstage();
  }

  _buildSuccessStateUI(Character character) {
    final size = MediaQuery.of(context).size;
    return Card(
      margin: EdgeInsets.all(16),
      elevation: 15,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(character.image),
              ),
            ),
          ),
          Column(
            children: [
              Expanded(child: SizedBox()),
              Container(
                width: size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.red,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Center(
                    child: Text(
                      character.name,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _buildErrorStateUI() {
    final size = MediaQuery.of(context).size;
    return Card(
      margin: EdgeInsets.all(16),
      elevation: 15,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            "https://blogs.unsw.edu.au/nowideas/files/2018/11/error-no-es-fracaso.jpg",
            fit: BoxFit.cover,
          ),
          Column(
            children: [
              Expanded(child: SizedBox()),
              Container(
                width: size.width,
                color: Colors.red,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Center(
                    child: Text(
                      "Error",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _buildLoadingStateUI() {
    return Center(child: CircularProgressIndicator());
  }

  _buildCachedList() {
    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.2,
      child: StreamBuilder<Result<Character>>(
          stream: _bloc.characterStream,
          builder: (context, selectedListSnapshot) {
            return NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (overscroll) {
                overscroll.disallowGlow();
                return true;
              },
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _bloc.getCachedList().length,
                  itemBuilder: (BuildContext context, int index) {
                    final item = _bloc.getCachedList()[index];
                    return _CardItem(character: item, isSelected: false);
                  }),
            );
          }),
    );
  }
}

class _CardItem extends StatelessWidget {
  final Character character;
  final bool isSelected;

  _CardItem({required this.character, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Card(
      elevation: 4,
      child: Container(
        width: size.height * 0.2,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(character.image, fit: BoxFit.cover),
            Column(
              children: [
                Expanded(child: SizedBox()),
                Container(
                  color: Colors.red,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Center(
                      child: Text(
                        character.name,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
