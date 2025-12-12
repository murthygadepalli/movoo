import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import '../api/config.dart';
import '../api/data_store.dart';
import '../utils/app_utils.dart';
import '../utils/exceptions.dart';

class ApiService {
  static const String _baseUrl = Config.baseUrl;

  static Future<Map<String, dynamic>> getRequest(String endpoint,
      {Map<String, String>? headers, bool addBaseUrl = true}) async {
    try {

      String token = getData.read("token") ?? '';
      log("🔑 Token: $token"); // Debug log
      // Construct the full URL


      final String url = addBaseUrl ? endpoint : endpoint;
      log("🌍 Requesting: $url");

      final response = await http.get(
        Uri.parse(url),
        headers: headers ?? {
          "Authorization" : 'Bearer $token',
          'Content-Type': 'application/json'},
      );

      log("📥 Response Status: ${response.statusCode}");
      log("📥 Raw API Response: ${response.body}");

      if (response.statusCode == 200) {
        try {
          final Map<String, dynamic> data = json.decode(response.body);
          //log("✅ Parsed API Response: ${jsonEncode(data)}");
          return data;
        } catch (e) {
          log("❌ JSON Parsing Error: $e");
          throw Exception("Invalid JSON response from server");
        }
      } else if (response.statusCode == 400) {
        throw BadRequestException(json.decode(response.body));
      } else if (response.statusCode == 404) {
        throw ResourceNotFoundException(json.decode(response.body));
      } else {
        final responseData = json.decode(response.body);
        if(responseData['message'] != null || responseData['msg'] != null){
          AppUtils.showToastMessage(responseData['message'] ?? responseData['msg']);
        }
        log("❌ Error Response: ${response.statusCode}, ${response.body}");
        throw Exception('${response.statusCode} : ${response.body}');
      }
    } catch (e, stackTrace) {
      rethrow;
      log("❌ Exception: $e\n$stackTrace");
      throw Exception("Network error: $e");
    }
  }


  static Future<Map<String, dynamic>?> postRequest(String endpoint, Map<String, dynamic> body, {Map<String, String>? headers}) async {
    try {
      log('🌍 Requesting: $endpoint');
      log('📤 Request Body: ${jsonEncode(body)}');
      final token = getData.read('token');

      final response = await http
          .post(
        Uri.parse(endpoint),
        body: jsonEncode(body),
        headers: headers ?? {
          'Content-Type': 'application/json',
          'Authorization' : 'Bearer $token' },
      )
          .timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException("⏳ API request timed out after 10 seconds");
      });

      log('📥 Response Status: ${response.statusCode}');
      log('📥 Response Body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      } else if(response.statusCode == 401){
        throw UserNotFoundException('${response.statusCode}: ${response.body}');
      }else {
        final responseData = json.decode(response.body);
        if(responseData['message'] != null || responseData['msg'] != null){
          AppUtils.showToastMessage(responseData['message'] ?? responseData['msg']);
        }
        throw Exception('${response.statusCode}: ${response.body}');
      }
    } catch (e) {
      log('❌ API Request Failed: $e');
      rethrow;
    }
  }



  static Future<Map<String, dynamic>> putRequest(
      String endpoint, Map<String, dynamic> body, {Map<String, String>? headers}) async {
    log(endpoint);
    log(body.toString());
    String? token = getData.read('token');
      final response = await http.put(
        Uri.parse(endpoint),
        body: json.encode(body),
        headers: headers ?? {
          'Content-Type': 'application/json',
          'Authorization' : 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        log('${response.statusCode}, ${response.body}');
        return json.decode(response.body);
      } else {
        final responseData = json.decode(response.body);
        if(responseData['message'] != null || responseData['msg'] != null){
          AppUtils.showToastMessage(responseData['message'] ?? responseData['msg']);
        }
        log('${response.statusCode}, ${response.body}');
        throw Exception(response.body);
      }
  }

  static Future<Map<String, dynamic>> putFileRequest(
      String endpoint, String filePath, String tag,
      {required Map<String, String> headers}) async {
    log('${_baseUrl}/$endpoint');
    // Determine media type dynamically
    String fileType = await AppUtils.getMimeType(filePath);
    var mediaType = MediaType.parse(fileType);

    // Create a multipart request
    var request = http.MultipartRequest('PUT', Uri.parse('$_baseUrl/$endpoint'));

    request.headers.addAll(headers);

    // Add file and tag as multipart form data
    request.files.add(await http.MultipartFile.fromPath('file', filePath, contentType: mediaType));
    // request.fields['tag'] = tag;

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      log('${response.statusCode}, ${response.body}');
      return json.decode(response.body);
    } else {
      final responseData = json.decode(response.body);
      if(responseData['message'] != null || responseData['msg'] != null){
        AppUtils.showToastMessage(responseData['message'] ?? responseData['msg']);
      }
      log('${response.statusCode}, ${response.body}');
      throw Exception('${response.statusCode} : ${response.body}');
    }
  }

  static Future<Map<String, dynamic>> patchRequest(
      String endpoint, Map<String, dynamic> body, {Map<String, String>? headers}) async {
    log('${_baseUrl}/$endpoint');
    log(body.toString());
      final response = await http.patch(
        Uri.parse('$_baseUrl/$endpoint'),
        body: json.encode(body),
        headers:headers ?? {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        log('${response.statusCode}, ${response.body}');
        return json.decode(response.body);
      } else {
        final responseData = json.decode(response.body);
        if(responseData['message'] != null || responseData['msg'] != null){
          AppUtils.showToastMessage(responseData['message'] ?? responseData['msg']);
        }
        log('${response.statusCode}, ${response.body}');
        throw Exception('${response.statusCode} : ${response.body}');
      }
  }


  static Future<Map<String, dynamic>?> loginRequest(String endpoint, Map<String, dynamic> body, {Map<String, String>? headers}) async {
    try {
      log('🌍 Requesting: $endpoint');
      log('📤 Request Body: ${jsonEncode(body)}');

      final response = await http
          .post(
        Uri.parse(endpoint),
        body: jsonEncode(body),
        headers: headers ?? {'Content-Type': 'application/json'},
      )
          .timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException("⏳ API request timed out after 10 seconds");
      });

      log('📥 Response Status: ${response.statusCode}');
      log('📥 Response Body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      } else if(response.statusCode == 404){
        log("hekkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk");
        throw UserNotFoundException('User not found at $endpoint');
      }else{
        throw Exception('${response.statusCode}: ${response.body}');
      }
    } catch (e) {
      log('❌ API Request Failed: $e');
      rethrow;
    }
  }

}
