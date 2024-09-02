class ResultModel<T> {
  final bool isSuccess;
  final String message;
  final T? data;

  const ResultModel({
    required this.isSuccess,
    this.message = "",
    this.data,
  });
}
