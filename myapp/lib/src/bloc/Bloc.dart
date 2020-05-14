import 'dart:async';

import 'package:english_words/english_words.dart';

class Bloc {
  Set<WordPair> saved = Set<WordPair>();

  final _savedController = StreamController<Set<WordPair>>.broadcast();

  get savedStream => _savedController.stream;
  
  get sinkSaved => _savedController.sink.add(saved);

  addToOrRemoveFromSavedList(WordPair wordPair) {
    
    if (saved.contains(wordPair)) {
      saved.remove(wordPair);
    } else {
      saved.add(wordPair);
    }
    _savedController.sink.add(saved);

  }

  dispose() {
    _savedController.close();
  }
}

var bloc = Bloc();
