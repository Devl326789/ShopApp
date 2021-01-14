import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/http_exception.dart';

class Auth with ChangeNotifier {
  String _token_;
  DateTime _expiryDate;
  String _userId;
  String _apiKey = 'AIzaSyAAHKOgYTddu2-MVSu94JFGF6ISlOh6DHQ';

  Future<void> _authenticate(
      String email, String password, String urlSegment) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment';
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
    } catch (error) {
      throw error;
    }
  }

  Future<void> signUp(String email, String password) async {
    final urlSegment = 'signUp?key=$_apiKey';
    return _authenticate(email, password, urlSegment);
  }

  Future<void> signIn(String email, String password) async {
    final urlSegment = 'signInWithPassword?key=$_apiKey';
    return _authenticate(email, password, urlSegment);
  }
}
