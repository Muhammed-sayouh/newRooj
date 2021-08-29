import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rooj/customeWidget/appBar1.dart';
import 'package:get/get.dart';
import 'package:rooj/customeWidget/commenStackPage.dart';
import 'package:rooj/customeWidget/dialogs.dart';
import 'package:rooj/customeWidget/imageForAbout.dart';
import 'package:rooj/providerModel/basicSittingProvider.dart';
import 'package:rooj/style/sizes.dart';

class TermsScreen extends StatefulWidget {
  @override
  _TermsScreenState createState() => _TermsScreenState();
}

class _TermsScreenState extends State<TermsScreen> {
  bool loaderO = false;
  List<Datum> sitting = [];
  Future<void> futureO() async {
    setState(() {
      loaderO = true;
    });

    try {
      sitting = await Provider.of<BasicSittingProvider>(context, listen: false)
          .fetchBasicSitting();

      setState(() {
        loaderO = false;
      });
    } catch (error) {
      print(error);
      setState(() {
        loaderO = false;
      });
      print(error);

      throw (error);
    }
  }

  @override
  void initState() {
    futureO();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(title: "Terms".tr, inMain: false),
      body: stackWidget(
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: height(context) * 0.03,
                ),
                ImageWidgetForAbout(),
                SizedBox(
                  height: height(context) * 0.06,
                ),
                loaderO
                    ? loadingDialogForSmallestPages(context)
                    : Container(
                        width: width(context) * 0.86,
                        child: Text(
                          sitting[0].usageTerms.toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(),
                        ),
                      ),
                SizedBox(
                  height: height(context) * 0.1,
                ),
              ],
            ),
          ),
          context: context),
    );
  }
}
