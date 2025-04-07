import 'package:flutter/material.dart';
import 'package:uipasteboard/uipasteboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('UIPasteboard')),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.paste_sharp),
          onPressed: () async {
            final pasteboard = UIPasteboard();
            final hasUrl = await pasteboard.hasURLs();
            if (hasUrl) {
              final url = await pasteboard.getURL();
              if (!context.mounted) return;
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("$url")));
            } else {
              if (!context.mounted) return;
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("No URL detected in the pasteboard.")));
            }
          },
        ),
      ),
    );
  }
}
