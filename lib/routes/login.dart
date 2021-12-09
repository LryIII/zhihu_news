import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        title: const Text(
          "登录-知乎",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 100.0,
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Text(
                    "登录知乎",
                    style: TextStyle(
                      fontSize: 30.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "发现更多可信赖的解答",
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  TextField(
                    decoration: const InputDecoration(
                      hintText: "账号",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.account_circle),
                    ),
                    maxLength: 30, //最大长度，设置此项会让TextField右下角有一个输入数量的统计字符串
                    maxLines: 1, //最大行数
                    autocorrect: true, //是否自动更正
                    autofocus: true, //是否自动对焦
                    textAlign: TextAlign.start, //文本对齐方式
                    keyboardType: TextInputType.number,
                    style: const TextStyle(
                        fontSize: 15.0,
                        color: Colors.blue
                    ), //输入文本的样式允许的输入格式
                    onChanged: (text) {
                      //内容改变的回调
                      //print('change $text');
                    },
                    onSubmitted: (text) {
                      //内容提交(按回车)的回调
                      //print('submit $text');
                    },
                    enabled: true, //是否禁用
                  ),
                  TextField(
                    decoration: const InputDecoration(
                      hintText: "密码",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.assignment_turned_in_rounded)
                    ),
                    maxLength: 30, //最大长度，设置此项会让TextField右下角有一个输入数量的统计字符串
                    maxLines: 1, //最大行数
                    autocorrect: true, //是否自动更正
                    autofocus: true, //是否自动对焦
                    obscureText: true, //是否是密码
                    style: const TextStyle(
                        fontSize: 15.0,
                        color: Colors.blue
                    ), //输入文本的样式允许的输入格式
                    onChanged: (text) {
                      //内容改变的回调
                      //print('change $text');
                    },
                    onSubmitted: (text) {
                      //内容提交(按回车)的回调
                      //('submit $text');
                    },
                    enabled: true, //是否禁用
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/register');
                  },
                  child: const Text(
                    "注册",
                    style:
                      TextStyle(color: Colors.blueAccent, fontSize: 15.0),
                  )
                ),
                const SizedBox(
                  width: 30.0,
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const SizedBox(
                  width: 200,
                  height: 30,
                  child: Text(
                    "登录",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
