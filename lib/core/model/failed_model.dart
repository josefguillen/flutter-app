class FailedModel<T> {
  final String message;
  final bool isNoData;
  final T? data;

  const FailedModel({
    this.message = "",
    this.isNoData = false,
    this.data,
  });
}
