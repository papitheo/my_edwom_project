import 'package:edwom/product.dart';
import 'package:edwom/product_detail_page.dart';
import 'package:edwom/provider/products_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart' as pr;

class ProductsSearch extends SearchDelegate {
  ProductsSearch() : super();
  // final List<Product> products;

  @override
  List<Widget>? buildActions(BuildContext context) =>
      [IconButton(onPressed: () => query = '', icon: const Icon(Icons.clear))];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
      onPressed: () => Navigator.pop(context),
      icon: const Icon(Icons.arrow_back));

  @override
  Widget buildResults(BuildContext context) {
    final result = filterProducts(context);
    if (result.isEmpty) {
      return const Center(
        child: Text('No item found with the above search query'),
      );
    }
    return ListView.separated(
      separatorBuilder: (_, i) => const Divider(),
      itemCount: result.length,
      itemBuilder: (BuildContext context, int index) => ListTile(
        title: Text(result[index].name),
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => ProductDetail(product: result[index]))),
        leading:
            CircleAvatar(backgroundImage: NetworkImage(result[index].imageUrl)),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final result = filterProducts(context);
    if (result.isEmpty) {
      return const Center(
        child: Text('No item found with the above search query'),
      );
    }
    return ListView.separated(
      separatorBuilder: (_, i) => const Divider(),
      itemCount: result.length,
      itemBuilder: (BuildContext context, int index) => ListTile(
        title: Text(result[index].name),
        subtitle: Text(result[index].farm),
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => ProductDetail(product: result[index]))),
        leading:
            CircleAvatar(backgroundImage: NetworkImage(result[index].imageUrl)),
      ),
    );
  }

  List<Product> filterProducts(BuildContext context) =>
      pr.Provider.of<ProductsProvider>(context)
          .products
          .where((element) =>
              element.name.toLowerCase().contains(query.toLowerCase()) ||
              element.farm.toLowerCase().contains(query.toLowerCase()))
          .toList();
}
