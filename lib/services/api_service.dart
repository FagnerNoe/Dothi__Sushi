import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String apiUrl = "http://10.0.0.152:3000/";

  // Ajuste conforme necessário

  Future<List<dynamic>> fetchSushi() async {
    final response = await http.get(Uri.parse('$apiUrl/sushis'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception(
        "Erro ao carregar os dados sushis: ${response.statusCode}",
      );
    }
  }

  Future<List<dynamic>> fetchCombos() async {
    final response = await http.get(Uri.parse('$apiUrl/combos'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Erro ao caregar  dados combos: ${response.statusCode}");
    }
  }
}
