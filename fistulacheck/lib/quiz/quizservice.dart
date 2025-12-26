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
    return data['secure_url'];
  } else {
    print("Upload failed: ${response.statusCode}");
    return null;
  }
}

  Future<dynamic> ResponseChatGpt(File image, List<bool?> Answers) async{
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
          "text": "OUI ou NON : Cette image présente-t-elle des signes visibles généralement associés à une irritation cutanée ? Expliquez brièvement. Ceci n’est pas un diagnostic. ceci sont les questions que le patient a répondu par oui ou NON  : Avez-vous remarqué une rougeur importante ou une zone chaude autour de la fistule ? ${Answers[0]} Avez-vous constaté un gonflement inhabituel au niveau de la fistule ou du bras ? ${Answers[1]} Sentez-vous une diminution ou une disparaition du thrill(vibration) lorque vous posez votre main sur la fistule ? ${Answers[2]} Avez-vous observé un soignement anormal ou un écoulement au niveau du point de ponction ? ${Answers[3]} Avez-vous une douleur inhabutuelle , forte ou persistante dans le bras portant la fistule ? ${Answers[4]} Avez-vous remarqué un changement de couleur du membrane (paleur) du coté de la fistule ? ${Answers[5]} Avez-vous remarqué que la fistule est devenue plus grosse , déformé ou pulsatile comme un ballon ? ${Answers[6]} (je veux seulement la réponse courte  des signes visibles généralement associés à une irritation cutanée ? Expliquez brièvement )"
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
};

  final response = await http.post(
    api,
    headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $apiKey",
    },
    body: jsonEncode(body),
  );


  if (response.statusCode == 200) {
    final data = jsonDecode(utf8.decode(response.bodyBytes));
    final content = data['choices'][0]['message']['content'];
    return content;
  } else {
    print("ChatGPT error: ${response.body}");
    return null;
  }
  }
}
