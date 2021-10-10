import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthService {
  Dio dio = new Dio();
  // var url = "https://whispering-shelf-45463.herokuapp.com";
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  var url = "http://10.0.2.2:5000";

  getinfo(token) async {
    dio.options.headers['authorization'] = 'Bearer $token';

    return await dio.get('$url/info');
  }

  getCode(token) async {
    dio.options.headers['authorization'] = 'Bearer $token';
    try {
      return await dio.get('$url/code');
    } on DioError catch (e) {
      Fluttertoast.showToast(
          msg: 'Network Error',
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
        fontSize: 16.0,
      );
    }
  }

  createUser(name, email, district, password) async {
    try {
      return await dio.post('$url', data: {
        "name": name,
        "email": email,
        "district": district,
        "password": password
      });
    } on DioError catch (e) {
      Fluttertoast.showToast(
          msg: e.response.data,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          fontSize: 16.0);
    }
  }

  logout(token) async {
    dio.options.headers['authorization'] = 'Bearer $token';
    try {
      return await dio.post('$url/logout');
    } on DioError catch (e) {
      Fluttertoast.showToast(
          msg: e.response.data,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          fontSize: 16.0);
    }
  }
}
