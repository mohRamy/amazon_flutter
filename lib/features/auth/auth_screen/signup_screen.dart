import '../../../core/utils/components/components.dart';
import '../../../core/widgets/app_text_button.dart';
import '../../../core/widgets/custom_button.dart';
import '../auth_ctrl/auth_ctrl.dart';
import '../../../config/routes/app_pages.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_strings.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/widgets/app_icon.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/custom_loader.dart';

class SignUpScreen extends GetView<AuthCtrl> {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void _registration(AuthCtrl authCtrl) {
      String email = controller.emailUC.text.trim();
      String password = controller.passwordUC.text.trim();
      String name = controller.nameUC.text.trim();
      String phone = controller.phoneUC.text.trim();

      if (email.isEmpty) {
        Components.showCustomSnackBar(
          'Type in your email address',
          title: 'Email address',
        );
      } else if (!GetUtils.isEmail(email)) {
        Components.showCustomSnackBar(
          'Type in a valid email address',
          title: 'Valid email address',
        );
      } else if (password.isEmpty) {
        Components.showCustomSnackBar(
          'Type in your password',
          title: 'password',
        );
      } else if (password.length < 6) {
        Components.showCustomSnackBar(
          'Password can not less than six characters',
          title: 'password',
        );
      } else if (name.isEmpty) {
        Components.showCustomSnackBar(
          'Type in your name',
          title: 'Name',
        );
      } else if (phone.isEmpty) {
        Components.showCustomSnackBar(
          'Type in your phone number',
          title: 'Phone number',
        );
      } else {
        authCtrl.signUpUser(
          name: name,
          email: email,
          password: password,
          phone: phone,
        );
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthCtrl>(
        builder: (authCtrl) => !authCtrl.isLoading
            ? SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(
                      height: Dimensions.screenHeight * 0.05,
                    ),
                    //app logo
                    SizedBox(
                      height: Dimensions.screenHeight * 0.25,
                      child: Center(
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 80,
                          child: AppIcon(
                            onTap: () {},
                            icon: Icons.person,
                            backgroundColor: AppColors.mainColor,
                            iconColor: Colors.white,
                            iconSize: Dimensions.height45 + Dimensions.height30,
                            size: Dimensions.height15 * 10,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: Dimensions.width20),
                      child: Column(
                        children: [
                          //name
                          AppTextField(
                            textController: controller.nameUC,
                            hintText: 'Name',
                            icon: Icons.person,
                          ),
                          SizedBox(
                            height: Dimensions.height20,
                          ),
                          //email
                          AppTextField(
                            keyboardType: TextInputType.emailAddress,
                            textController: controller.emailUC,
                            hintText: 'Email',
                            icon: Icons.email,
                          ),
                          SizedBox(
                            height: Dimensions.height20,
                          ),
                          //password
                          GetBuilder<AuthCtrl>(builder: (authCtrl) {
                            return AppTextField(
                              textController: controller.passwordUC,
                              hintText: 'Password',
                              icon: Icons.password,
                              isObscure: authCtrl.isObscure,
                              suffixIcon: InkWell(
                                onTap: () {
                                  authCtrl.changeObsure();
                                },
                                child: Icon(
                                  authCtrl.isObscure
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                  color: AppColors.yellowColor,
                                ),
                              ),
                            );
                          }),
                          SizedBox(
                            height: Dimensions.height20,
                          ),
                          //phone
                          AppTextField(
                            textController: controller.phoneUC,
                            hintText: 'Phone',
                            icon: Icons.phone,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Dimensions.height20,
                    ),
                    
                    AppTextButton(
                        txt: AppString.SIGN_UP,
                        onTap: () {
                          _registration(authCtrl);
                        },
                      ),
                    
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    //tag line
                    RichText(
                      text: TextSpan(
                        text: 'Have an account already? ',
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: Dimensions.font20,
                        ),
                        children: [
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => Get.toNamed(Routes.SIGN_IN),
                            text: AppString.SIGN_IN,
                            style: TextStyle(
                              color: AppColors.mainBlackColor,
                              fontSize: Dimensions.font20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Dimensions.screenHeight * 0.05,
                    ),
                    //sign up options
                    RichText(
                      text: TextSpan(
                        text: 'Sign up using one of the following methods',
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: Dimensions.font16,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : const CustomLoader(),
      ),
    );
  }
}
