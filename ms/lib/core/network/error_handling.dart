part of 'error.dart';

class ErrorHandling {
  // ignore: always_declare_return_types
  onError(Object obj) => throw tryParse(obj);

  static Error tryParse(Object obj) {
    switch (obj.runtimeType) {
      case DioError:
        final res = (obj as DioError).response;
        ErrorHandling._sendMessage(obj);
        if (res != null) {
          final resError = res.data is Map<String, dynamic>
              ? BaseResponse.fromJson(res.data, (_) {})
              : null;
          final error = Error(dioError: obj, resBase: resError);
          // return Future.error(assureError(error));
          return assureError(error);
        } else {
          final error = Error(dioError: obj);
          // return Future.error(assureError(error));
          return assureError(error);
        }
      default:
        // return Future.error(assureError(obj));
        return assureError(obj);
    }
  }

  static Error assureError(err) {
    Error error;
    if (err is Error) {
      error = err;
    } else {
      error = Error(error: err);
    }
    return error;
  }

  static void _sendMessage(DioError? _error) {
    if (ErrorHandling._exceptCollection.contains(_error?.requestOptions.path))
      return;

    final _method = _error?.requestOptions.method;
    // final _headers = json.encode(_error?.requestOptions.headers);
    final _uri = _error?.requestOptions.uri;
    String? _data;
    if (_error?.requestOptions.data is FormData) {
      final _formData = _error?.requestOptions.data as FormData;
      _data = '${_formData.fields.toString()}';
    } else if (_error?.requestOptions.data is Map)
      _data = '${json.encode(_error?.requestOptions.data)}';
    else
      _data = _error?.requestOptions.data.toString();

    final _response = _error?.response;
    final _statusCode = _error?.response?.statusCode;
    final _statusMess = _error?.response?.statusMessage;

    // OneTeleLog.sendLog(_method, _uri.toString(), _data, '`$_statusCode - $_statusMess`\n`$_response`');
  }

  static List<String> get _exceptCollection => [
        '/app-banhang/splash/ds_splash',
        '/quantri/user/thongtin_nguoidung2',
        '/quantri/user/xacthuc_tapdoan',
        '/quantri/user/login',
        '/quantri/user/khoitao_ungdung?p_idmodule=21',
        '/quantri/user/log_sudung_chucnang',
      ];
}