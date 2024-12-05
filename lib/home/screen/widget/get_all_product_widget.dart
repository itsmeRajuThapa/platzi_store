import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platzi_store/details/item_details.dart';
import 'package:platzi_store/home/bloc/product_bloc.dart';
import 'package:platzi_store/home/model/productModel.dart';
import 'package:platzi_store/utils/shimmer_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetAllProductListWidget extends StatefulWidget {
  const GetAllProductListWidget({super.key});

  @override
  State<GetAllProductListWidget> createState() =>
      _GetAllProductListWidgetState();
}

class _GetAllProductListWidgetState extends State<GetAllProductListWidget> {
  ProductBloc product = ProductBloc();
  List<ProductDetailsModel> productList = [];

  @override
  void initState() {
    super.initState();
    product.add(GetProductList());
    loadFavorites();
  }

  void loadFavorites() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final jsonString = sharedPreferences.getString('likedataList');
    if (jsonString != null) {
      final jsonData = jsonDecode(jsonString) as List<dynamic>;
      setState(() {
        productList =
            jsonData.map((json) => ProductDetailsModel.fromJson(json)).toList();
      });
    }
  }

  void addWishlist({id, category, title, price, image, desc}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool isFavorite = isProductInFavorites(id);

    if (isFavorite) {
      // Product is already in favorites, remove it
      removeProductFromFavorites(id);
    } else {
      // Product is not in favorites, add it
      productList.add(ProductDetailsModel(
          id: id,
          category: category,
          title: title,
          price: price,
          images: image,
          description: desc));
      // Save updated favorites to shared preferences
      saveFavorites(sharedPreferences);
    }
  }

  void removeProductFromFavorites(int productId) {
    productList.removeWhere((product) => product.id == productId);
    saveFavorites();
  }

  bool isProductInFavorites(int productId) {
    return productList.any((product) => product.id == productId);
  }

  void saveFavorites([SharedPreferences? sharedPreferences]) async {
    sharedPreferences ??= await SharedPreferences.getInstance();
    List<Map<String, dynamic>> jsonDataList =
        productList.map((e) => e.toJson()).toList();
    String jsonData = jsonEncode(jsonDataList);
    sharedPreferences.setString('likedataList', jsonData);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductBloc, ProductState>(
        bloc: product,
        listener: (context, state) {
          if (state.status == ProductStateStatus.error) {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('Error Occure')));
          }
        },
        builder: (context, state) {
          if (state.status == ProductStateStatus.error) {
            return const Center(child: Text('Error:'));
          } else if (state.status == ProductStateStatus.initial ||
              state.status == ProductStateStatus.loading) {
            return const AllProductLoadingShimmer();
          } else if (state.status == ProductStateStatus.success) {
            return GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                mainAxisExtent: 280,
              ),
              itemCount: state.productList.length,
              itemBuilder: (BuildContext context, int index) {
                var data = state.productList[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => ItemDetailsScreen(id: data.id!)));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            SizedBox(
                              height: 190,
                              width: double.infinity,
                              child: ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(15)),
                                  child: Image.network(
                                    '${data.images!.firstOrNull ?? 'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse1.mm.bing.net%2Fth%3Fid%3DOIP.JrAmYjOqtOA8xXOgzldlxgAAAA%26pid%3DApi&f=1&ipt=4a412d8355c8d81c79311d334b3d6455f36180503fba50601ebd9d64c3095a3b&ipo=images'}',
                                    fit: BoxFit.fill,
                                  )),
                            ),
                            Positioned(
                                top: 0,
                                right: 0,
                                child: IconButton(
                                  onPressed: () {
                                    addWishlist(
                                        category: data.category,
                                        desc: data.description,
                                        id: data.id,
                                        image: data.images,
                                        price: data.price,
                                        title: data.title);
                                  },
                                  icon: isProductInFavorites(data.id!)
                                      ? Icon(Icons.favorite,
                                          color: Colors.red, size: 30)
                                      : Icon(Icons.favorite,
                                          color: Colors.white, size: 30),
                                ))
                          ],
                        ),
                        const Divider(height: 8),
                        Text(" Title: ${data.title}",
                            style: const TextStyle(fontSize: 14),
                            overflow: TextOverflow.ellipsis),
                        const Divider(height: 5),
                        Text(" Category: ${data.category!.name}",
                            style: const TextStyle(fontSize: 14),
                            overflow: TextOverflow.ellipsis),
                        const Divider(height: 5),
                        Text(" Price: \$ ${data.price}"),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return Container();
          }
        });
  }
}
