import 'dart:typed_data'; // Add this import
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:http_parser/http_parser.dart'; // For MediaType

class StabilityAIService {
  static const String _apiKey =
      'sk-3deZwvdiroAecbSuroqon89Udn0K9E6Et4grLAedu9l4ncLs'; //'YOUR_STABILITY_AI_API_KEY';
  static const String _apiUrl =
      'https://api.stability.ai/v2beta/stable-image/generate/ultra';

  Future<Uint8List> generateImageFromText1(String prompt) async {
    final response = await http.post(
      Uri.parse(_apiUrl),
      headers: {
        'Authorization': 'Bearer $_apiKey',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'prompt': prompt,
        'width': 512,
        'height': 512,
        'steps': 50,
        'cfg_scale': 7,
        'samples': 1,
      }),
    );

    if (response.statusCode == 200) {
      // Decode the response and extract the image data
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      final String imageBase64 = responseData['artifacts'][0]['base64'];
      return base64Decode(imageBase64);
    } else {
      throw Exception('Failed to generate image: ${response.body}');
    }
  }

  Future<Uint8List> generateImageFromText(String prompt) async {
    // Create a multipart request
    final request = http.MultipartRequest('POST', Uri.parse(_apiUrl));

    // Add headers
    request.headers['authorization'] = 'Bearer $_apiKey';
    request.headers['accept'] = 'image/*';

    // Add form fields
    request.fields['prompt'] = prompt;
    request.fields['output_format'] = 'webp';

    // Add a dummy file (required by the API)
    request.files.add(
      http.MultipartFile.fromString(
        'file',
        '',
        contentType: MediaType('application', 'octet-stream'),
      ),
    );

    try {
      // Send the request
      final response = await request.send();

      // Check if the request was successful
      if (response.statusCode == 200) {
        // Read the response bytes
        final Uint8List imageBytes = await response.stream.toBytes();
        return imageBytes;
      } else {
        throw Exception('Failed to generate image: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}

class ImageGeneratorScreen extends StatefulWidget {
  @override
  _ImageGeneratorScreenState createState() => _ImageGeneratorScreenState();
}

class _ImageGeneratorScreenState extends State<ImageGeneratorScreen> {
  Uint8List? _generatedImage;
  final TextEditingController _textController = TextEditingController();

  Future<void> _generateImage() async {
    final stabilityAIService = StabilityAIService();
    final image =
        await stabilityAIService.generateImageFromText(_textController.text);
    setState(() {
      _generatedImage = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Text to Image Generator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _textController,
              decoration: InputDecoration(
                labelText: 'Enter a prompt',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _generateImage,
              child: Text('Generate Image'),
            ),
            SizedBox(height: 20),
            if (_generatedImage != null) Image.memory(_generatedImage!),
          ],
        ),
      ),
    );
  }
}
