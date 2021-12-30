import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Details extends StatelessWidget {

  final arguments;
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
            initialUrl: arguments != null ? arguments['url'] : '0',
            javascriptMode: JavascriptMode.unrestricted,
            // onProgress: (int progress) {
            //   //print("WebView is loading (progress : $progress%)");
            // },
            // navigationDelegate: (NavigationRequest request) {
            //   if (request.url.startsWith('https://www.youtube.com/')) {
            //     //print('blocking navigation to $request}');
            //     return NavigationDecision.prevent;
            //   }
            //   //print('allowing navigation to $request');
            //   return NavigationDecision.navigate;
            // },
            // onPageStarted: (String url) {
            //  // print('Page started loading: $url');
            // },
            // onPageFinished: (String url) {
            //   //print('Page finished loading: $url');
            // },
            // gestureNavigationEnabled: true,
            );
        }),
        // Center(
        //   child:  Text(
        //     //"知乎，你好",
        //     //arguments["url"],
        //     arguments != null ? arguments['url'] : '0',
        //   ),
        // ),

      ),
    );
  }
}

