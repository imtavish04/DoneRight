import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './service_item.dart';
import '../providers/services.dart';

class ProductsGrid extends StatelessWidget {
  final bool showFavs;

  ProductsGrid(this.showFavs);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products =
        showFavs ? productsData.favouriteItems : productsData.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: products.length,
      //itemBuilder defines how every grid item/cell is built
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: products[i],
// we have already instanciated our product in products.dart(LIST) so we do not want to do that again, we simply call that
        child: ProductItems(),
      ),
      //gridDelegate allows us to define how grid should be structured
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
