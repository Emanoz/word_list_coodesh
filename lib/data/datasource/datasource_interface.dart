abstract class DataSourceInterface<T> {
  Future<List<T>> getAll();

  Future<T> getDetailsByWord();

  Future<void> save(T item);

  Future<void> delete(T item);
}