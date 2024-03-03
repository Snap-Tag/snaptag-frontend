import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:snaptag_frontend/services/network.dart';
import 'package:snaptag_frontend/models/responseModel.dart';
import 'package:snaptag_frontend/widgets/text_widget.dart';

class CapturedPage extends StatefulWidget {
  final String imagePath;
  const CapturedPage({super.key, required this.imagePath});

  @override
  State<CapturedPage> createState() => _CapturedPageState();
}

class _CapturedPageState extends State<CapturedPage> {
  final TextEditingController _textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: FutureBuilder<ResponseModel>(
            future: SnapTagAPIRequest.getTags(widget.imagePath),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Column(children: [
                  Center(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height - 400,
                      width: MediaQuery.of(context).size.width - 50,
                      child: Card(
                          child: Image.memory(
                        base64Decode(snapshot.data!.croppedDocument),
                        fit: BoxFit.contain,
                      )),
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
                                        hintText: "Enter Tag"),
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
                                        setState(() {
                                          snapshot.data!.extractedTags
                                              .add(_textFieldController.text);
                                        });
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          icon: const Icon(Icons.add))
                    ],
                  ),
                  SizedBox(
                    height: 190,
                    width: 250,
                    child: ListView.builder(
                      itemCount: snapshot.data!.extractedTags.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(snapshot.data!.extractedTags[index]),
                          trailing: IconButton(
                              onPressed: () {
                                setState(() {
                                  snapshot.data!.extractedTags.removeAt(index);
                                });
                              },
                              icon: const Icon(Icons.remove)),
                        );
                      },
                    ),
                  ),
                ]);
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }));
  }
}
