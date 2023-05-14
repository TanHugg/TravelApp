import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_app/pages/main_page.dart';
import 'package:travel_app/pages/signup_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscureText = false;

  @override
  Widget build(BuildContext context) {
    //FORM LOGIN
    Size size = MediaQuery.of(context).size; //Thông số size của điện thoại
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Image.asset('assets/images/introduce.jpg',
              fit: BoxFit.cover, height: size.height, width: size.width),
          Positioned(
              child: Container(
            height: size.height,
            width: size.width,
            decoration: const BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.all(Radius.circular(40))),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(left: 30, top: 65),
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: OutlinedButton.styleFrom(
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(18),
                        backgroundColor: Colors.black12,
                      ),
                      child: const Icon(
                        Icons.arrow_back,
                        size: 35,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 60),
                    child: Column(
                      children: <Widget>[
                        Text('Login',
                            style: GoogleFonts.plusJakartaSans(
                                fontSize: 50, color: Colors.white)),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 40),
                          child: TextField(//ĐIỀN EMAIL(LOGIN)
                            style: GoogleFonts.plusJakartaSans(
                                fontSize: 22, color: Colors.white),
                            decoration: decoration('Email'),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: TextField(//ĐIỀN PASSWORD
                            style: GoogleFonts.plusJakartaSans(
                                fontSize: 22, color: Colors.white),
                            decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(11),
                                  borderSide:
                                      const BorderSide(color: Colors.white70),
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(11),
                                    borderSide: const BorderSide(
                                        color: Colors.white70)),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(11),
                                  borderSide:
                                      const BorderSide(color: Colors.white70),
                                ),
                                labelText: 'Password',
                                labelStyle:
                                    const TextStyle(color: Colors.white70),
                                suffixIcon: IconButton(
                                  icon: Icon(//BẬT/TẮT HIỂN THỊ MẬT KHẨU
                                    _obscureText
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.white,
                                  ),

                                  onPressed: () {
                                    setState(() {
                                      _obscureText = !_obscureText;
                                    });
                                  },
                                )),
                            obscuringCharacter: '*',
                            obscureText: !_obscureText,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(40),
                          child: SizedBox(
                            width: size.width * 2 / 3,
                            height: size.height * 1 / 17,
                            child: ElevatedButton(//NÚT LOGIN
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                        const MainPage()));
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xffFF5B5B),
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(22)))),
                              child: Text('Login',
                                  style: GoogleFonts.plusJakartaSans(
                                      fontSize: 25)),
                            ),
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Don’t have account? ',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white70,
                                ),
                              ),
                              TextSpan(//NÚTTẠOTÀIKHOẢN
                                text: 'Create now',
                                style: GoogleFonts.plusJakartaSans(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const SignUpPage()));
                                  },
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )),
        ],
      ),
    );
  }
}

InputDecoration decoration(String labelText) {
  return InputDecoration(
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(11),
      borderSide: const BorderSide(color: Colors.white70),
    ),
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(11),
        borderSide: const BorderSide(color: Colors.white70)),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(11),
      borderSide: const BorderSide(color: Colors.white70),
    ),
    labelText: labelText,
    labelStyle: const TextStyle(color: Colors.white70),
  );
}
