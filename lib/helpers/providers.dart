import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:rooj/helpers/changeColorForSalonDetails.dart';
import 'package:rooj/helpers/changeColorProvider.dart';
import 'package:rooj/providerModel/addOfferProvider.dart';
import 'package:rooj/providerModel/addSalonProvider.dart';
import 'package:rooj/providerModel/addSirvProvider.dart';
import 'package:rooj/providerModel/auth.dart';
import 'package:rooj/providerModel/basicSittingProvider.dart';
import 'package:rooj/providerModel/bookProvider.dart';
import 'package:rooj/providerModel/choseTimeProvider.dart';
import 'package:rooj/providerModel/citeisProvider.dart';
import 'package:rooj/providerModel/contactUsProvider.dart';
import 'package:rooj/providerModel/daysProvider.dart';
import 'package:rooj/providerModel/homeProvider.dart';
import 'package:rooj/providerModel/notificationsPorvider.dart';
import 'package:rooj/providerModel/offersProvider.dart';
import 'package:rooj/providerModel/removeAndAddfavouriteProvider.dart';
import 'package:rooj/providerModel/reservationDetailsPRovider.dart';
import 'package:rooj/providerModel/reservationsProvider.dart';
import 'package:rooj/providerModel/salonDetailsProvider.dart';
import 'package:rooj/providerModel/salonItemDetailsProvider.dart';
import 'package:rooj/providerModel/salonServicesProvider.dart';
import 'package:rooj/providerModel/searchProvider.dart';
import 'package:rooj/providerModel/subCategoriesProvider.dart';
import 'package:rooj/providerModel/switchCity.dart';
import 'package:rooj/providerModel/vendorProfileInfo.dart';
import 'package:rooj/providerModel/walletProvider.dart';
import 'package:rooj/screens/servicesMoreDetails/addetionalPersonModel.dart';
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
  ChangeNotifierProvider(
    create: (context) => AdditionalPersonProvider(),
  ),
  ChangeNotifierProvider(
    create: (context) => ChoseTimeProvider(),
  ),
  ChangeNotifierProvider(
    create: (context) => BookingProiver(),
  ),
  ChangeNotifierProvider(
    create: (context) => AddOfferProvider(),
  ),
  ChangeNotifierProvider(
    create: (context) => AddSirvProvider(),
  ),
  ChangeNotifierProvider(
    create: (context) => GetProviderProfile(),
  ),
  ChangeNotifierProvider(
    create: (context) => ReservationsDetialsProvider(),
  ),
  ChangeNotifierProvider(
    create: (context) => DaysProvider(),
  ),
  ChangeNotifierProvider(
    create: (context) => AddSalonProvider(),
  ),
  ChangeNotifierProvider(
    create: (context) => AddAndRemoveFavProvider(),
  ),
  ChangeNotifierProvider(
    create: (context) => SearchProvider(),
  ),
  ChangeNotifierProvider(
    create: (context) => NotificationsProvider(),
  ),
  ChangeNotifierProvider(
    create: (context) => CitiesProvider(),
  ),
  ChangeNotifierProvider(
    create: (context) => SwitchCityProvider(),
  ),
  ChangeNotifierProvider(
    create: (context) => BasicSittingProvider(),
  ),
  ChangeNotifierProvider(
    create: (context) => ContactUsProvider(),
  ),
];
