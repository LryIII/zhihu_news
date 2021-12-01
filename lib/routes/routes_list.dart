// import 'package:flutter/material.dart';
// import 'package:zhihu_news/routes/details.dart';
//
// //import '../pages/Tabs.dart';
// //import '../pages/Form.dart';
// //import '../pages/Search.dart';//配置路由
// final routes={
//   //'/':(context)=>Tabs(),
//   '/details':(context,{arguments})=>Details(arguments:arguments),
// };
//
// //固定写法
// onGenerateRoute(RouteSettings settings){
//   final String? name=settings.name;
//   final Function? pageContentBuilder = routes[name];
//   if(pageContentBuilder != null){
//     if(settings.arguments != null){
//       final Route route = MaterialPageRoute(
//           builder:(context)=>pageContentBuilder(
//               context,
//               arguments:settings.arguments
//           )
//       );
//       return route;
//     }
//     else{
//       final Route route = MaterialPageRoute(
//           builder: (context)=>pageContentBuilder(context)
//       );
//       return route;
//     }
//   }
// }
