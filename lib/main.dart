import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './providers/auth.dart';
import './screens/orders_screen.dart';
import './screens/service_overview_screen.dart';
import './screens/service_details_screen.dart';
import './providers/services.dart';
import './providers/cart.dart';
import './providers/orders.dart';
import './screens/cart_screen.dart';
import './screens/auth_screen.dart';
import './screens/splash_screen.dart';
import './helpers/custom_route.dart';
import './screens/phone_screen.dart';
import './screens/howitworks_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // when we have more than 1 providers we can either nest them or use this
        // this provider widget allows us to register a class which you can then listen in child widgets
        // whenever that class updates, the child widgets which are listening will be rebuilt
        ChangeNotifierProvider.value(value: Auth()),

        ChangeNotifierProxyProvider<Auth, Products>(
          //depends on other provider defined above this
          // if we do not need the ctx here, we can use the value method, this approach must be used in case we have a list or grid
          // create: (ctx) => Products(),

          update: (ctx, auth, previousProducts) => Products(
              auth.token,
              auth.userId,
              previousProducts == null ? [] : previousProducts.items),
        ),
        ChangeNotifierProvider.value(
          value: Cart(),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          update: (ctx, auth, previousOrders) => Orders(
              previousOrders == null ? [] : previousOrders.orders,
              auth.userId,
              auth.token),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
            title: 'MyShop',
            theme: ThemeData(
              primarySwatch: Colors.purple,
              accentColor: Colors.deepOrange,
              fontFamily: 'Lato',
              pageTransitionsTheme: PageTransitionsTheme(builders: {
                TargetPlatform.android: CustomPageTransitionBuilder(),
                TargetPlatform.iOS: CustomPageTransitionBuilder(),
              }),
            ),
            home: auth.isAuth
                ? PhoneScreen() //ProductsOverviewScreen()
                : FutureBuilder(
                    future: auth.tryAutoLogin(),
                    builder: (ctx, authResultSnapshot) =>
                        authResultSnapshot.connectionState ==
                                ConnectionState.waiting
                            ? SplashScreen()
                            : AuthScreen()),
            routes: {
              ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
              CartScreen.routeName: (ctx) => CartScreen(),
              OrdersScreen.routeName: (ctx) => OrdersScreen(),
              HowItWorks.routeName: (ctx) => HowItWorks(),
              ProductsOverviewScreen.routeName: (ctx) =>
                  ProductsOverviewScreen(),
            }),
      ),
    );
  }
}
