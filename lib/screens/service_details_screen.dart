import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/services.dart';

class ProductDetailScreen extends StatelessWidget {
  // final String title;

  // ProductDetailScreen(this.title);
  static const routeName = '/product-detail';

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments as String;
    final loadedProduct =
        Provider.of<Products>(context, listen: false).findById(productId);
// provider.of<products> will rebuild this widget whenever there is some change in the products to avoid that we have a arguments litsen set to false
    return Scaffold(
      //appBar: AppBar(
      //title: Text(loadedProduct.title),
      //),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 300,
            pinned: true, //always visible
            flexibleSpace: FlexibleSpaceBar(
              title: Text(loadedProduct.title),
              background: Hero(
                tag: loadedProduct.id,
                child: Image.network(
                  loadedProduct.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(
                  height: 10,
                ),
                Text(
                  '₹${loadedProduct.price}',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.0,
                  ),
                  width: double.infinity,
                  child: Text(loadedProduct.description,
                      textAlign: TextAlign.left,
                      softWrap: true,
                      style: TextStyle(fontSize: 20)),
                ),
                SizedBox(
                  height: 800,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
