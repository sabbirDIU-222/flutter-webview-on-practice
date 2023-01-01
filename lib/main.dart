import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _completerController = Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('webview_flutter'),
        ),
        body: WebView(
          onWebViewCreated: (controller) =>
              _completerController.complete(controller),
          initialUrl: "https://letmibd.com",
        ),
        bottomNavigationBar: Container(
          color: Theme.of(context).accentColor,
          child: Padding(
            padding: EdgeInsets.only(right: 20, bottom: 10),
            child: ButtonBar(
              children: [
                navigationButtonBar(Icons.chevron_left, onBack),
                navigationButtonBar(Icons.chevron_right, onForward),
              ],
            ),
          ),
        ),
      ),
    );
  }

// function for button bar
  Widget navigationButtonBar(
      IconData iconData, Function(WebViewController) onpressed) {
    return FutureBuilder(
      future: _completerController.future,
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          return IconButton(
              onPressed: () {
                snapshot.data;
              },
              icon: Icon(
                iconData,
                color: Colors.white,
              ));
        } else {
          return Container(
            child: Text('fuck'),
          );
        }
      }),
    );
  }

  void onBack(WebViewController onbackwebviewcontroller) async {
    final canGoback = await onbackwebviewcontroller.canGoBack();

    if (canGoback) {
      onbackwebviewcontroller.canGoBack();
    }
  }

  void onForward(WebViewController onforwardwebviewcontroller) async {
    final cangoForward = await onforwardwebviewcontroller.canGoForward();
    if (cangoForward) {
      onforwardwebviewcontroller.canGoForward();
    }
  }
}
