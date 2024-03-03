import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snaptag_frontend/screens/uploadDone.dart';
import 'package:snaptag_frontend/services/network.dart';
import 'package:snaptag_frontend/models/responseModel.dart';
import 'package:snaptag_frontend/widgets/text_widget.dart';
import 'package:snaptag_frontend/providers/tagsProvider.dart';

class CapturedPage extends StatefulWidget {
  final String imagePath;
  const CapturedPage({Key? key, required this.imagePath}) : super(key: key);

  @override
  State<CapturedPage> createState() => _CapturedPageState();
}

class _CapturedPageState extends State<CapturedPage> {
  final TextEditingController _textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Captured Page"),
        actions: [
          IconButton(
            onPressed: () {
              _saveAndNavigate(context);
            },
            icon: Icon(Icons.done),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<ResponseModel>(
          future: SnapTagAPIRequest.getTags(widget.imagePath),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              final tagsProvider =
                  Provider.of<TagsProvider>(context, listen: false);
              tagsProvider.setTag(snapshot.data!.extractedTags);
              tagsProvider.setImage(snapshot.data!.croppedDocument);

              return Column(
                children: [
                  Center(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height - 400,
                      width: MediaQuery.of(context).size.width - 50,
                      child: Card(
                        child: Image.memory(
                          base64Decode(snapshot.data!.croppedDocument),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const TextWidget(text: "Tags"),
                      IconButton(
                        onPressed: () async {
                          return showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('Add Tag'),
                                content: TextField(
                                  controller: _textFieldController,
                                  decoration: const InputDecoration(
                                    hintText: "Enter Tag",
                                  ),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    child: const Text('CANCEL'),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                  TextButton(
                                    child: const Text('OK'),
                                    onPressed: () {
                                      tagsProvider
                                          .addTag(_textFieldController.text);
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        icon: const Icon(Icons.add),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 190,
                    width: 250,
                    child: Consumer<TagsProvider>(
                      builder: (context, tagsProvider, _) => ListView.builder(
                        itemCount: tagsProvider.tags.length,
                        itemBuilder: (context, index) {
                          final tag = tagsProvider.tags[index];
                          return ListTile(
                            title: Text(tag),
                            trailing: IconButton(
                              onPressed: () {
                                tagsProvider.removeTag(index);
                              },
                              icon: const Icon(Icons.remove),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  void _saveAndNavigate(BuildContext context) async {
    final tagsProvider = Provider.of<TagsProvider>(context, listen: false);
    final imageData = tagsProvider.imageData; // Your base64-encoded image data
    final tags = tagsProvider.tags;

    try {
      final imageId = await SnapTagAPIRequest.saveNote(imageData, tags);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const UploadDone()),
      );
    } catch (e) {
      print("Error saving note: $e");
      // Handle error
    }
  }
}
