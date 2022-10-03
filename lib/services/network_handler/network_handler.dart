// import 'package:http/http.dart' as http;
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// class NetworkHandler {
//   static final client = http.Client();
//   static final storage = new FlutterSecureStorage();
//   static void post(var body, String endpoint) async {
//     var response = await client.post(buildUrl(endpoint), body: body);
//   }

//   static Uri buildUrl(String endpoint) {
//     String host = "http://10.0.2.2:8000/";
//     final apiPath = host + endpoint;
//     return Uri.parse(apiPath);
//   }

//   static void storeToken(token) async {
//     await storage.write(key: "token", value: token);
//   }

//   static Future<String?> getToken(token) async {
//     return await storage.read(key: "token");
//   }
// }
