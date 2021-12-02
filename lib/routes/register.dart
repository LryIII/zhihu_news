import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon:const Icon(Icons.arrow_back,color: Colors.black,),
        ),
        backgroundColor: Colors.white,
        title: const Text(
          "注册",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        children: const [
          Text(
            "用户名",
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.black,
            ),
          ),
          Text(
             "账号",
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.black,
            ),
          ),
          Text(
             "密码",
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
