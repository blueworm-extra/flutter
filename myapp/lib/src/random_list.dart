import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:myapp/src/bloc/Bloc.dart';
import 'package:myapp/src/saved.dart';

class RandomList extends StatefulWidget {
  @override
  _RandomListState createState() => _RandomListState();
}

class _RandomListState extends State<RandomList> {
  final List<WordPair> _suggestions = <WordPair>[];
  // final Set<WordPair> _saved = Set<WordPair>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text("naming app"),
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.list),
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => SavedList()));
                  })
            ],
          ),
          body: _buildList()),
    );
  }

  Widget _buildList() {
    return StreamBuilder<Set<WordPair>>(
        stream: bloc.savedStream,
        builder: (context, snapshot) {
          return ListView.builder(itemBuilder: (context, index) {
            if (index.isOdd) {
              return Divider();
            }

            var realIndex = index ~/ 2;

            if (realIndex >= _suggestions.length) {
              _suggestions.addAll(generateWordPairs().take(10));
            }

            return _buildRow(snapshot.data, _suggestions[realIndex]);
          });
        });
  }

  Widget _buildRow(Set<WordPair> saved, WordPair wordPair) {
    final bool alreadySaved = saved == null ? false : saved.contains(wordPair);
    return ListTile(
      title: Text(
        wordPair.asPascalCase,
        textScaleFactor: 1.5,
      ),
      trailing: Icon(alreadySaved ? Icons.favorite : Icons.favorite_border,
          color: Colors.pink),
      onTap: () {
        // setState(() {
        //   if (alreadySaved) {
        //     saved.remove(wordPair);
        //   } else {
        //     saved.add(wordPair);
        //   }
        //   print(saved.toString());
        // });
        bloc.addToOrRemoveFromSavedList(wordPair);
      },
    );
  }
}
