import 'package:isar/isar.dart';
import 'package:word_list_coodesh_app/data/model/word_model.dart';

part 'word_collection.g.dart';

@collection
class WordCollection {
  WordCollection({
    required this.id,
    required this.word,
    required this.meanings,
    required this.pronunciation,
    this.isFavourite = false,
    this.hasBeenVisited = false,
    this.uid = const [],
  });

  final Id id;

  @Index(type: IndexType.value)
  final String word;
  final List<String> meanings;
  final String pronunciation;
  bool isFavourite;
  bool hasBeenVisited;
  List<String> uid;

  WordModel toModel() => WordModel(
        word: word,
        meanings: meanings,
        pronunciation: pronunciation,
        isFavourite: isFavourite,
        id: id,
        hasBeenVisited: hasBeenVisited,
        uid: uid,
      );
}
