import '../../../common/utils/app_strings.dart';
import '../../../common/utils/dimensions.dart';
import '../services/auth_service.dart';
import 'package:flutter/material.dart';

import '../../../common/utils/constants/global_variables.dart';
import '../../../common/widgets/custom_button.dart';
import '../../../common/widgets/custom_textfield.dart';

String x = 'moh ammed\\s malo masary moh';
String z = 'n';
String c = x.substring(3, 0); // 20.
int y = 3;

enum Auth {
  signin,
  signup,
}

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Auth _auth = Auth.signup;
  final GlobalKey<FormState> _signUpFKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _signInFKey = GlobalKey<FormState>();

  final AuthService authService = AuthService();

  final TextEditingController _emailC = TextEditingController();
  final TextEditingController _passwordC = TextEditingController();
  final TextEditingController _nameC = TextEditingController();

  void signUpUser() {
    authService.signUpUser(
      context: context,
      name: _nameC.text,
      email: _emailC.text,
      password: _passwordC.text,
    );
  }

  void signInUser() {
    authService.signInUser(
      context: context,
      email: _emailC.text,
      password: _passwordC.text,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _emailC.dispose();
    _passwordC.dispose();
    _nameC.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariables.greyBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(context.height10 - 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppString.welcome,
                style: TextStyle(
                  fontSize: context.font20 + 2,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: context.height10,
              ),
              ListTile(
                tileColor: _auth == Auth.signup
                    ? GlobalVariables.backgroundColor
                    : GlobalVariables.greyBackgroundColor,
                title: const Text(
                  AppString.createAccount,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                leading: Radio(
                  activeColor: GlobalVariables.secondaryColor,
                  value: Auth.signup,
                  groupValue: _auth,
                  onChanged: (Auth? val) {
                    setState(() {
                      _auth = val!;
                    });
                  },
                ),
              ),
              if (_auth == Auth.signup)
                Container(
                  padding: const EdgeInsets.all(8),
                  color: GlobalVariables.backgroundColor,
                  child: Form(
                    key: _signUpFKey,
                    child: Column(
                      children: [
                        CustomTextField(
                          controller: _nameC,
                          hintText: AppString.name,
                        ),
                        SizedBox(height: context.height10),
                        CustomTextField(
                          controller: _emailC,
                          hintText: AppString.email,
                        ),
                        SizedBox(height: context.height10),
                        CustomTextField(
                          controller: _passwordC,
                          hintText: AppString.password,
                        ),
                        SizedBox(height: context.height10),
                        CustomButton(
                          color: Colors.blue,
                          text: AppString.signUp,
                          onTap: () {
                            if (_signUpFKey.currentState!.validate()) {
                              signUpUser();
                            }
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ListTile(
                tileColor: _auth == Auth.signin
                    ? GlobalVariables.backgroundColor
                    : GlobalVariables.greyBackgroundColor,
                title: const Text(
                  AppString.signInSub,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                leading: Radio(
                  activeColor: GlobalVariables.secondaryColor,
                  value: Auth.signin,
                  groupValue: _auth, // مكان اختيار كل الريديو
                  onChanged: (Auth? val) {
                    setState(() {
                      _auth = val!;
                    });
                  },
                ),
              ),
              if (_auth == Auth.signin)
                Container(
                  padding: EdgeInsets.all(context.height10 - 2),
                  color: GlobalVariables.backgroundColor,
                  child: Form(
                    key: _signInFKey,
                    child: Column(
                      children: [
                        CustomTextField(
                          controller: _emailC,
                          hintText: AppString.email,
                        ),
                        SizedBox(height: context.height10),
                        CustomTextField(
                          controller: _passwordC,
                          hintText: AppString.password,
                        ),
                        SizedBox(height: context.height10),
                        CustomButton(
                          color: Colors.blue,
                          text: AppString.signIn,
                          onTap: () {
                            if (_signInFKey.currentState!.validate()) {
                              signInUser();
                            }
                          },
                        )
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
