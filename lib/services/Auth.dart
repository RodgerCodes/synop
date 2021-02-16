import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthService {
  Dio dio = new Dio();
  var url = "https://blooming-earth-69373.herokuapp.com";
  // var url = "http://127.0.0.1:5000";
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

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
      // print(e.response);

    }
  }

  getinfo(token) async {
    dio.options.headers['authorization'] = 'Bearer $token';
    try {
      return await dio.get('$url/info');
    } on DioError catch (e) {
      Fluttertoast.showToast(
          msg: "Network Error",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          fontSize: 16.0);
    }
  }

  getCode(token) async {
    dio.options.headers['authorization'] = 'Bearer $token';
    try {
      return await dio.get('$url/code');
    } on DioError catch (e) {
      Fluttertoast.showToast(
          msg: "Network Error",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          fontSize: 16.0);
    }
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

  deleteCode(token, id) async {
    dio.options.headers['authorization'] = 'Bearer $token';
    try {
      return await dio.delete('$url/del/$id');
    } on DioError catch (e) {
      Fluttertoast.showToast(
          msg: e.response.data['msg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          fontSize: 16.0);
    }
  }

  updatePic(token, _image) async {
    dio.options.headers['authorization'] = 'Bearer $token';
    try {
      return await dio.put('$url/profile', data: {"profile_img": _image});
    } on DioError catch (e) {
      // Fluttertoast.showToast(
      //     msg:
      //     toastLength: Toast.LENGTH_SHORT,
      //     gravity: ToastGravity.TOP,
      //     fontSize: 16.0);
      print(e);
    }
  }
}
