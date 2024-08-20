import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:one_store/mainpage.dart';
import 'package:one_store/page/register/registerscreen.dart';
import 'package:one_store/page/home/homescreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:one_store/SQLite/sqlite.dart';
import '../../data/model/users.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //We need two text editing controller

  //TextEditing controller to control the text when we enter into it
  final username = TextEditingController();
  final password = TextEditingController();

  //A bool variable for show and hide password
  bool isVisible = false;

  //Here is our bool variable
  bool isLoginTrue = false;

  final db = DatabaseHelper();

  //Now we should call this function in login button
  login() async {
    var response = await db
        .login(Users(usrName: username.text, usrPassword: password.text));
    if (response == true) {
      //If login is correct, then goto notes
      if (!mounted) return;
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Mainpage()));
    } else {
      //If not, true the bool value to show error message
      setState(() {
        isLoginTrue = true;
      });
      showAlertDialog(context);
    }
  }

  void showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Lỗi đăng nhập"),
          content: Text("Tài khoản hoặc mật khẩu không đúng"),
          actions: [
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  //We have to create global key for our form
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  SizedBox(
                    width: MediaQuery.of(context)
                        .size
                        .width, // Chiều rộng bằng với màn hình
                    child: Image.asset(
                      "assets/layout/layout_1.png",
                      fit: BoxFit.cover, // Hình ảnh sẽ được kéo giãn để phủ kín
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 50.0, bottom: 16.0, right: 10.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ElevatedButton(
                            onPressed: () {
                              // Xử lý khi nút đăng nhập được nhấn
                            },
                            style: ElevatedButton.styleFrom(
                              fixedSize: Size(130, 20), // Đặt kích thước 100x50
                              backgroundColor: const Color(0xFFF3B664),
                            ),
                            child: const Text(
                              'Đăng nhập',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          const SizedBox(width: 15), // Khoảng cách giữa hai nút
                          ElevatedButton(
                            onPressed: () {
                              // Xử lý khi nút đăng ký được nhấn
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RegisterScreen(),
                                  ));
                            },
                            style: ElevatedButton.styleFrom(
                              fixedSize: Size(130, 20), // Đặt kích thước 100x50
                              backgroundColor:
                                  Color.fromARGB(255, 255, 255, 255),
                            ),
                            child: const Text(
                              'Đăng ký',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Image.asset(
                "assets/image/logo_1.png",
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 20),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 15),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white.withOpacity(.2),
                        border: Border.all(
                          width: 1,
                          color: const Color(0xFFEC8F5E),
                        ),
                      ),
                      child: TextFormField(
                        controller: username,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Không được để trống tài khoản";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          hintText: "Tài khoản",
                          hintStyle: TextStyle(
                            color: Color(0xFFEC8F5E), // Đặt màu cho hint text
                          ),
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.person,
                            color: Color(0xFFEC8F5E),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
                    //Password field
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white.withOpacity(.2),
                        border: Border.all(
                          width: 1,
                          color: const Color(0xFFEC8F5E),
                        ),
                      ),
                      child: TextFormField(
                        controller: password,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Không được để trống tài khoản";
                          }
                          return null;
                        },
                        obscureText: !isVisible,
                        decoration: InputDecoration(
                            prefixIcon:
                                Icon(Icons.lock, color: Color(0xFFEC8F5E)),
                            border: InputBorder.none,
                            hintText: "Mật khẩu",
                            hintStyle: TextStyle(color: Color(0xFFEC8F5E)),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  //In here we will create a click to show and hide the password a toggle button
                                  setState(() {
                                    //toggle button
                                    isVisible = !isVisible;
                                  });
                                },
                                icon: Icon(
                                  isVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Color(0xFFEC8F5E),
                                ))),
                      ),
                    ),

                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 30.0,
                              top:
                                  15.0), // Thêm padding xung quanh radio button
                          // child: Radio(
                          //   value: true,
                          //   groupValue: isRememberMe,
                          //   onChanged: (bool? value) {
                          //     setState(() {
                          //       isRememberMe = value;
                          //     });
                          //   },
                          //   activeColor: const Color(0xFFEC8F5E),
                          // ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(
                              top: 15), // Thêm padding phía trên cho Text
                          child: Text('Nhớ tôi'),
                        ),

                        const Spacer(), // Sử dụng Spacer để tạo khoảng trống
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 30.0,
                              top: 15), // Thêm padding xung quanh InkWell
                          child: InkWell(
                            onTap: () {
                              // Điều hướng đến trang "Tôi quên mật khẩu"
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (context) => ForgotPasswordPage()),
                              // );
                            },
                            child: const Text(
                              'Quên mật khẩu?',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),
                    //Login button
                    Container(
                      height: 60,
                      width: MediaQuery.of(context).size.width * .9,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Color(0xFFEC8F5E)),
                      child: ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            //Login method will be here
                            login();

                            //Now we have a response from our sqlite method
                            //We are going to create a user
                          }
                        },
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                          ),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color(0xFFEC8F5E)),
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                        ),
                        child: const Text(
                          'ĐĂNG NHẬP',
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Row(
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left:
                                        60.0), // Thay đổi giá trị 8.0 để điều chỉnh padding bên trái
                                child: Divider(
                                  color: Colors.black,
                                  thickness: 2,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text('Đăng nhập với',
                                  style: TextStyle(fontSize: 16)),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(
                                    right:
                                        60.0), // Thay đổi giá trị 8.0 để điều chỉnh padding bên trái
                                child: Divider(
                                  color: Colors.black,
                                  thickness: 2,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                            height: 10), // Khoảng cách giữa chữ và nút
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            InkWell(
                              onTap: () {
                                // Xử lý đăng nhập với Facebook
                              },
                              child: Image.asset(
                                'assets/image/Facebook.png',
                                width: 100,
                                height: 100,
                              ),
                            ),
                            const SizedBox(width: 30),
                            InkWell(
                              onTap: () {
                                // Xử lý đăng nhập với Google
                              },
                              child: Image.asset(
                                'assets/image/Google.png',
                                width: 100,
                                height: 100,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    isLoginTrue
                        ? const Text(
                            "Tài khoản hoặc mật khẩu không đúng",
                            style: TextStyle(color: Colors.red),
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
