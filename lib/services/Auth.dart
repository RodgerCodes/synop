import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthService {
  Dio dio = new Dio();
  var url = "https://blooming-earth-69373.herokuapp.com";

  login(email, password) async {
    try {
      return await dio.post("$url/signin",
          data: {"email": email, "password": password},
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      Fluttertoast.showToast(
          msg: e.response.data['msg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          fontSize: 16.0);
    }
  }

  getinfo(token) async {
    dio.options.headers['authorization'] = 'Bearer $token';
    return await dio.get('$url/info');
  }

  getCode(token) async {
    dio.options.headers['authorization'] = 'Bearer $token';
    return await dio.get('$url/code');
  }

  addCode(token, code) async {
    dio.options.headers['authorization'] = 'Bearer $token';
    try {
      return await dio.post(
        '$url/code',
        data: {"code": code},
      );
    } on DioError catch (e) {
      Fluttertoast.showToast(
          msg: "Error",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          fontSize: 16.0);
    }
  }
}
