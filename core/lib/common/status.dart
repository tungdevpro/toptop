enum BaseStatus<T> {
  loading('Loading', data: null),
  success('Success', data: null),
  error('Error', data: null, errorMsg: 'Has a error');

  const BaseStatus(this.text, {this.data, this.errorMsg});
  final String text;
  final String? errorMsg;
  final T? data;
}
