import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:rooj/helpers/changeColorForSalonDetails.dart';
import 'package:rooj/helpers/changeColorProvider.dart';
import 'package:rooj/providerModel/auth.dart';
import 'package:rooj/providerModel/homeProvider.dart';
import 'package:rooj/providerModel/offersProvider.dart';
import 'package:rooj/providerModel/reservationsProvider.dart';
import 'package:rooj/providerModel/salonDetailsProvider.dart';
import 'package:rooj/providerModel/salonItemDetailsProvider.dart';
import 'package:rooj/providerModel/salonServicesProvider.dart';
import 'package:rooj/providerModel/subCategoriesProvider.dart';
import 'package:rooj/providerModel/walletProvider.dart';
import 'package:rooj/style/colors.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider(
    create: (context) => Auth(),
  ),
  ChangeNotifierProvider(
    create: (context) => HomeProvider(),
  ),
  ChangeNotifierProvider(
    create: (context) => WalletProvider(),
  ),
  ChangeNotifierProvider(
    create: (context) => SalonDetailsProvider(),
  ),
  ChangeNotifierProvider(
    create: (context) => ReservationsProvider(),
  ),
  ChangeNotifierProvider(
    create: (context) => Item(color: AppColors.mainColor, name: ''),
  ),
  ChangeNotifierProvider(
    create: (context) => OffersProvider(),
  ),
  ChangeNotifierProvider(
    create: (context) =>
        ItemForSalonDetails(name: '', color: AppColors.mainColor),
  ),
  ChangeNotifierProvider(
    create: (context) => SalonItemDetailsProvider(),
  ),
  ChangeNotifierProvider(
    create: (context) => SubCategoriesProvider(),
  ),
  ChangeNotifierProvider(
    create: (context) => SalonServicesProvider(),
  ),
];
