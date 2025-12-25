import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;

class quizService {
  Future<String?> uploadToCloudinary(File image) async {
  const cloudName = "dkky86jsr";
  const uploadPreset = "flutter_unsigned";

  final url = Uri.parse(
      "https://api.cloudinary.com/v1_1/$cloudName/image/upload");

  final request = http.MultipartRequest("POST", url)
    ..fields['upload_preset'] = uploadPreset
    ..files.add(await http.MultipartFile.fromPath(
      'file',
      image.path,
    ));

  final response = await request.send();

  if (response.statusCode == 200) {
    final resStr = await response.stream.bytesToString();
    final data = jsonDecode(resStr);
    return data['secure_url']; // ✅ DIRECT IMAGE URL
  } else {
    print("Upload failed: ${response.statusCode}");
    return null;
  }
}

  Future<dynamic> ResponseChatGpt(File image) async{
    String apiKey = "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" ;
    final api = Uri.parse(
      "https://api.openai.com/v1/chat/completions");
    String linkImg = await uploadToCloudinary(image) ?? "" ;

    final body = {
  "model": "gpt-4o-mini",
  "messages": [
    {
      "role": "system",
      "content": "You are not a medical professional. Only provide educational observations."
    },
    {
      "role": "user",
      "content": [
        {
          "type": "text",
          "text": "YES or NO: Does this image show visible signs commonly associated with skin irritation? Explain briefly. This is not a diagnosis."
        },
        {
          "type": "image_url",
          "image_url": {
            "url": "$linkImg"
          }
        }
      ]
    }
  ]
} ;

  final response = await http.post(
    api,
    headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $apiKey",
    },
    body: jsonEncode(body),
  );


  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    final content = data['choices'][0]['message']['content'];
    return content;
  } else {
    print("ChatGPT error: ${response.body}");
    return null;
  }
  }
}
