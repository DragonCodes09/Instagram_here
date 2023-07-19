import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insta_flutter/Screens/signUpScreen.dart';
import 'package:insta_flutter/resources/auth_methods.dart';
import 'package:insta_flutter/responsive/mobile_Screen_Layout.dart';
import 'package:insta_flutter/responsive/responsive_layout_src.dart';
import 'package:insta_flutter/responsive/web_Screen_Layout.dart';
import 'package:insta_flutter/utils/colours.dart';
import 'package:insta_flutter/utils/utils.dart';
import 'package:insta_flutter/widgets/text_fields_input.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _IsLoading = false;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void logginIn() async {
    setState(() {
      _IsLoading = true;
    });
    String R = await AuthMethods().loginUser(
        email: _emailController.text, pass: _passwordController.text);
    if (R != "Success") {
      showSnackBar(R, context);
    }
    setState(() {
      _IsLoading = false;
    });
  }

  void goToSignUp() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => SignUpScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // SvgPicture.asset('assets/images/ic_instagram.svg', color: primaryColor,height: 64,),
              Image.asset(
                'assets/images/Logo.png',
                width: 200,
                height: 200,
              ),
              const SizedBox(
                height: 24,
              ),
              Text(
                'Dragon Insta',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.w600),
              ),
              //image
              const SizedBox(
                height: 64,
              ),
              TextFieldInput(
                  textEditingController: _emailController,
                  textInputType: TextInputType.emailAddress,
                  hintText: 'Enter Your Email Address'),
              //Email
              const SizedBox(
                height: 24,
              ),
              TextFieldInput(
                textEditingController: _passwordController,
                textInputType: TextInputType.text,
                hintText: 'Enter Your Password',
                IsPass: true,
              ),
              //Pass
              const SizedBox(
                height: 24,
              ),
              InkWell(
                onTap: () {
                  logginIn();
                    Navigator.of(context)
                        .pushReplacement(MaterialPageRoute(builder: (context) => const ResponsiveLayout(webScreenLayout: WebScreenLayout(), mobileScreenLayout: MobileScreenLayout())));
                  print("Clicked !!");
                },
                child: Container(
                  child: _IsLoading
                      ? Center(
                          child: const CircularProgressIndicator(
                          color: primaryColor,
                        ))
                      : Text('Flame It'),
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: 12),
                  decoration: const ShapeDecoration(
                      color: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)))),
                ),
              ),
              Flexible(
                child: Container(),
                flex: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: const Text('New here ?'),
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  ),
                  GestureDetector(
                    onTap: goToSignUp,
                    child: Container(
                      child: const Text(
                        ' Sign Up.',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 8),
                    ),
                  ),
                ],
              )
              //button
            ],
          ),
        ),
      ),
    );
  }
}
