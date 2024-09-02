class SuccessModel<T> {
  final String message;
  final bool hasNextPage;
  final T? data;

  const SuccessModel({
    this.message = "",
    this.hasNextPage = false,
    this.data,
  });
}
