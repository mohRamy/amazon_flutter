import 'package:flutter/material.dart';

import '../app_colors.dart';

class Components{
  static Padding customBtn({
    Function? onPressed,
    BuildContext? context,
    required String txt,
    Color primary = Colors.blue,
  }) =>
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(500, 50),
            primary: AppColors.tabColor,
          ),
          onPressed: () {
            onPressed!();
          },
          child: Text(
            txt,
            style: const TextStyle(fontSize: 15.0),
          ),
        ),
      );

  static Padding customTextField({
    TextEditingController? controller,
    required String hint,
    Widget? suffixIcon,
    Widget? prefixIcon,
    var validator,
    bool isobscure = false,
    var onsubmit,
    Function()? onTap,
    bool isread = false,
    double contentPadding = 10.0,
    fillColor = Colors.grey,
    double borderRadius = 10.0,
  }) =>
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: TextFormField(
          onFieldSubmitted: onsubmit,
          scrollPadding: const EdgeInsets.only(top: 10.0),
          readOnly: isread,
          onTap: onTap,
          controller: controller,
          decoration: InputDecoration(
            prefixIcon: prefixIcon,
            contentPadding: EdgeInsets.all(contentPadding),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.tabColor),
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.tabColor),
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            fillColor: fillColor,
            filled: true,
            hintStyle: TextStyle(
              color: Colors.grey[700],
            ),
            hintText: hint,
            suffixIcon: suffixIcon,
          ),
          validator: validator,
          obscureText: isobscure,
        ),
      );

      static void showErrorDialog({
    required BuildContext context,
    required String msg,
  }) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(
                msg,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  style: TextButton.styleFrom(
                    primary: Colors.black,
                    textStyle: const TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: const Text('OK'),
                ),
              ],
            ));
  }

  static void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
    ),
  );
}

  static void navigateTo(context, routes, arguments) =>
      Navigator.pushNamed(context, routes, arguments: arguments);

  static void navigateAndFinish(context, routes, arguments) =>
      Navigator.pushNamedAndRemoveUntil(
        context,
        routes,
        arguments: arguments,
        (Route<dynamic> route) => false,
      );
}