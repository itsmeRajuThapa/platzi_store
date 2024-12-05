import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platzi_store/common/text.dart';
import 'package:platzi_store/details/bloc/product_details_bloc.dart';
import 'package:platzi_store/home/model/productModel.dart';
import 'package:platzi_store/routes/route_name.dart';
import 'package:platzi_store/services/navigation_service.dart';
import 'package:platzi_store/services/service_locator.dart';
import 'package:platzi_store/services/shared_preference_service.dart';
import 'package:platzi_store/services/toast/app_toast.dart';

List<CardDetailsModel> cartProductList = [];

class ItemDetailsScreen extends StatefulWidget {
  final int id;
  const ItemDetailsScreen({super.key, required this.id});

  @override
  State<ItemDetailsScreen> createState() => _ItemDetailsScreenState();
}

class _ItemDetailsScreenState extends State<ItemDetailsScreen> {
  ProductDetailsBloc details = ProductDetailsBloc();
  @override
  void initState() {
    super.initState();
    details.add(GetProductDetailsEvent(id: widget.id));
  }

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

  void addedToCart(
      {required id,
      required image,
      required title,
      required price,
      required int totalPrice,
      required totalpice}) {
    cartProductList.add(CardDetailsModel(
        id: id,
        images: image,
        title: title,
        price: price,
        totalPrice: totalPrice,
        totalPice: totalpice));
    List<Map<String, dynamic>> product =
        cartProductList.map((e) => e.toJson()).toList();
    String jsonData = jsonEncode(product);
    locator<SharedPrefsServices>().setString(key: 'card', value: jsonData);

    AppToasts()
        .showToast(message: 'Successfully Added to Cart', isSuccess: true);
    setState(() {
      loadCardList();
    });
  }

  final ValueNotifier<int> _numNotifier = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        automaticallyImplyLeading: true,
      ),
      body: BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
        bloc: details,
        builder: (context, state) {
          if (state.status == ProductDetailsStatus.initial ||
              state.status == ProductDetailsStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.status == ProductDetailsStatus.error) {
            return const Center(
              child: Text('Failed to fetch'),
            );
          } else if (state.status == ProductDetailsStatus.success) {
            var data = state.productdetails;
            return Column(
              children: [
                Stack(children: [
                  Image.network(data.images!.first),
                  Positioned(
                      top: 2,
                      right: 2,
                      child: Container(
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.yellow),
                        child: IconButton(
                            onPressed: () {
                              locator<NavigationService>().navigateTo(
                                  Routes.updateScreen,
                                  arguments: data.id!);
                            },
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.black,
                            )),
                      ))
                ]),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BoldText(
                          title: "Title: ${data.title}",
                          fontsize: 18,
                          color: Colors.red),
                      SimpleText(
                          title: "Description: ${data.description}",
                          fontsize: 16),
                      BoldText(
                          title: "Price: ${data.price}",
                          fontsize: 16,
                          color: Colors.green),
                      const SizedBox(height: 10),
                      ValueListenableBuilder(
                        valueListenable: _numNotifier,
                        builder: (context, selectNum, child) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  _numNotifier.value++;
                                },
                                child: const Icon(Icons.add),
                              ),
                              const SizedBox(width: 10),
                              BoldText(
                                  title: "${_numNotifier.value}",
                                  fontsize: 20,
                                  color: Colors.red),
                              const SizedBox(width: 10),
                              ElevatedButton(
                                  onPressed: () {
                                    if (_numNotifier.value == 0) {
                                      _numNotifier.value;
                                    } else {
                                      _numNotifier.value--;
                                    }
                                  },
                                  child: const Icon(Icons.minimize)),
                            ],
                          );
                        },
                      ),
                      const SizedBox(height: 5),
                      Center(
                        child: ElevatedButton(
                            onPressed: () {
                              if (_numNotifier.value == 0) {
                                AppToasts().showToast(
                                    message: "Must Select One or More",
                                    isSuccess: false);
                              } else {
                                addedToCart(
                                    id: data.id,
                                    image: data.images![0],
                                    title: data.title,
                                    price: data.price,
                                    totalPrice:
                                        _numNotifier.value * data.price!,
                                    totalpice: _numNotifier.value);
                              }
                            },
                            child: const Text('Add to Cart')),
                      )
                    ],
                  ),
                )
              ],
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
