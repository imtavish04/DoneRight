import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';
import '../widgets/services_grid.dart';
import '../widgets/badge.dart';
import '../providers/cart.dart';
import './cart_screen.dart';
import '../widgets/app_drawer.dart';
import '../providers/services.dart';

enum FilterOptions {
  Favourite,
  All,
}

class ProductsOverviewScreen extends StatefulWidget {
  static const routeName = '/services';
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  Position _currentPosition;
  String _currentAddress;
  var _showOnlyFavourites = false;
  var _init = true;
  var _isLoading = false;
  @override
  void initState() {
    //runs only once when the state object renders
    // Provider.of<Products>(context).fetchAndSetProducts();  won't work
    //Future.delayed(Duration.zero).then((_){
//Provider.of<Products>(context).fetchAndSetProducts();
    //});                           //Not the best approach
    _getCurrentLocation();
    super.initState();
  }

  _getCurrentLocation() {
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });

      _getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = p[0];

      setState(() {
        _currentAddress =
            "${place.locality}, ${place.postalCode}, ${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void didChangeDependencies() {
    if (_init) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Products>(context).fetchAndSetProducts().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _init = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Row(
            children: [
              Icon(Icons.location_on),
              SizedBox(
                width: 8,
              ),
              if (_currentPosition != null && _currentAddress != null)
                Expanded(
                  child: Text(
                    _currentAddress,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
            ],
          ),
          actions: <Widget>[
            PopupMenuButton(
              onSelected: (FilterOptions selectedValue) {
                setState(() {
                  if (selectedValue == FilterOptions.Favourite) {
                    _showOnlyFavourites = true;
                  } else {
                    _showOnlyFavourites = false;
                  }
                });
              },
              icon: Icon(Icons.more_vert),
              itemBuilder: (_) => [
                PopupMenuItem(
                    child: Text('Only favourites'),
                    value: FilterOptions.Favourite),
                PopupMenuItem(
                  child: Text('Show all'),
                  value: FilterOptions.All,
                ),
              ],
            ),
            Consumer<Cart>(
              builder: (_, cart, ch) => Badge(
                child: ch, //child element of badge.
                value: cart.itemCount.toString(),
              ),
              child: IconButton(
                // child element of consumer.
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.of(context).pushNamed(CartScreen.routeName);
                },
              ),
            ),
          ]),
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ProductsGrid(_showOnlyFavourites),
    );
  }
}
