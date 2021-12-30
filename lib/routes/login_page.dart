import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

// class LoginPage extends StatelessWidget {
//   const LoginPage({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: HomePage(),
//     );
//   }
// }

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<LoginPage> {
  //用户名输入框的焦点控制
  final FocusNode _userNameFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  //文本输入框控制器
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  //Stream 更新操作控制器
  final StreamController<String?> _userNameStream = StreamController();
  final StreamController<String?> _userPasswordStream = StreamController();

  Map<String?,String?> loginForm={
    "000":"123456",
    "001":"123456"
  };
  String? passWord,userName;
  @override
  Widget build(BuildContext context) {
    //手势识别点击空白隐藏键盘
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorObservers: [FlutterSmartDialog.observer],
      builder: FlutterSmartDialog.init(),

      home: GestureDetector(
        onTap: () {
          hindKeyBoarder();
        },
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                // Navigator.of(context).pushAndRemoveUntil(
                //     MaterialPageRoute(
                //         builder: (context)=>const HomeContent()
                //     ),
                //     (route) => route==null,
                // );

                //Navigator.popUntil(context, (route) => false);
                userName=' ';
                passWord='';
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
          //登录页面的主体
          resizeToAvoidBottomInset: false,
          body: buildLoginWidget(),
        ),
      ),
    );
  }

//登录页面的主体
  Widget buildLoginWidget() {
    return SingleChildScrollView(
      child: Column(
        children: [
          buildImage(),
          //用户名输入框
          buildUserNameWidget(),
          const SizedBox(height: 10,),
          //用户密码输入框
          buildUserPasswordWidget(),
          const SizedBox(height: 40,),
          //登录按钮
          SizedBox(
            width: 200,
            height: 40,
            child:ElevatedButton(
              onPressed: () {
                  //Navigator.pop(context);
                  checkLoginFunction();
                },
              child: const SizedBox(
                width: 100,
                height: 30,
                child: Text(
                  "登录",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                )
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildImage() {
    return Container(
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
    );
  }

  StreamBuilder<String?> buildUserPasswordWidget() {
    return StreamBuilder<String?>(
      stream: _userPasswordStream.stream,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              focusNode: _passwordFocusNode,
              controller: _passwordController,
              onSubmitted: (String value) {
                if (checkUserPassword()) {
                  loginFunction();
                } else {
                  FocusScope.of(context).requestFocus(_passwordFocusNode);
                }
              },
              onChanged: (data){
                if(checkUserPassword()){
                  passWord=data;
                }
              },
              //隐藏输入的文本
              obscureText: true,
              //最大可输入1行
              maxLines: 1,
              //边框样式设置
              decoration: InputDecoration(
                labelText: "密码",
                errorText: snapshot.data,
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            //),
        ),
          );
      },
    );
  }

  ///用户名输入框 Stream 局部更新 error提示
  ///     ShakeAnimationWidget 抖动动画
  ///
  StreamBuilder<String?> buildUserNameWidget() {
    return StreamBuilder<String?>(
      stream: _userNameStream.stream,
      builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
        return
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              //焦点控制
              focusNode: _userNameFocusNode,
              //文本控制器
              controller: _userNameController,
              //键盘回车键点击回调
              onSubmitted: (String value) {
                //点击校验，如果有内容输入 输入焦点跳入下一个输入框
                if (checkUserName()) {
                  _userNameFocusNode.unfocus();
                  //print(userName);
                  FocusScope.of(context).requestFocus(_passwordFocusNode);
                } else {
                  FocusScope.of(context).requestFocus(_userNameFocusNode);
                }
              },
              onChanged: (data){
                if(checkUserName()){
                  userName=data;
                }
              },
              //边框样式设置
              decoration: InputDecoration(
                //红色的错误提示文本
                errorText: snapshot.data,
                labelText: "用户名",
                //设置上下左右 都有边框
                //设置四个角的弧度
                border: const OutlineInputBorder(
                  //设置边框四个角的弧度
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
          );
      },
    );
  }

  void checkLoginFunction() {
    hindKeyBoarder();

    checkUserName();

    checkUserPassword();

    loginFunction();
  }

  bool checkUserName() {
    //获取输入框中的输入文本
    String userName = _userNameController.text;
    if (userName.isEmpty) {
      //Stream 事件流更新提示文案
      _userNameStream.add("请输入用户名");
      //抖动动画开启
      //_userNameAnimation.start();
      return false;
    } else {
      //清除错误提示
      _userNameStream.add(null);
      return true;
    }
  }

  bool checkUserPassword() {
    String userPassrowe = _passwordController.text;
    if (userPassrowe.length < 6) {
      _userPasswordStream.add("请输入标准密码");
      //_userPasswordAnimation.start();
      return false;
    } else {
      _userPasswordStream.add(null);
      return true;
    }
  }

  void hindKeyBoarder() {
    //输入框失去焦点
    _userNameFocusNode.unfocus();
    _passwordFocusNode.unfocus();

    //隐藏键盘
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

  void loginFunction() {
    if(loginForm[userName]==passWord){
      userName=' ';
      passWord='';
      Navigator.pop(context);
    }
    else if(loginForm[userName]==null){
      SmartDialog.showToast(
        "账号不存在",
        time: const Duration(milliseconds: 1000),
      );
    }else{
      SmartDialog.showToast(
        "账号或密码错误",
        time: const Duration(milliseconds: 1000),
      );
    }
  }
}