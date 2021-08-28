import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:rooj/customeWidget/bkAuth.dart';
import 'package:rooj/customeWidget/buttons.dart';
import 'package:rooj/customeWidget/dialogs.dart';
import 'package:rooj/providerModel/auth.dart';
import 'package:rooj/screens/registerForClient/registerForClient.dart';
import 'package:rooj/style/colors.dart';
import 'package:rooj/style/sizes.dart';

class PinCodeScreen extends StatefulWidget {
  final int? code;
  final String phone;
  const PinCodeScreen({Key? key, required this.code, required this.phone})
      : super(key: key);
  @override
  _PinCodeScreenState createState() => _PinCodeScreenState();
}

class _PinCodeScreenState extends State<PinCodeScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController code = TextEditingController();

  Future<void> _submit() async {
    bool auth = Provider.of<Auth>(context, listen: false).correctCode;
    if (!_formKey.currentState!.validate()) {
      return;
    }
    showDaialogLoader(context);
    try {
      auth = await Provider.of<Auth>(context, listen: false).ceckCode(
        code.text,
      );
    } on HttpExeption catch (error) {
      print(error);
      Navigator.of(context).pop();
      showErrorDaialog('wrong code'.tr, context);
    } catch (error) {
      print(error);
      Navigator.of(context).pop();
      showErrorDaialog("NoInternet".tr, context);
    } finally {
      if (auth) {
        Get.to(
            () => RegisterForClientScreen(
                  phone: widget.phone,
                ),
            transition: Transition.zoom);
      }
    }
  }

  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) =>
        customSnackBar(title: 'code', content: widget.code.toString()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.code);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          MainAuthImage(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Center(
                    child: Text(
                      'enter code'.tr,
                      style: TextStyle(
                          color: AppColors.mainColor,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: width(context) * 0.2),
                    child: Directionality(
                      textDirection: TextDirection.ltr,
                      child: Form(
                        key: _formKey,
                        child: PinCodeTextField(
                          controller: code,
                          appContext: context,
                          length: 4,
                          onChanged: (val) {},
                          cursorColor: AppColors.mainColor,
                          enableActiveFill: true,
                          keyboardType: TextInputType.number,
                          pinTheme: PinTheme(
                            shape: PinCodeFieldShape.circle,
                            inactiveColor: AppColors.mainColor,
                            activeColor: AppColors.mainColor,
                            activeFillColor: AppColors.textFieldIconBackColor,
                            disabledColor: AppColors.textFieldIconBackColor,
                            inactiveFillColor: AppColors.textFieldIconBackColor,
                            selectedColor: AppColors.mainColor,
                            selectedFillColor: AppColors.textFieldIconBackColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height(context) * 0.05,
                  ),
                  InkWell(
                    onTap: _submit,
                    child: saveButton(
                        title: "next".tr,
                        image: 'assets/images/next_circle.png'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
