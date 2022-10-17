import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class LinkList extends StatefulWidget {
  @override
  _SongListState createState() => _SongListState();

  LinkList({
    Key key,
  }) : super(key: key);
}

class _SongListState extends State<LinkList> {
  // void initState() {
  //   super.initState();
  //   // Enable virtual display.
  //   if (Platform.isAndroid) WebView.platform = AndroidWebView();
  // }

  getCustomHeaders() {
    Map<String, String> headers = {"Your Header": "1234"};

    return headers;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[400],
        title: Text('Song List'),
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(
            url: Uri.parse("http://dummy.restapiexample.com/api/v1/create"),
            method: 'POST',
            body: Uint8List.fromList(utf8.encode("name=Foo&salary=123")),
            headers: {'test': '12345'}),
        onWebViewCreated: (controller) {},
      ),
    );
  }
}
