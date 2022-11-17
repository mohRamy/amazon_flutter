// import 'package:amazon_flutter/features/auth/auth_ctrl/auth_ctrl.dart';
// import 'package:get/get.dart';

// import '../../../common/utils/app_strings.dart';
// import '../../../common/utils/dimensions.dart';
// import 'package:flutter/material.dart';

// import '../../../common/utils/constants/global_variables.dart';
// import '../../../common/widgets/custom_button.dart';
// import '../../../common/widgets/custom_textfield.dart';



// class AuthScreen extends GetView<AuthCtrl> {
//   AuthScreen({Key? key}) : super(key: key);


//   final GlobalKey<FormState> _signUpFKey = GlobalKey<FormState>();
//   final GlobalKey<FormState> _signInFKey = GlobalKey<FormState>();

//   void signUpUser() {
//     controller.signUpUser(
//       name: controller.nameC.text,
//       email: controller.emailC.text,
//       password: controller.passwordC.text,
//     );
//   }

//   void signInUser() {
//     controller.signInUser(
//        controller.emailC.text,
//        controller.passwordC.text,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: GlobalVariables.greyBackgroundColor,
//       body: SafeArea(
//         child: Padding(
//           padding: EdgeInsets.all(Dimensions.height10 - 2),
//           child: GetBuilder<AuthCtrl>(
//             builder: (controller) {
//               return Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     AppString.welcome,
//                     style: TextStyle(
//                       fontSize: Dimensions.font20 + 2,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                   SizedBox(
//                     height: Dimensions.height10,
//                   ),
//                   ListTile(
//                     tileColor: controller.auth.value == Auth.signup
//                         ? GlobalVariables.backgroundColor
//                         : GlobalVariables.greyBackgroundColor,
//                     title: const Text(
//                       AppString.createAccount,
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     leading: Radio(
//                       activeColor: GlobalVariables.secondaryColor,
//                       value: Auth.signup,
//                       groupValue: controller.auth.value,
//                       onChanged: (Auth? val) {
//                         controller.onChanged(val);
//                       },
//                     ),
//                   ),
//                   if (controller.auth.value == Auth.signup)
//                     Container(
//                       padding: const EdgeInsets.all(8),
//                       color: GlobalVariables.backgroundColor,
//                       child: Form(
//                         key: _signUpFKey,
//                         child: Column(
//                           children: [
//                             CustomTextField(
//                               controller: controller.nameC,
//                               hintText: AppString.name,
//                             ),
//                             SizedBox(height: Dimensions.height10),
//                             CustomTextField(
//                               controller: controller.emailC,
//                               hintText: AppString.email,
//                             ),
//                             SizedBox(height: Dimensions.height10),
//                             CustomTextField(
//                               controller: controller.passwordC,
//                               hintText: AppString.password,
//                             ),
//                             SizedBox(height: Dimensions.height10),
//                             CustomButton(
//                               text: AppString.signUp,
//                               onTap: () {
//                                 if (_signUpFKey.currentState!.validate()) {
//                                   signUpUser();
//                                 }
//                               },
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                   ListTile(
//                     tileColor: controller.auth.value == Auth.signin
//                         ? GlobalVariables.backgroundColor
//                         : GlobalVariables.greyBackgroundColor,
//                     title: const Text(
//                       AppString.signInSub,
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     leading: Radio(
//                       activeColor: GlobalVariables.secondaryColor,
//                       value: Auth.signin,
//                       groupValue: controller.auth.value, // مكان اختيار كل الريديو
//                       onChanged: (Auth? val) {
//                         controller.onChanged(val);
//                       },
//                     ),
//                   ),
//                   if (controller.auth.value == Auth.signin)
//                     Container(
//                       padding: EdgeInsets.all(Dimensions.height10 - 2),
//                       color: GlobalVariables.backgroundColor,
//                       child: Form(
//                         key: _signInFKey,
//                         child: Column(
//                           children: [
//                             CustomTextField(
//                               controller: controller.emailC,
//                               hintText: AppString.email,
//                             ),
//                             SizedBox(height: Dimensions.height10),
//                             CustomTextField(
//                               controller: controller.passwordC,
//                               hintText: AppString.password,
//                             ),
//                             SizedBox(height: Dimensions.height10),
//                             CustomButton(
//                               text: AppString.signIn,
//                               onTap: () {
//                                 if (_signInFKey.currentState!.validate()) {
//                                   signInUser();
//                                 }
//                               },
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                 ],
//               );
//             }
//           ),
//         ),
//       ),
//     );
//   }
// }
