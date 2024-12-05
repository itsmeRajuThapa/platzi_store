// ignore_for_file: file_names
import 'dart:convert';
import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platzi_store/app_localization_service.dart';
import 'package:platzi_store/back_to_exit.dart';
import 'package:platzi_store/common/text.dart';
import 'package:badges/badges.dart' as badges;
import 'package:platzi_store/details/item_details.dart';
import 'package:platzi_store/home/bloc/product_bloc.dart';
import 'package:platzi_store/home/model/productModel.dart';
import 'package:platzi_store/routes/route_name.dart';
import 'package:platzi_store/search/representation/screen/drawer_search.dart';
import 'package:platzi_store/services/api_handling/api_manager.dart';
import 'package:platzi_store/services/navigation_service.dart';
import 'package:platzi_store/services/service_locator.dart';
import 'package:platzi_store/services/shared_preference_service.dart';
import 'package:platzi_store/utils/shimmer_widget.dart';

List<ProductDetailsModel> productList = [];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    apiManager();
    locator<ProductBloc>()
        .add(const GetProductList(min: '', max: '', categoryId: ''));
    locator<ProductBloc>().add(const GetProductCategoryList());
    loadFavorites();
  }

  void apiManager() async {
    await setupLocator().then((value) => locator<ApiManager>());
  }

  void loadFavorites() async {
    final jsonString = locator<SharedPrefsServices>()
        .sharedPreferences!
        .getString('likeddataList');
    if (jsonString != null) {
      final jsonData = jsonDecode(jsonString);
      setState(() {
        productList =
            jsonData.map((json) => ProductDetailsModel.fromJson(json)).toList();
      });
    }
  }

  void addWishlist({id, category, title, price, image, desc}) {
    bool isFavorite = isProductInFavorites(id);

    if (isFavorite) {
      removeProductFromFavorites(id);
    } else {
      productList.add(ProductDetailsModel(
          id: id,
          category: category,
          title: title,
          price: price,
          images: image,
          description: desc));

      List<Map<String, dynamic>> jsonDataList =
          productList.map((e) => e.toJson()).toList();
      String jsonData = jsonEncode(jsonDataList);
      locator<SharedPrefsServices>()
          .sharedPreferences!
          .setString('likeddataList', jsonData);
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
    loadFavorites();
  }

  bool isProductInFavorites(int productId) {
    return productList.any((product) => product.id == productId);
  }

  var scaffoldKey = GlobalKey<ScaffoldState>();
  List<CategoryModel>? categoryList;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        endDrawerEnableOpenDragGesture: false,
        endDrawer: Drawer(
            child: DrawerForSearch(
          categoryList: categoryList,
        )),
        appBar: AppBar(
          title: const Text('     Platzi Store'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7)),
                          title: const Text('Confirm'),
                          content: const Text("Do you want to Logout?"),
                          actions: [
                            TextButton(
                              child: const Text("Cancel"),
                              onPressed: () {
                                locator<NavigationService>().goBack();
                              },
                            ),
                            TextButton(
                              child: const Text("Ok"),
                              onPressed: () {
                                locator<SharedPrefsServices>()
                                    .clearOnlyOneData('token');
                                locator<NavigationService>()
                                    .pushNamedAndRemoveUntil(
                                        Routes.loginScreen, false);
                              },
                            )
                          ],
                        );
                      });
                },
                icon: const Icon(Icons.logout)),
            InkWell(
                onTap: () {
                  locator<NavigationService>().navigateTo(Routes.cartScreen);
                },
                child: badges.Badge(
                  position: badges.BadgePosition.topEnd(top: -20, end: -10),
                  badgeContent: Text(
                    cartProductList.length.toString(),
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                  child: const Icon(Icons.add_shopping_cart_sharp),
                )),
            InkWell(
                onTap: () {
                  locator<NavigationService>()
                      .navigateTo(Routes.wishlistScreen);
                },
                child: badges.Badge(
                    position: badges.BadgePosition.topEnd(top: -10, end: 0),
                    showBadge: productList.isEmpty ? false : true,
                    badgeStyle: const badges.BadgeStyle(
                      badgeColor: Colors.green,
                    ),
                    badgeContent: Text(
                      productList.length.toString(),
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                    child: Image.network(
                      "https://icon-library.com/images/wishlist-icon/wishlist-icon-20.jpg",
                      height: 45,
                    )))
          ],
        ),
        body: BackToExit(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SimpleText(
                      title: l10n.category, fontsize: 20, color: Colors.red),
                  BlocBuilder<ProductBloc, ProductState>(
                      bloc: locator<ProductBloc>(),
                      builder: (context, state) {
                        if (state.categorystatus == CategoryStatus.error) {
                          return const Center(child: Text('Error: '));
                        } else if (state.categorystatus ==
                                CategoryStatus.initial ||
                            state.categorystatus == CategoryStatus.loading) {
                          return const CategoryLoagingShimmer();
                        } else if (state.categorystatus ==
                            CategoryStatus.success) {
                          return SizedBox(
                            height: 100,
                            width: double.infinity,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: state.categoryList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  categoryList = state.categoryList;
                                  CategoryModel result =
                                      state.categoryList[index];
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      height: 100,
                                      width: 100,
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Image.network(
                                                result.image.toString(),
                                                fit: BoxFit.fill,
                                                height: 100,
                                                width: 100),
                                          ),
                                          Text(result.name.toString()).frosted(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              padding: const EdgeInsets.all(2))
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          );
                        } else {
                          return Container();
                        }
                      }),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SimpleText(
                            title: l10n.all, fontsize: 20, color: Colors.red),
                        InkWell(
                          onTap: () {
                            scaffoldKey.currentState!.openEndDrawer();
                          },
                          child: Container(
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2),
                                border: Border.all(width: 1),
                              ),
                              child: const Icon(
                                Icons.filter_list_sharp,
                                size: 20,
                              )),
                        )
                      ],
                    ),
                  ),
                  BlocBuilder<ProductBloc, ProductState>(
                      bloc: locator<ProductBloc>(),
                      builder: (context, state) {
                        if (state.status == ProductStateStatus.error) {
                          return const Center(child: Text('Error:'));
                        } else if (state.status == ProductStateStatus.initial ||
                            state.status == ProductStateStatus.loading) {
                          return const AllProductLoadingShimmer();
                        } else if (state.status == ProductStateStatus.success &&
                            state.productList.isEmpty) {
                          return const Center(child: Text("No Product Found"));
                        } else if (state.status == ProductStateStatus.success &&
                            state.productList.isNotEmpty) {
                          return GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
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
                                  locator<NavigationService>().navigateTo(
                                      Routes.detailsScreen,
                                      arguments: data.id);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Theme.of(context)
                                        .colorScheme
                                        .inversePrimary,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Stack(
                                        children: [
                                          SizedBox(
                                            height: 190,
                                            width: double.infinity,
                                            child: ClipRRect(
                                                borderRadius:
                                                    const BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(15),
                                                        topRight:
                                                            Radius.circular(
                                                                15)),
                                                child: Image.network(
                                                  (data.images!.firstOrNull !=
                                                              "https://placeimg.com/640/480/any") &&
                                                          (data.images!
                                                                  .firstOrNull !=
                                                              "https://placeimg.com/640/481/any")
                                                      ? data
                                                          .images!.firstOrNull!
                                                      : 'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse1.mm.bing.net%2Fth%3Fid%3DOIP.JrAmYjOqtOA8xXOgzldlxgAAAA%26pid%3DApi&f=1&ipt=4a412d8355c8d81c79311d334b3d6455f36180503fba50601ebd9d64c3095a3b&ipo=images',
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
                                                  setState(() {
                                                    loadFavorites();
                                                  });
                                                },
                                                icon: isProductInFavorites(
                                                        data.id!)
                                                    ? const Icon(Icons.favorite,
                                                        color: Colors.red,
                                                        size: 30)
                                                    : const Icon(Icons.favorite,
                                                        color: Colors.white,
                                                        size: 30),
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
                      })
                ],
              ),
            ),
          ),
        ));
  }
}
