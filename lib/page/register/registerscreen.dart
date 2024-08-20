import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:one_store/page/login/loginscreen.dart';
import '../../data/model/users.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:one_store/SQLite/sqlite.dart';
//RegisterScreen

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final username = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  final formKey = GlobalKey<FormState>();

  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //SingleChildScrollView to have an scrol in the screen
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 70.0, bottom: 16.0, right: 10.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
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
                          backgroundColor: const Color(0xFFF3B664),
                        ),
                        child: const Text(
                          'Đăng ký',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(width: 15), // Khoảng cách giữa hai nút
                      ElevatedButton(
                        onPressed: () {
                          // Xử lý khi nút đăng nhập được nhấn
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginScreen(),
                              ));
                        },
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(130, 20), // Đặt kích thước 100x50
                          backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                        ),
                        child: const Text(
                          'Đăng nhập',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: EdgeInsets.only(left: 30.0, right: 100.0),
                child: RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: 'TRỞ THÀNH HỘI VIÊN CỦA ONE STORE  ',
                        style: TextStyle(
                          fontSize: 40,
                          color: Color(0xFFEC8F5E),
                          fontWeight: FontWeight.bold,
                          height: 1.5,
                          shadows: [
                            Shadow(
                              offset: Offset(1.0, 4.0),
                              blurRadius: 10.0,
                              color: Color.fromARGB(45, 0, 0, 0),
                            ),
                            // Thêm bóng khác nếu cần
                          ],
                        ),
                      ),
                      WidgetSpan(
                          child: Image.asset('assets/image/iconregister.png')),
                      // Thêm WidgetSpan khác cho icon người nếu cần
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //As we assigned our controller to the textformfields

                      Container(
                        margin: EdgeInsets.all(8),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                            bottomLeft: Radius.circular(15),
                          ),
                          border: Border.all(
                            width: 1,
                            color: const Color(0xFFEC8F5E),
                          ),
                        ),
                        child: TextFormField(
                          controller: username,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Không được bỏ trống họ tên";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            hintText: "Họ tên",
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

                      //Password field
                      Container(
                        margin: const EdgeInsets.all(8),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                            bottomLeft: Radius.circular(15),
                          ),
                          border: Border.all(
                            width: 1,
                            color: const Color(0xFFEC8F5E),
                          ),
                        ),
                        child: TextFormField(
                          controller: password,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Không được để trống mật khẩu";
                            }
                            return null;
                          },
                          obscureText: !isVisible,
                          decoration: InputDecoration(
                            hintText: "Mật khẩu",
                            hintStyle: TextStyle(color: Color(0xFFEC8F5E)),
                            border: InputBorder.none,
                            prefixIcon:
                                Icon(Icons.lock, color: Color(0xFFEC8F5E)),
                            suffixIcon: IconButton(
                              onPressed: () {
                                //In here we will create a click to show and hide the password a toggle button
                                setState(() {
                                  //toggle button
                                  isVisible = !isVisible;
                                });
                              },
                              icon: Icon(isVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              color: Color(0xFFEC8F5E),
                            ),
                          ),
                        ),
                      ),

                      //Confirm Password field
                      // Now we check whether password matches or not
                      Container(
                        margin: const EdgeInsets.all(8),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                            bottomLeft: Radius.circular(15),
                          ),
                          border: Border.all(
                            width: 1,
                            color: const Color(0xFFEC8F5E),
                          ),
                        ),
                        child: TextFormField(
                          controller: confirmPassword,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "password is required";
                            } else if (password.text != confirmPassword.text) {
                              return "Passwords don't match";
                            }
                            return null;
                          },
                          obscureText: !isVisible,
                          decoration: InputDecoration(
                            hintText: "Xác nhận mật khẩu",
                            hintStyle: TextStyle(color: Color(0xFFEC8F5E)),
                            border: InputBorder.none,
                            prefixIcon:
                                Icon(Icons.lock, color: Color(0xFFEC8F5E)),
                            suffixIcon: IconButton(
                              onPressed: () {
                                //In here we will create a click to show and hide the password a toggle button
                                setState(() {
                                  //toggle button
                                  isVisible = !isVisible;
                                });
                              },
                              icon: Icon(isVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              color: Color(0xFFEC8F5E),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),
                      //Login button
                      Container(
                        height: 60,
                        width: MediaQuery.of(context).size.width * .9,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Color(0xFFEC8F5E)),
                        child: TextButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                //Login method will be here

                                final db = DatabaseHelper();
                                db
                                    .signup(Users(
                                        usrName: username.text,
                                        usrPassword: password.text))
                                    .whenComplete(() {
                                  //After success user creation go to login screen
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginScreen()));
                                });
                              }
                            },
                            child: const Text(
                              "ĐĂNG KÝ",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 24),
                            )),
                      ),

                      //Sign up button
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
