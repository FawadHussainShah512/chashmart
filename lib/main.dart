// import 'package:chashmart/providers/order_provider.dart';
// import 'package:chashmart/providers/products_provider.dart';
// import 'package:chashmart/providers/theme_provider.dart';
// import 'package:chashmart/root_screen.dart';
// import 'package:chashmart/screens/explore_screen.dart';
// import 'package:chashmart/screens/inner_screen/product_details.dart';
// import 'package:chashmart/screens/inner_screen/viewed_recently.dart';
// import 'package:chashmart/screens/splash_screen.dart';
// import 'package:chashmart/virtual_try_on/ar.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:paymob_pakistan/paymob_payment.dart';
// import 'package:provider/provider.dart';
//
// import 'consts/theme_data.dart';
// import 'providers/cart_provider.dart';
// import 'providers/user_provider.dart';
// import 'providers/viewed_recently_provider.dart';
// import 'providers/wishlist_provider.dart';
// import 'screens/auth/forgot_password.dart';
// import 'screens/auth/login.dart';
// import 'screens/auth/register.dart';
// import 'screens/inner_screen/orders/orders_screen.dart';
// import 'screens/inner_screen/wishlist.dart';
// import 'screens/search_screen.dart';
//
// void main() {
//   AR().initialize();
//   PaymobPakistan.instance.initialize(
//     apiKey:
//         "ZXlKaGJHY2lPaUpJVXpVeE1pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SmpiR0Z6Y3lJNklrMWxjbU5vWVc1MElpd2ljSEp2Wm1sc1pWOXdheUk2TVRFNU1qTXlMQ0p1WVcxbElqb2lhVzVwZEdsaGJDSjkuTF9Xd2xvWGlQcUpCTWFSMXRNbGFxbzNTYnVCS3N4SXV5Z2NQMDBlb0ZuTEhnRkh2YjVfMDE4YzZsSktmNFZkTDBZUWZqOUxSSmpmMkhKcVdYTG1yMnc=",
//     integrationID: 134580,
//     iFrameID: 147471,
//     jazzcashIntegrationId: 546789,
//     easypaisaIntegrationID: 345676,
//   );
//   WidgetsFlutterBinding.ensureInitialized();
//   SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
//       .then((_) {
//     runApp(const MyApp());
//   });
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     SystemChrome.setSystemUIOverlayStyle(
//       const SystemUiOverlayStyle(
//         statusBarColor: Color(0xFF0ffc0a95),
//         systemNavigationBarColor: Color(0xFF0ffc0a95),
//       ),
//     );
//     return FutureBuilder<FirebaseApp>(
//         future: Firebase.initializeApp(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const MaterialApp(
//               debugShowCheckedModeBanner: false,
//               home: Scaffold(
//                 body: Center(
//                   child: CircularProgressIndicator(
//                     color: Color(0xFF0ffc0a95),
//                     backgroundColor: Color(0xFF0ffc0a95),
//                     strokeWidth: 5,
//                   ),
//                 ),
//               ),
//             );
//           } else if (snapshot.hasError) {
//             return MaterialApp(
//               debugShowCheckedModeBanner: false,
//               home: Scaffold(
//                 body: Center(
//                   child: SelectableText(snapshot.error.toString()),
//                 ),
//               ),
//             );
//           }
//           return MultiProvider(
//             providers: [
//               ChangeNotifierProvider(create: (_) {
//                 return ThemeProvider();
//               }),
//               ChangeNotifierProvider(create: (_) {
//                 return ProductsProvider();
//               }),
//               ChangeNotifierProvider(create: (_) {
//                 return CartProvider();
//               }),
//               ChangeNotifierProvider(create: (_) {
//                 return WishlistProvider();
//               }),
//               ChangeNotifierProvider(create: (_) {
//                 return ViewedProdProvider();
//               }),
//               ChangeNotifierProvider(create: (_) {
//                 return UserProvider();
//               }),
//               ChangeNotifierProvider(create: (_) {
//                 return OrderProvider();
//               }),
//             ],
//             child: Consumer<ThemeProvider>(
//                 builder: (context, themeProvider, child) {
//               return MaterialApp(
//                 debugShowCheckedModeBanner: false,
//                 title: 'Chashmart',
//                 theme: Styles.themeData(
//                     isDarkTheme: themeProvider.getIsDarkTheme,
//                     context: context),
//                 home: SplashScreen(),
//                 // home: const LoginScreen(),
//                 routes: {
//                   RootScreen.routeName: (context) => const RootScreen(),
//                   ProductDetailsScreen.routName: (context) =>
//                       const ProductDetailsScreen(),
//                   WishlistScreen.routName: (context) => const WishlistScreen(),
//                   ViewedRecentlyScreen.routName: (context) =>
//                       const ViewedRecentlyScreen(),
//                   RegisterScreen.routName: (context) => const RegisterScreen(),
//                   LoginScreen.routeName: (context) => const LoginScreen(),
//                   OrdersScreenFree.routeName: (context) =>
//                       const OrdersScreenFree(),
//                   ForgotPasswordScreen.routeName: (context) =>
//                       const ForgotPasswordScreen(),
//                   SearchScreen.routeName: (context) => const SearchScreen(),
//                   ExploreScreen.routeName: (context) => ExploreScreen(),
//                 },
//               );
//             }),
//           );
//         });
//   }
// }

import 'package:chashmart/providers/order_provider.dart';
import 'package:chashmart/providers/products_provider.dart';
import 'package:chashmart/providers/theme_provider.dart';
import 'package:chashmart/root_screen.dart';
import 'package:chashmart/screens/explore_screen.dart';
import 'package:chashmart/screens/inner_screen/product_details.dart';
import 'package:chashmart/screens/inner_screen/viewed_recently.dart';
import 'package:chashmart/screens/splash_screen.dart';
import 'package:chashmart/virtual_try_on/ar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:paymob_pakistan/paymob_payment.dart';
import 'package:provider/provider.dart';

import 'consts/theme_data.dart';
import 'providers/cart_provider.dart';
import 'providers/user_provider.dart';
import 'providers/viewed_recently_provider.dart';
import 'providers/wishlist_provider.dart';
import 'screens/auth/forgot_password.dart';
import 'screens/auth/login.dart';
import 'screens/auth/register.dart';
import 'screens/inner_screen/orders/orders_screen.dart';
import 'screens/inner_screen/wishlist.dart';
import 'screens/search_screen.dart';

void main() {
  AR().initialize();
  PaymobPakistan.instance.initialize(
    apiKey:
        "ZXlKaGJHY2lPaUpJVXpVeE1pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SmpiR0Z6Y3lJNklrMWxjbU5vWVc1MElpd2ljSEp2Wm1sc1pWOXdheUk2TVRFNU1qTXlMQ0p1WVcxbElqb2lhVzVwZEdsaGJDSjkuTF9Xd2xvWGlQcUpCTWFSMXRNbGFxbzNTYnVCS3N4SXV5Z2NQMDBlb0ZuTEhnRkh2YjVfMDE4YzZsSktmNFZkTDBZUWZqOUxSSmpmMkhKcVdYTG1yMnc=",
    integrationID: 134580,
    iFrameID: 147471,
    jazzcashIntegrationId: 546789,
    easypaisaIntegrationID: 345676,
  );
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Color(0xFF0ffc0a95),
        systemNavigationBarColor: Color(0xFF0ffc0a95),
      ),
    );
    return FutureBuilder<FirebaseApp>(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: SplashScreen(),
          );
        } else if (snapshot.hasError) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Center(
                child: SelectableText(snapshot.error.toString()),
              ),
            ),
          );
        }
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) {
              return ThemeProvider();
            }),
            ChangeNotifierProvider(create: (_) {
              return ProductsProvider();
            }),
            ChangeNotifierProvider(create: (_) {
              return CartProvider();
            }),
            ChangeNotifierProvider(create: (_) {
              return WishlistProvider();
            }),
            ChangeNotifierProvider(create: (_) {
              return ViewedProdProvider();
            }),
            ChangeNotifierProvider(create: (_) {
              return UserProvider();
            }),
            ChangeNotifierProvider(create: (_) {
              return OrderProvider();
            }),
          ],
          child: Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Chashmart',
                theme: Styles.themeData(
                  isDarkTheme: themeProvider.getIsDarkTheme,
                  context: context,
                ),
                home: snapshot.connectionState == ConnectionState.done
                    ? const RootScreen()
                    : const SplashScreen(),
                routes: {
                  RootScreen.routeName: (context) => const RootScreen(),
                  ProductDetailsScreen.routName: (context) =>
                      const ProductDetailsScreen(),
                  WishlistScreen.routName: (context) => const WishlistScreen(),
                  ViewedRecentlyScreen.routName: (context) =>
                      const ViewedRecentlyScreen(),
                  RegisterScreen.routName: (context) => const RegisterScreen(),
                  LoginScreen.routeName: (context) => const LoginScreen(),
                  OrdersScreenFree.routeName: (context) =>
                      const OrdersScreenFree(),
                  ForgotPasswordScreen.routeName: (context) =>
                      const ForgotPasswordScreen(),
                  SearchScreen.routeName: (context) => const SearchScreen(),
                  ExploreScreen.routeName: (context) => ExploreScreen(),
                },
              );
            },
          ),
        );
      },
    );
  }
}
