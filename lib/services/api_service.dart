import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/user.dart';

class ApiService {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';

  // Future<List<Todo>> fetchTodos() async {
  //   final response = await http.get(Uri.parse('$baseUrl/todos'));
  //   if (response.statusCode == 200) {
  //     List<dynamic> jsonList = jsonDecode(response.body);
  //     return jsonList.map((json) => Todo.fromJson(json)).toList();
  //   } else {
  //     throw Exception('Failed to load todos: ${response.statusCode}');
  //   }
  // }

  Future<User> fetchUser(int userId) async {
    final response = await http.get(Uri.parse('$baseUrl/users/$userId'));
    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load user: ${response.statusCode}');
    }
  }


}