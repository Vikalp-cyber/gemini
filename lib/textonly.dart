import 'package:flutter/material.dart';
import 'package:gemini/apiKey.dart';
import 'package:google_gemini/google_gemini.dart';

class TextOnly extends StatefulWidget {
  const TextOnly({super.key});

  @override
  State<TextOnly> createState() => _TextOnlyState();
}

class _TextOnlyState extends State<TextOnly> {
  List textchat = [];
  bool loading = false;
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scroll = ScrollController();
  final gemini = GoogleGemini(apiKey: GeminiApiKey.apiKey);

  void queryText({required String query}) {
    setState(() {
      loading = true;
      textchat.add(
        {
          'role': 'user',
          'text': query,
        },
      );
      _textController.clear();
    });
    scrollToEnd();
    gemini.generateFromText(query).then((value) {
      setState(() {
        loading = false;
        textchat.add(
          {
            'role': 'Gemini',
            'text': value.text,
          },
        );
      });
      scrollToEnd();
    }).onError((error, stackTrace) {
      loading = false;
      textchat.add({
        "role": "Gemini",
        "text": error.toString(),
      });
      scrollToEnd();
    });
  }

  void scrollToEnd() {
    _scroll.jumpTo(_scroll.position.maxScrollExtent);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
                  controller: _scroll,
                  itemCount: textchat
                      .length, //count of tiles == number of items in textchat List
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: CircleAvatar(
                        child: Text(textchat[index]["role"]
                            .substring(0, 1)), //first letter of role as Avatar
                      ),
                      title: Text(textchat[index]["role"]), //username=>role
                      subtitle: Text(textchat[index]["text"]), //chat=>text
                    );
                  })),
          Container(
            alignment: Alignment.bottomCenter,
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.grey)),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    decoration: InputDecoration(
                        hintText: "Type your Prompt..",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide.none),
                        fillColor: Colors.transparent),
                    keyboardType: TextInputType.multiline,
                  ),
                ),
                IconButton(
                    onPressed: () {
                      queryText(query: _textController.text);
                    },
                    icon: loading
                        ? const CircularProgressIndicator()
                        : const Icon(
                            Icons.send,
                            color: Colors.deepPurple,
                          ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
