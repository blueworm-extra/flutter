import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:myapp/src/bloc/Bloc.dart';

class SavedList extends StatefulWidget {
  @override
  _SavedListState createState() => _SavedListState();
}

class _SavedListState extends State<SavedList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Saved",
            textAlign: TextAlign.center,
          ),
        ),
        body: _buildList());
  }

  Widget _buildList() {
    return StreamBuilder<Set<WordPair>>(
        stream: bloc.savedStream,
        builder: (context, snapshot) {
          var words = Set<WordPair>();
          if (snapshot.hasData) {
            words.addAll(snapshot.data);
          } else {
            bloc.sinkSaved;
          }

          return ListView.builder(
              itemCount: words.length * 2,
              itemBuilder: (context, index) {
                if (index.isOdd) {
                  return Divider();
                }
                var realIndex = index ~/ 2;

                return _buildRow(words.toList()[realIndex]);
              });
        });
  }

  Widget _buildRow(WordPair wordPair) {
    return ListTile(
      title: Text(
        wordPair.asPascalCase,
        textScaleFactor: 1.5,
      ),
      onTap: () {
        // setState(() {
        //   bloc.saved.remove(wordPair);
        // });
        bloc.addToOrRemoveFromSavedList(wordPair);
      },
    );
  }
}
