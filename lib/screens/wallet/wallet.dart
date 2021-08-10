import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rooj/customeWidget/appBar1.dart';
import 'package:rooj/customeWidget/commenStackPage.dart';
import 'package:rooj/customeWidget/dialogs.dart';
import 'package:rooj/customeWidget/smallButton.dart';
import 'package:rooj/providerModel/walletProvider.dart';
import 'package:rooj/screens/wallet/walletRow.dart';
import 'package:rooj/style/colors.dart';
import 'package:rooj/style/sizes.dart';
import 'package:get/get.dart';

class WalletScreen extends StatefulWidget {
  @override
  _WalletScreenState createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  bool loaderO = false;
  late Data info;
  Future<void> futureO() async {
    setState(() {
      loaderO = true;
    });

    try {
      info = await Provider.of<WalletProvider>(context, listen: false)
          .fetchWallet();
      setState(() {
        loaderO = false;
      });
    } catch (error) {
      setState(() {
        loaderO = false;
      });
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
      appBar: myAppBar(title: "Wallet".tr, inMain: false),
      body: stackWidget(
          body: loaderO
              ? loadingDialogForPages(context)
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: height(context) * 0.05,
                      ),
                      ImageWidget(),
                      SizedBox(
                        height: height(context) * 0.02,
                      ),
                      Center(child: Text('الرصيد الحالي')),
                      SizedBox(
                        height: height(context) * 0.01,
                      ),
                      Center(
                        child: Text(
                          '${info.wallet} ريال',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height(context) * 0.05,
                      ),
                      Text(
                        'حجوزات سابقه',
                        style: TextStyle(
                          color: AppColors.mainColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: height(context) * 0.015,
                      ),
                      // Container(
                      //   height: height(context) * 0.33,
                      //   child: ReservaionWidget(
                      //     count: 2,
                      //   ),
                      // ),
                      SizedBox(
                        height: height(context) * 0.03,
                      ),
                      Row(
                        children: [
                          Container(
                            width: width(context) * 0.3,
                            child: Center(
                              child: Text(
                                'المبيعات',
                                style: TextStyle(
                                  color: AppColors.mainColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: width(context) * 0.15,
                          ),
                          Container(
                            width: width(context) * 0.4,
                            child: Center(
                              child: Text(
                                'عمولة الموقع',
                                style: TextStyle(
                                  color: AppColors.mainColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: height(context) * 0.03,
                      ),
                      rowW(
                          context: context,
                          firstPrice: '100',
                          secondePrice: '50'),
                      SizedBox(
                        height: height(context) * 0.015,
                      ),
                      rowW(
                          context: context,
                          firstPrice: '150',
                          secondePrice: '10'),
                      SizedBox(
                        height: height(context) * 0.04,
                      ),
                      Center(child: Text('مجموع العموله')),
                      SizedBox(
                        height: height(context) * 0.01,
                      ),
                      Center(
                        child: Text(
                          '60 ريال',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height(context) * 0.05,
                      ),
                      Center(
                        child: smallButton(
                            context: context,
                            title: 'دفع العموله',
                            onTap: () {}),
                      )
                    ],
                  ),
                ),
          context: context),
    );
  }
}

class ImageWidget extends StatelessWidget {
  const ImageWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: width(context) * 0.35,
        height: height(context) * 0.25,
        child: Image.asset(
          'assets/images/wallet_color.png',
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
