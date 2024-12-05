import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:platzi_store/app_localization_service.dart';
import 'package:platzi_store/details/item_details.dart';
import 'package:platzi_store/home/model/productModel.dart';
import 'package:platzi_store/home/screen/homeScreen.dart';
import 'package:platzi_store/services/service_locator.dart';
import 'package:platzi_store/services/shared_preference_service.dart';
import 'package:platzi_store/services/toast/app_toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  @override
  void initState() {
    loadFavorites();
    super.initState();
  }

  void loadFavorites() async {
    // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final jsonString = locator<SharedPrefsServices>()
        .sharedPreferences!
        .getString('likeddataList');
    if (jsonString != null) {
      final jsonData = jsonDecode(jsonString) as List<dynamic>;
      setState(() {
        productList =
            jsonData.map((json) => ProductDetailsModel.fromJson(json)).toList();
      });
    }
  }

  void removeProductFromFavorites(int productId) async {
    productList.removeWhere((product) => product.id == productId);
    List<Map<String, dynamic>> jsonDataList =
        productList.map((e) => e.toJson()).toList();
    String jsonData = jsonEncode(jsonDataList);
    locator<SharedPrefsServices>()
        .sharedPreferences!
        .setString('likeddataList', jsonData);
    // sharedPreferences.setString('likedataList', jsonData);
    loadFavorites();
  }

  Future<bool> onWillBack() async {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => const HomeScreen()));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillBack,
      child: Scaffold(
          appBar: AppBar(
            title: Text(l10n.wishlist),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                mainAxisExtent: 280,
              ),
              itemCount: productList.length,
              itemBuilder: (BuildContext context, int index) {
                var data = productList[index];
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
                                    data.images!.firstOrNull ??
                                        'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse1.mm.bing.net%2Fth%3Fid%3DOIP.JrAmYjOqtOA8xXOgzldlxgAAAA%26pid%3DApi&f=1&ipt=4a412d8355c8d81c79311d334b3d6455f36180503fba50601ebd9d64c3095a3b&ipo=images',
                                    fit: BoxFit.fill,
                                  )),
                            ),
                            Positioned(
                                top: 0,
                                right: 0,
                                child: IconButton(
                                    onPressed: () {
                                      removeProductFromFavorites(data.id!);
                                      AppToasts().showToast(
                                          message: 'Removed from wishlist',
                                          isSuccess: true);
                                    },
                                    icon: const Icon(Icons.favorite,
                                        color: Colors.red, size: 30))),
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
            ),
          )),
    );
  }
}
