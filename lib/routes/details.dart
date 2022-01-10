import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Details extends StatelessWidget {

  final Map? arguments;
  const Details({Key? key,this.arguments}): super(key:key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon:const Icon(Icons.arrow_back),
          ),
          title:const Text(
                "故事详情",
          ),
        ),
        body: Builder(builder: (BuildContext context) {
          return WebView(
            initialUrl: arguments != null ? arguments!['url'] : '0',
            javascriptMode: JavascriptMode.unrestricted,
            );
        }),
      ),
    );
  }
}

