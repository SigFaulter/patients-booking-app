import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Network {
  final String _url = 'http://localhost:8000/api/';
  //if you are using android studio emulator, change localhost to 10.0.2.2
  var token;

  _getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    token = localStorage.getString('token');
    if (token != null) {
      token = jsonDecode(token)['token'];
    }
  }

  authData(data, apiUrl) async {
    Uri fullUrl = Uri.http(_url, apiUrl);
    return await http.post(fullUrl,
        body: jsonEncode(data), headers: _setHeaders());
  }

  getData(apiUrl) async {
    Uri fullUrl = Uri.http(_url, apiUrl);
    await _getToken();
    return await http.get(fullUrl, headers: _setHeaders());
  }

  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
}
