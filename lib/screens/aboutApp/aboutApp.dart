import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rooj/customeWidget/appBar1.dart';
import 'package:get/get.dart';
import 'package:rooj/customeWidget/commenStackPage.dart';
import 'package:rooj/customeWidget/dialogs.dart';
import 'package:rooj/customeWidget/imageForAbout.dart';
import 'package:rooj/providerModel/basicSittingProvider.dart';
import 'package:rooj/style/sizes.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutAppScreen extends StatefulWidget {
  @override
  _AboutAppScreenState createState() => _AboutAppScreenState();
}

class _AboutAppScreenState extends State<AboutAppScreen> {
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
      appBar: myAppBar(title: "aboutApp".tr, inMain: false),
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
                          sitting[0].aboutApp.toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(),
                        ),
                      ),
                SizedBox(
                  height: height(context) * 0.1,
                ),
                Container(
                  width: width(context) * 0.6,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () async {
                          await launch('http:${sitting[0].snapchatLink}');
                        },
                        child: SizedBox(
                          width: 50,
                          height: 50,
                          child: Image.asset(
                            'assets/images/snap_chat_circle.png',
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          await launch('http:${sitting[0].instagramLink}');
                        },
                        child: SizedBox(
                          width: 50,
                          height: 50,
                          child: Image.asset(
                            'assets/images/instegram_box_color.png',
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          await launch('http:${sitting[0].twitterLink}');
                        },
                        child: SizedBox(
                          width: 50,
                          height: 50,
                          child: Image.asset(
                            'assets/images/twiter_circle.png',
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          context: context),
    );
  }
}
