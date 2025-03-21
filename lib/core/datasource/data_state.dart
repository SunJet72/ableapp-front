abstract class DataState<T> {
  final T? data;
  final String? message;

  const DataState({this.data, this.message});
}

class DataSuccess<T> extends DataState<T> {
  const DataSuccess(T? data) : super(data: data);
}

class DataFailure<T> extends DataState<T> {
  const DataFailure(String message) : super(message: message);
}