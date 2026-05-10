import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

class GeminiService {
  static const String _apiKey = 'AIzaSyAQAW-_9WUEJtu9_yw8kEjW9yLUZZna3ew';
  static const String _baseUrl =
      'https://generativelanguage.googleapis.com/v1/models/gemini-2.0-flash:generateContent';

  static Future<String> resumirTexto(String texto) async {
    final response = await http.post(
      Uri.parse('$_baseUrl?key=$_apiKey'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'contents': [
          {
            'parts': [
              {
                'text': '''
Eres un asistente académico experto. Analiza el siguiente texto y genera un resumen estructurado con:

## Tema Principal
## Puntos Clave
## Conceptos Importantes
## Conclusión

Texto:
$texto
'''
              }
            ]
          }
        ]
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['candidates'][0]['content']['parts'][0]['text'];
    } else {
      throw Exception('Error ${response.statusCode}: ${response.body}');
    }
  }

  static Future<String> resumirImagen(Uint8List imageBytes) async {
    final base64Image = base64Encode(imageBytes);
    final response = await http.post(
      Uri.parse('$_baseUrl?key=$_apiKey'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'contents': [
          {
            'parts': [
              {
                'text': '''
Eres un asistente académico experto. Analiza esta imagen y genera un resumen estructurado con:

## Tema Principal
## Puntos Clave
## Conceptos Importantes
## Conclusión
'''
              },
              {
                'inline_data': {
                  'mime_type': 'image/jpeg',
                  'data': base64Image,
                }
              }
            ]
          }
        ]
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['candidates'][0]['content']['parts'][0]['text'];
    } else {
      throw Exception('Error ${response.statusCode}: ${response.body}');
    }
  }
}
