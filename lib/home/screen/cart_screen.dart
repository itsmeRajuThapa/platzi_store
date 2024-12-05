import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:platzi_store/app_localization_service.dart';
import 'package:platzi_store/home/model/productModel.dart';
import 'package:platzi_store/services/service_locator.dart';
import 'package:platzi_store/services/shared_preference_service.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    loadCardList();
  }

  List<CardDetailsModel> cartProductList = [];

  void loadCardList() {
    final jsonString =
        locator<SharedPrefsServices>().sharedPreferences!.getString('card');
    if (jsonString != null) {
      final jsonData = jsonDecode(jsonString) as List<dynamic>;
      setState(() {
        cartProductList =
            jsonData.map((e) => CardDetailsModel.fromJson(e)).toList();
      });
    }
  }

  void removeFromCart(int index) {
    CardDetailsModel? removedItem;
    setState(() {
      removedItem = cartProductList.removeAt(index);
    });

    List<Map<String, dynamic>> data =
        cartProductList.map((e) => e.toJson()).toList();
    String jsonData = jsonEncode(data);
    locator<SharedPrefsServices>().setString(key: 'card', value: jsonData);

    setState(() {
      getPrice();
    });

    final snackBar = SnackBar(
      content: const Text('Item removed from cart!'),
      backgroundColor: (Colors.black),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          cartProductList.insert(index, removedItem!);
          List<Map<String, dynamic>> undoData =
              cartProductList.map((e) => e.toJson()).toList();
          String undoJsonData = jsonEncode(undoData);
          locator<SharedPrefsServices>()
              .setString(key: 'card', value: undoJsonData);
          setState(() {
            getPrice();
            loadCardList();
          });
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  double getPrice() {
    double totalprice = 0;
    for (var price in cartProductList) {
      totalprice += price.totalPrice!;
    }
    return totalprice;
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int totalPrice = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(l10n.cart),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Builder(
          builder: (BuildContext scaffoldContext) => Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                itemCount: cartProductList.length,
                itemBuilder: (BuildContext context, int index) {
                  CardDetailsModel data = cartProductList[index];

                  totalPrice = cartProductList[index].totalPrice! + totalPrice;

                  return Dismissible(
                    key: Key(cartProductList[index].toString()),
                    direction: DismissDirection.horizontal,
                    onDismissed: (direction) {
                      removeFromCart(index);
                    },
                    background: Container(
                      color: Colors.red,
                      child: const Positioned(
                          left: 10,
                          top: 33,
                          child:
                              Icon(Icons.delete_forever, color: Colors.white)),
                    ),
                    child: Card(
                      child: ListTile(
                        leading: Image.network(data.images!),
                        title: Text(
                            "Name: ${data.title!}   ( ${data.totalPice}X)",
                            style: const TextStyle(fontSize: 14)),
                        subtitle: Row(
                          children: [
                            Text("Price: ${data.price}"),
                            const SizedBox(width: 20),
                            Text("Total Price: ${data.totalPrice}")
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              const Spacer(),
              Text("${l10n.totalprice}:         ${getPrice()}"),
              const SizedBox(height: 10),
              InkWell(
                onTap: () {},
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: const BoxDecoration(color: Colors.black45),
                  child: Center(child: Text(l10n.process)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
