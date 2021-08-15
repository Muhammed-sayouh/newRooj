import 'package:flutter/material.dart';
import 'package:rooj/style/colors.dart';
import 'package:rooj/style/sizes.dart';

class MyTextFormFieldWithImage extends StatelessWidget {
  final String image;
  final String hint;
  final TextEditingController controller;
  final bool obscureText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  const MyTextFormFieldWithImage(
      {Key? key,
      required this.image,
      required this.hint,
      this.keyboardType,
      this.validator,
      required this.obscureText,
      required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      obscuringCharacter: '*',
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        prefixIcon: Container(
          width: 40,
          height: 40,
          margin: EdgeInsets.all(7),
          decoration: BoxDecoration(
            color: AppColors.textFieldIconBackColor,
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.all(9.0),
          child: SizedBox(
            width: 15,
            height: 15,
            child: Image.asset(image),
          ),
        ),
        filled: true,
        hintStyle: new TextStyle(color: Colors.grey[600]),
        hintText: hint,
        fillColor: Colors.white,
      ),
    );
  }
}

class MyTextFormFieldWithImageAndPerfix extends StatelessWidget {
  final String image;
  final String hint;
  final TextEditingController controller;
  final bool obscureText;
  final String suffix;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  const MyTextFormFieldWithImageAndPerfix(
      {Key? key,
      required this.image,
      required this.hint,
      this.keyboardType,
      this.validator,
      required this.obscureText,
      required this.suffix,
      required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      obscuringCharacter: '*',
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
          prefixIcon: Container(
            width: 40,
            height: 40,
            margin: EdgeInsets.all(7),
            decoration: BoxDecoration(
              color: AppColors.textFieldIconBackColor,
              borderRadius: BorderRadius.circular(30),
            ),
            padding: const EdgeInsets.all(9.0),
            child: SizedBox(
              width: 15,
              height: 15,
              child: Image.asset(image),
            ),
          ),
          filled: true,
          hintStyle: new TextStyle(color: Colors.grey[600]),
          hintText: hint,
          fillColor: Colors.white,
          suffixIcon: Padding(
            padding: EdgeInsets.only(top: height(context) * 0.015),
            child: Text(
              suffix,
              style: TextStyle(
                  color: AppColors.mainColor, fontWeight: FontWeight.bold),
            ),
          )),
    );
  }
}

class MyTextFormFieldWithPerfix extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final bool obscureText;
  final String suffix;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  const MyTextFormFieldWithPerfix(
      {Key? key,
      required this.hint,
      this.keyboardType,
      this.validator,
      required this.obscureText,
      required this.suffix,
      required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      obscuringCharacter: '*',
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
          filled: true,
          hintStyle: new TextStyle(color: Colors.grey[600]),
          hintText: hint,
          fillColor: Colors.white,
          suffixIcon: Padding(
            padding: EdgeInsets.only(top: height(context) * 0.015),
            child: Text(
              suffix,
              style: TextStyle(
                  color: AppColors.mainColor, fontWeight: FontWeight.bold),
            ),
          )),
    );
  }
}

class MyTextFormField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final bool obscureText;
  const MyTextFormField(
      {Key? key,
      required this.hint,
      required this.obscureText,
      required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      obscuringCharacter: '*',
      decoration: InputDecoration(
        filled: true,
        hintStyle: new TextStyle(color: Colors.grey[600]),
        hintText: hint,
        fillColor: Colors.white,
      ),
    );
  }
}

class MyBigTextFormField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final bool obscureText;
  const MyBigTextFormField(
      {Key? key,
      required this.hint,
      required this.obscureText,
      required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      obscuringCharacter: '*',
      maxLines: 5,
      decoration: InputDecoration(
        filled: true,
        hintStyle: new TextStyle(color: Colors.grey[600]),
        hintText: hint,
        fillColor: Colors.white,
      ),
    );
  }
}
