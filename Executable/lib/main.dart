import 'dart:convert';
import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:flutterapp3/UI/CustomInputField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:intl/intl.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';
import 'package:flutterapp3/UI/effect.dart';
import 'package:slide_popup_dialog/slide_popup_dialog.dart' as SlideDialog;
import 'dart:async';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'JSON/api.dart';
import 'JSON/PostSignUp.dart';
import 'package:http/http.dart' as http;
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:load/load.dart';
import 'package:link/link.dart';
import 'package:open_file/open_file.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(
    MyApp(),
);

String username= "";

Color c1 = const Color.fromRGBO(164, 205, 57, 100);
Color c2 = const Color.fromRGBO(208, 222, 63, 100);

bool isLoggedIn = false;

String name = '';
String password = '';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Loginpage(),
      theme : ThemeData(fontFamily: 'KoPubWorld',primaryColor:Colors.green),
    );
  }
}



class Loginpage extends StatefulWidget {
  @override
  _LoginpageState createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  TextEditingController Password = new TextEditingController();
  TextEditingController Id = new TextEditingController();
  static const Color transparent = Color(0x00000000);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child:Column(
              children: <Widget>[
                Container(
                    padding: EdgeInsets.only(left: 70,right: 70,top:90),
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 100.0),
                        Image.asset('lib/assets/login_logo2.png',),
                        SizedBox(height: 50.0),
                      ],
                    )
      ),
                Container(
                    padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                    child: Column(
                      children: <Widget>[
                        TextField(
                          controller: Id,
                          decoration: InputDecoration(
                              labelText: 'ID',
                              labelStyle: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey
                              ),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: c1)
                              ),
                          ),
                        ),

                        SizedBox(height: 10.0),
                        TextField(
                          controller: Password,
                          decoration: InputDecoration(
                            labelText: 'PW',
                            labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.grey
                            ),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: c1)
                            ),
                          ),
                          obscureText: true,
                        ),

                        SizedBox(height: 5.0),
                        Container(
                          child: Row(
                            children: <Widget>[
                              Container(
                                child: Checkbox(
                                  value:isLoggedIn,
                                  onChanged: (bool value){
                                    check_box(value);
                                    setState(() {
                                      isLoggedIn = value;
                                      print(isLoggedIn);
                                    });
                                  },
                                ),
                              ),
                              Container(
                                child:Text('auto login')
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 5.0,),
                        Container(
                          alignment: Alignment(1.0, 0.0),
                          padding: EdgeInsets.only(top: 15.0, left: 20.0),
                          child: InkWell(
                              onTap: () {
                                Navigator.push(context,
                                    FadeRoute(page: IDPW())
                                );
                              },
                              child: Text('Forget Password ?',
                                style: TextStyle(
                                    color: c1,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Montserrat',
                                    decoration: TextDecoration.underline
                                ),
                              )
                          ),
                        ),

                        SizedBox(height: 30.0),
                        Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end:Alignment.bottomRight,
                                    colors:[c1,c2]
                                )
                            ),
                            height: 50.0,
                            child: GestureDetector(
                              onTap: () {
                                loginUser();
                                postRequest();
                              },
                              child: Material(
                                color: transparent,
                                borderRadius: BorderRadius.circular(20.0),
                                child: Center(
                                  child: Text('Sign In',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Montserrat'
                                    ),
                                  ),
                                ),
                              ),)
                        ),
                      ],
                    )
                ),

                SizedBox(height: 50.0),
                Container(
                  child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'New to E-Receipt ?',
                      style: TextStyle(
                          fontFamily: 'Montserrat'
                      ),
                    ),
                    SizedBox(width: 5.0),
                    InkWell(
                      onTap: () {
                        Navigator.push(context,
                            FadeRoute(page: Register())
                        );
                      },
                      child: Text('Register',
                        style: TextStyle(
                            color: c1,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline
                        ),
                      ),
                    )
                  ],
                ),
                )
        ],
      )
          ),
        ],
      ),
    )
    );
  }

  Future<http.Response> postRequest() async {
    var url = 'http://dsc-ereceipt.appspot.com/api/auth/signin/';
    PostSignIn p = new PostSignIn(Id.text, Password.text);
    var body = jsonEncode(p.toJson());
    print("Body : " + body);
    http.post(url,
        headers: {"Content-type": "application/json"},
        body: body
    ).then((http.Response response) {
      print("Response status: ${response.statusCode}");
      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: '로그인 성공!');
        setState(() {
          username = Id.text;
        });
        Navigator.push(context,
            FadeRoute(page: MainPage())
        );
      } else if (response.statusCode == 400) {
        Fluttertoast.showToast(msg: '아이디 비밀번호가 맞지 않습니다');
      } else {
        Fluttertoast.showToast(msg: '관리자에게 문의하세요');
      }
      print("Response body: ${response.contentLength}");
      print(response.headers);
      print(response.request);
    });
  }

  @override
  void initState(){
    super.initState();
    autoLogIn();
  }

  void autoLogIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String userId = prefs.getString('username');
    final String userPassword = prefs.getString('userpassword');
    final bool isLoggin = prefs.getBool('isLoggin');
    print("dsadas $isLoggedIn");
    if (isLoggin==true) {
      setState(() {
        isLoggedIn = isLoggin;
        name = userId;
        password = userPassword;
        Id = new TextEditingController(text: name);
        Password = new TextEditingController(text: password);
        postRequest();
      });
      return;
    }
  }

  Future<Null> check_box(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggin', value);
  }

  Future<Null> logout() async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('username', null);
    prefs.setString('userpassword', null);

  }

  Future<Null> loginUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('username', Id.text);
    prefs.setString('userpassword', Password.text);

    setState(() {
      name = Id.text;
      password = Password.text;
    });

    Id.clear();
    Password.clear();
  }

  Future<bool> _onBackPressed(){
    exit(0);
    false;
  }


}

class IDPW extends StatefulWidget {
  @override
  _IDPWState createState() => _IDPWState();
}

class _IDPWState extends State<IDPW> {
  TextEditingController email = new TextEditingController();
  TextEditingController verify_code = new TextEditingController();
  static const Color transparent = Color(0x00000000);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
            Widget>[
          Container(
            padding: EdgeInsets.only(top: 110),
            child: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                  child: Text(
                    'Forgot your ID/PW ?',
                    style:
                    TextStyle(fontSize: 35.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          Container(
              padding: EdgeInsets.only(top: 25.0, left: 20.0, right: 20.0),
              child: Column(
                children: <Widget>[
                  TextField(
                    controller:email,
                    decoration: InputDecoration(
                        labelText: 'Type your EMAIL',
                        labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                        // hintText: 'EMAIL',
                        // hintStyle: ,
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green))),
                  ),
                  SizedBox(height: 30.0),
                  TextField(
                    controller:verify_code,
                    decoration: InputDecoration(
                        labelText: 'Enter verify code',
                        labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                        // hintText: 'EMAIL',
                        // hintStyle: ,
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green))),
                  ),
                  SizedBox(height: 30.0),
                  Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end:Alignment.bottomRight,
                              colors:[c1,c2]
                          )
                      ),
                      height: 40.0,
                    child: GestureDetector(
                        onTap: () {
                          postRequest();
                        },
                      child: Material(
                        color: transparent,
                          child: Center(
                            child: Text(
                              'Authenticate',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Montserrat'),
                            ),
                          ),
                      )
                    )
                  ),
                  SizedBox(height: 20.0),
                  Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end:Alignment.bottomRight,
                              colors:[c1,c2]
                          )
                      ),
                      height: 40.0,
                      child: GestureDetector(
                          onTap: () {
                            postRequestCode();
                          },
                          child: Material(
                            color: transparent,
                            child: Center(
                              child: Text(
                                'Search Password',
                              ),
                            ),
                          )
                      )
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    height: 40.0,
                    color: Colors.transparent,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end:Alignment.bottomRight,
                              colors:[c1,c2]
                          )
                      ),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child:

                        Center(
                          child: Text('Go Back',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Montserrat')),
                        ),


                      ),
                    ),
                  ),
                ],
              )),
        ]
        )
    );;
  }

  Future<http.Response> postRequest() async {
    var url = 'http://dsc-ereceipt.appspot.com/api/main/searchpw/';
    SearchPw s = new SearchPw(email.text);
    var body = jsonEncode(s.toJson());
    print("Body : " + body);
    http.post(url,
        headers: {"Content-type": "application/json"},
        body: body
    ).then((http.Response response) {
      print("Response status: ${response.statusCode}");
      if (response.statusCode == 201) {
        Fluttertoast.showToast(msg: '전송 성공');
      } else if (response.statusCode == 400) {
        Fluttertoast.showToast(msg: '이메일이 없습니다.');
      } else {
        Fluttertoast.showToast(msg: '관리자에게 문의하세요');
      }
      print("Response body: ${response.contentLength}");
      print(response.headers);
      print(response.request);
    });
  }

  Future<http.Response> postRequestCode() async {
    var url = 'http://dsc-ereceipt.appspot.com/api/main/searchpwcode/';
    SearchPwCode s = new SearchPwCode(email.text,verify_code.text);
    var body = jsonEncode(s.toJson());
    print("Body : " + body);
    http.post(url,
        headers: {"Content-type": "application/json"},
        body: body
    ).then((http.Response response) {
      print("Response status: ${response.statusCode}");
      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: '비밀번호는 ${response.body.trim().split(':')[1].split('"')[1]} 입니다',toastLength: Toast.LENGTH_LONG);
      } else if (response.statusCode == 400) {
        Fluttertoast.showToast(msg: '이메일이 없습니다.');
      } else {
        Fluttertoast.showToast(msg: '관리자에게 문의하세요');
      }
      print("Response body: ${response.contentLength}");
      print(response.headers);
      print(response.request);
      print(response.toString());
      print(response.body.trim().split(':')[1].split('"')[1]);
    });
  }

}


class MainPage extends StatefulWidget {
  final List<Result> Results;
  static const Color transparent = Color(0x00000000);
  MainPage({Key key, this.Results}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  double screenHeight;
  DateTime _dateTime1; //상세보기 날짜
  DateTime _dateTime2; //상세보기 날짜 2
  final format = DateFormat("yyyy-MM-dd"); //날짜 형식

  static const Color transparent = Color(0x00000000);

  TextEditingController Date1 = new TextEditingController();
  TextEditingController Date2 = new TextEditingController();
  TextEditingController Money = new TextEditingController();
  TextEditingController Won = new TextEditingController();
  String barcode= ""; //qr 바코드 주소
  final scaffoldkey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          title: Image.asset('lib/assets/login_logo2.png',width: 100,),
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              top(context),
              search1(context),
              lowerHalf(context),
            ],
          ),physics: NeverScrollableScrollPhysics(),
        ),
          floatingActionButton: new FloatingActionButton(
              backgroundColor: Colors.indigo,
              onPressed: scan,
              child: Icon(Icons.camera)),
    );
  }

  @override
  initState(){
    print(username);
    super.initState();
    Money.text = '0';
  }

  Widget top(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top:20.0),
      height: screenHeight / 5,
      child: Column(
          children:<Widget>[
            Container(
              child: TextField(
                textAlign: TextAlign.center,
                    controller: Money,
                    autofocus: false,
                    enabled: false,
                    decoration: new InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                    ),
                style:TextStyle(
                  fontSize: 40,
                  height: 2
                )
                  ),
              ),
          ],
          mainAxisAlignment: MainAxisAlignment.center
      ),
    );
  }
  Widget search1(BuildContext context){
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40)),
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end:Alignment.bottomRight,
              colors:[c1,c1]
          )
      ),
      height: screenHeight/14,
      child: Row(
              children:<Widget>[
          Container(
              width: 50,
              decoration: BoxDecoration(
              ),
              child: GestureDetector(
                onTap: () {
                  print("touch");
                },
                child: Material(
                  color: transparent,
                  borderRadius: BorderRadius.circular(20.0),
                  child: Center(
                    child: Text('Month', // 월별 데이터를 요청하는 부분
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontFamily: 'Montserrat'
                      ),
                    ),
                  ),
                ),)
          ),
          Container(
              width: 70,
              child: GestureDetector(
                onTap: () {
                  print("touch"); // 최신 날짜로 요청하는 부분
                },
                child: Material(
                  color: transparent,
                  borderRadius: BorderRadius.circular(20.0),
                  child: Center(
                    child: Text('Newest',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontFamily: 'Montserrat'
                      ),
                    ),
                  ),
                ),)
          ),
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    Select_date(context);
                  }
                )
        ],
        mainAxisAlignment: MainAxisAlignment.end,
      ),
    );
  }
  Widget lowerHalf(BuildContext context) {
    return Container(
      color: Colors.grey,
      height: 7*(screenHeight/10),
      child: FutureBuilder<List<Result>>(
        future: fetchResults(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? ResultsList(Results: snapshot.data)
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Future<void> Select_date(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Choose Date',textAlign: TextAlign.center,),
          content: Container(
            height: 90,
            child: Column(
              children: <Widget>[
                Container(
                  child:Row(
                   children: <Widget>[
                     IconButton(
                       icon: Icon(Icons.calendar_today),
                       onPressed: (){
                         showDatePicker(
                             context: context,
                             initialDate: DateTime.now(),
                             firstDate: DateTime(2001),
                             lastDate: DateTime(2021)
                         ).then((date){
                           setState(() {
                             _dateTime1 = date;
                             Date1.text = format.format(_dateTime1).toString();
                           });
                         });
                       },
                     ),
                     Container(
                       width:70,
                       child:TextField(
                         style:TextStyle(
                             fontSize: 10,
                         ),
                         controller: Date1,
                         autofocus: false,
                         enabled: false,
                         decoration: InputDecoration(
                           labelStyle: TextStyle(
                               fontFamily: 'Montserrat',
                               fontWeight: FontWeight.bold,
                               color: Colors.grey
                           ),
                           focusedBorder: UnderlineInputBorder(
                               borderSide: BorderSide(color: c1)
                           ),
                         ),
                       ),
                     ),
                     Text("~"),
                     IconButton(
                       icon: Icon(Icons.calendar_today),
                       onPressed: (){
                         showDatePicker(
                             context: context,
                             initialDate: DateTime.now(),
                             firstDate: DateTime(2001),
                             lastDate: DateTime(2021)
                         ).then((date){
                           setState(() {
                             _dateTime2 = date;
                             Date2.text =  format.format(_dateTime2).toString();
                           });
                         });
                       },
                     ),
                     Container(
                       width:70,
                       child:TextField(
                         style:TextStyle(
                           fontSize: 10,
                         ),
                         controller: Date2,
                         autofocus: false,
                         enabled: false,
                         decoration: InputDecoration(
                           labelStyle: TextStyle(
                               fontFamily: 'Montserrat',
                               fontWeight: FontWeight.bold,
                               color: Colors.grey
                           ),
                           focusedBorder: UnderlineInputBorder(
                               borderSide: BorderSide(color: c1)
                           ),
                         ),
                       ),
                     ),
                   ],
                  )
                )
              ],
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            )
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Search'),
              onPressed: () {
                Navigator.of(context).pop(); // 버튼 요청 부분
              },
            ),
          ],
        );
      },
    );
  }

  //qr인식
  Future scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      setState(() => this.barcode = barcode);
      print(barcode);
      postRequest(barcode);
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this.barcode = 'The user did not grant the camera permission!';
        });
      } else {
        setState(() => this.barcode = 'Unknown error: $e');
      }
    } on FormatException{
      setState(() => this.barcode = 'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      setState(() => this.barcode = 'Unknown error: $e');
    }
  }

  //영수증 나오는 부분
  void _showImageView(String Url){
    String url = 'https:'+Url; //영수증 이미지 URL
    print('Url : ${url}');
    showDialog(
        context: context,
      builder: (BuildContext){
          return WillPopScope(
            child:Scaffold(
              body: Column(
                children: <Widget>[
                  Container(
                    child: Column(
                        children: <Widget>[
                        Container(
                        child: Image.network(url), //이미지
                  ),
            ],
                    )
                  ),
                  Container(
                    child: Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.all(10.0),
                          height: 50,
                          width: 150,
                          child:GestureDetector(
                            onTap: (){
                              _saveNetworkImage(url);
                            },
                          child: Material(
                              borderRadius: BorderRadius.circular(20.0),
                              shadowColor: Colors.greenAccent,
                              color: c1,
                              elevation: 7.0,
                                child: Center(
                                  child: Text('저장하기',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Montserrat'
                                    ),
                                  ),
                                ),

                          ),
                          ),
                        ),
                        Container(
                          height: 50,
                          width: 150,
                          child:GestureDetector(
                            onTap: () {
                              print("push");
                              Navigator.pop(context);},
                            child: Material(
                                borderRadius: BorderRadius.circular(20.0),
                                shadowColor: Colors.greenAccent,
                                color: c1,
                                elevation: 7.0,
                                  child: Center(
                                    child: Text('나가기',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Montserrat'
                                      ),
                                    ),
                                  ),
                            ),
                          )
                        )
                      ],
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    ),
                  )
                ],
              ),
            ),

          );
      }
    );
  }

  void _saveNetworkImage(String url) async{
    String path = url;
    GallerySaver.saveImage(path).then((bool success){
      setState(() {
        print('Image is saved');
        Fluttertoast.showToast(msg: '이미지 저장 성공!');
      });
    });
  }

  Future<http.Response> postRequest(String Url) async {
    var url = Url.toString()+'/';
    check_user_link c = new check_user_link(username);
    var body = jsonEncode(c.toJson());
    print("Body : " + body);
    http.put(url,
        headers: {"Content-type": "application/json"},
        body: body
    ).then((http.Response response) {
      print("Response status: ${response.statusCode}");
      print("BoDY: ${response.body}");
      print(response.headers);
      print(response.request);
      print(response.body.trim().split(':')[1].split('"')[0]);
      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: '이미지 추출 성공');
        print(response.body.trim().split(':')[1].split('"')[0].toString());
        _showImageView(response.body.trim().split(':')[1].split('"')[0].toString());
      } else if (response.statusCode == 400) {
        Fluttertoast.showToast(msg: '이미지 추출에 실패함');
      } else {
        Fluttertoast.showToast(msg: '관리자에게 문의하세요');
      }
      print("Response body: ${response.contentLength}");
    });
  }

}

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  List<PostSignUp> PSU;

  TextEditingController Id = new TextEditingController();
  TextEditingController Password = new TextEditingController();
  TextEditingController First_Name = new TextEditingController();
  TextEditingController Last_Name = new TextEditingController();
  TextEditingController Email = new TextEditingController();

  static const Color transparent = Color(0x00000000);

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _backPressed,
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
          Container(
            child: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                  child: Text(
                    'Register',
                    style:
                    TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          Container(
              padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
              child: Column(
                children: <Widget>[
                  TextField(
                    controller:Id,
                    decoration: InputDecoration(
                        labelText: 'ID',
                        labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                        // hintText: 'EMAIL',
                        // hintStyle: ,
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green))),
                  ),
                  SizedBox(height: 10.0),
                  TextField(
                    controller:Password,
                    decoration: InputDecoration(
                        labelText: 'PASSWORD ',
                        labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green))),
                    obscureText: true,
                  ),
                  SizedBox(height: 10.0),
                  TextField(
                    controller:First_Name,
                    decoration: InputDecoration(
                        labelText: 'First_NAME',
                        labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green))),
                  ),
                  SizedBox(height: 10.0),
                  TextField(
                    controller:Last_Name,
                    decoration: InputDecoration(
                        labelText: 'Last_NAME',
                        labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green))),
                  ),
                  SizedBox(height: 10.0),
                  TextField(
                    controller:Email,
                    decoration: InputDecoration(
                        labelText: 'EMAIL',
                        labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green))),
                  ),
                  SizedBox(height: 30.0),
                  Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end:Alignment.bottomRight,
                              colors:[c1,c2]
                          )
                      ),
                      height: 40.0,
                      child:GestureDetector(
                        onTap: (){
                          postRequest();
                        },
                      child: Material(
                        color: transparent,
                          child: Center(
                            child: Text(
                              'Register',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Montserrat'),
                            ),
                          ),

                      ))
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end:Alignment.bottomRight,
                            colors:[c1,c2]
                        )
                    ),
                    height: 40.0,
                    child: Container(
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child:
                        Center(
                          child: Text('Go Back',
                              style: TextStyle(
                                color: Colors.black,
                                  fontFamily: 'Montserrat')),
                        ),
                      ),
                    ),
                  ),
                ],
              )),
        ]
        )
      )
      )
    );
  }
  Future<bool> _backPressed(){
    Navigator.push(context,
        FadeRoute(page: Loginpage())
    );
    false;
  }

  Future<http.Response> postRequest() async{
    var url = 'http://dsc-ereceipt.appspot.com/api/auth/signup/';
    PostSignUp p = new PostSignUp(Id.text, Password.text, First_Name.text,Last_Name.text ,Email.text);
    var body = jsonEncode(p.toJson());
    print("Body : "+ body);
    http.post(url,
        headers: {"Content-type":"application/json"},
        body: body
    ).then((http.Response response){
      print("Response status: ${response.statusCode}");
      if(response.statusCode==200){
        Fluttertoast.showToast(msg: '회원가입 성공!');
        Navigator.push(context,
            FadeRoute(page: Loginpage())
        );
      }else if(response.statusCode==400){
        Fluttertoast.showToast(msg: '중복된 아이디가 있습니다.');
      }else{
        Fluttertoast.showToast(msg: '관리자에게 문의하세요');
      }
      print("Response body: ${response.contentLength}");
      print(response.headers);
      print(response.request);
    });

  }

}

//리스트 주소 기본임
Future<List<Result>> fetchResults(http.Client client) async {
  final response =
  await client.get('http://dsc-ereceipt.appspot.com/api/main/receipt_list/'+username.trim()+'/');
  // compute 함수를 사용하여 parsePhotos를 별도 isolate에서 수행합니다.
  return compute(parseResults, response.body);
}

Future<List<Result>> fetchResultsTotalMoney(http.Client client) async {
  final response =
  await client.get('http://dsc-ereceipt.appspot.com/api/main/receipt/'+username.trim()+'/');
  // compute 함수를 사용하여 parsePhotos를 별도 isolate에서 수행합니다.
  return compute(parseResults, response.body);
}

List<Result> parseResults(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Result>((json) => Result.fromJson(json)).toList();
}

//결과 값 넣는 것
class Result {
  final int id;
  final int user;
  final String receipt_img_url;
  final String receipt_date;
  final int total_price;
  final String device_id;

  Result({this.id, this.user, this.receipt_img_url, this.receipt_date, this.total_price, this.device_id});

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      id: json['id'] as int,
      user: json['user'] as int,
      receipt_img_url: json['receipt_img_url'] as String,
      receipt_date: json['receipt_date'] as String,
      total_price: json['total_price'] as int,
      device_id: json['device_id'] as String,
    );
  }
}

class MoneyResult {
  final int total_price__sum;

  MoneyResult({this.total_price__sum});

  factory MoneyResult.fromJson(Map<String, dynamic> json) {
    return MoneyResult(
      total_price__sum: json['total_price__sum'] as int,
    );
  }
}

//리스트 출력 부분 리스트 뷰로 스크롤 가능
class ResultsList extends StatelessWidget {
  final List<Result> Results;
  static const Color transparent = Color(0x00000000);
  ResultsList({Key key, this.Results}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: Results.length,// < 8 ? 8 : Results.length,
      itemBuilder: (context, index) {
        return Container(
          color: transparent,
          child: ListTile(
            title: Container(
              height: 60,
              child: Row(
                children: <Widget>[
                  Text(Results[index].receipt_date.substring(5,10)),
                  SizedBox(width: 100,),
                  Text(Results[index].device_id.toString())
                ],
              ),
            ),
            trailing: Image.network(Results.length > index ? Results[index].receipt_img_url : ""),
            onLongPress: () => {
            SlideDialog.showSlideDialog(
              context: context,
              child: Expanded(
                child:Image.network(Results.length > index ? Results[index].receipt_img_url : "",fit: BoxFit.fill,),
              ),
              barrierColor: Colors.white.withOpacity(0.7),
              pillColor: c1,
              backgroundColor: Colors.white,
            )
            },
          )
        );
      },
    );
  }
}