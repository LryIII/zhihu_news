import 'package:flutter/material.dart';
import 'package:zhihu_news/routes/register.dart';
import 'package:zhihu_news/tabs/home_content.dart';

import 'details.dart';
import 'login_page.dart';
final routes={
  '/':(context)=>const HomeContent(),
  '/details':(context,{arguments})=>Details(arguments:arguments),
  '/login':(context)=> const LoginPage(),
  '/register':(context)=>const RegisterPage(),
};
Route? onGenerateRoute(RouteSettings settings){
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
}
