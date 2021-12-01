import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zhihu_news/routes/details.dart';
import 'package:zhihu_news/routes/login.dart';
import 'package:zhihu_news/tabs/home_content.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: (RouteSettings settings){
        final routes={
          '/':(context)=>const HomeContent(),
          '/details':(context,{arguments})=>Details(arguments:arguments),
          '/login':(context)=>const LoginPage(),
        };

        final String? name=settings.name;
        final Function? pageContentBuilder = routes[name];
        if(pageContentBuilder != null){
          if(settings.arguments != null){
            final Route route = MaterialPageRoute(
                builder:(context)=>pageContentBuilder(
                    context,
                    arguments:settings.arguments
                )
            );
            return route;
          }
          else{
            final Route route = MaterialPageRoute(
                builder: (context)=>pageContentBuilder(context)
            );
            return route;
          }
        }
      },
      home:const HomeContent(),
    );
  }
}
