import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:path/path.dart';

String _basicAuth = 'Basic ' + base64Encode(utf8.encode('ammar:ammar12345'));

Map<String, String> myheaders = {'authorization': _basicAuth};

class Crud {
  getRequest(String url) async {
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var responsebody = jsonDecode(response.body);
        return responsebody;
      } else {
        print("Error ${response.statusCode}");
      }
    } catch (e) {
      print("Error $e");
    }
  }

  postRequest(String url, Map data) async {
    try {
      var response = await http.post(
        Uri.parse(url),
        body: data,
        headers: myheaders,
      );
      if (response.statusCode == 200) {
        var responsebody = await jsonDecode(response.body);
        return responsebody;
      } else {
        print("Error ${response.statusCode}");
      }
    } catch (e) {
      print("Error $e");
    }
  }

  postRequestWithFile(String url, Map data, File file) async {
    var request = http.MultipartRequest("POST", Uri.parse(url));
    request.headers.addAll(myheaders);
    var length = await file.length();
    var stream = http.ByteStream(file.openRead());
    var multipartFile = http.MultipartFile(
      "file",
      stream,
      length,
      filename: basename(file.path),
    );
    request.files.add(multipartFile);
    data.forEach((key, value) {
      request.fields[key] = value;
    });
    var myrequest = await request.send();
    var response = await http.Response.fromStream(myrequest);
    if (myrequest.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print("Error ${myrequest.statusCode}");
    }
  }
}
