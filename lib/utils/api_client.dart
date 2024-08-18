import 'dart:io';
import 'package:http/http.dart' as http;

class ApiClient {
  static Future<http.Response> uploadImage(File image) async {
    var request = http.MultipartRequest('POST', Uri.parse('your_api_endpoint'));
    request.files.add(await http.MultipartFile.fromPath('image', image.path));

    var response = await request.send();
    return http.Response.fromStream(response);
  }
}