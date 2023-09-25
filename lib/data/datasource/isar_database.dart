import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../collection/word_collection.dart';

class IsarDatabase {
  static late final Isar isarDb;

  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isarDb = await Isar.open(
      [WordCollectionSchema],
      directory: dir.path,
    );
  }
}