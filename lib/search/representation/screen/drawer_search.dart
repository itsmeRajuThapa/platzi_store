import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:platzi_store/home/bloc/product_bloc.dart';
import 'package:platzi_store/home/model/productModel.dart';
import 'package:platzi_store/services/navigation_service.dart';
import 'package:platzi_store/services/service_locator.dart';

class DrawerForSearch extends StatefulWidget {
  final List<CategoryModel>? categoryList;
  const DrawerForSearch({super.key, required this.categoryList});

  @override
  State<DrawerForSearch> createState() => _DrawerForSearchState();
}

ValueNotifier<String?> _minPrice = ValueNotifier(null);
ValueNotifier<String?> _maxPrice = ValueNotifier(null);
ValueNotifier<CategoryModel?> _categoryNotifier = ValueNotifier(null);

final List<String> priceList = ['100', '200', '300', '400', '500', '600'];

class _DrawerForSearchState extends State<DrawerForSearch> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 35),
      child: Column(
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Min Price'),
                  const SizedBox(height: 6),
                  ValueListenableBuilder(
                      valueListenable: _minPrice,
                      builder: (_, minPriceSelect, __) {
                        return DropdownButton2<String>(
                          isExpanded: true,
                          hint: const Row(children: [
                            Icon(Icons.price_change_outlined, size: 16),
                            SizedBox(width: 6),
                            Text('Min Price',
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis)
                          ]),
                          items: priceList
                              .map((String priceList) =>
                                  DropdownMenuItem<String>(
                                      value: priceList,
                                      child: Text(priceList,
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                          overflow: TextOverflow.ellipsis)))
                              .toList(),
                          value: minPriceSelect,
                          onChanged: (value) {
                            _minPrice.value = value ?? '';
                          },
                          buttonStyleData: ButtonStyleData(
                            height: 40,
                            width: 130,
                            padding: const EdgeInsets.only(left: 8, right: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: Colors.black26,
                              ),
                            ),
                          ),
                          dropdownStyleData: DropdownStyleData(
                            maxHeight: 200,
                            //  width: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            scrollbarTheme: ScrollbarThemeData(
                              radius: const Radius.circular(40),
                              thickness: MaterialStateProperty.all<double>(6),
                              thumbVisibility:
                                  MaterialStateProperty.all<bool>(true),
                            ),
                          ),
                          menuItemStyleData: const MenuItemStyleData(
                            height: 40,
                            padding: EdgeInsets.only(left: 14, right: 14),
                          ),
                        );
                      }),
                ],
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Max Price'),
                  const SizedBox(height: 6),
                  ValueListenableBuilder(
                      valueListenable: _maxPrice,
                      builder: (_, maxPriceSelect, __) {
                        return DropdownButton2<String>(
                          isExpanded: true,
                          hint: const Row(children: [
                            Icon(Icons.price_change_outlined, size: 16),
                            SizedBox(width: 6),
                            Text('Max Price',
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis)
                          ]),
                          items: priceList
                              .map((String priceList) =>
                                  DropdownMenuItem<String>(
                                      value: priceList,
                                      child: Text(priceList,
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                          overflow: TextOverflow.ellipsis)))
                              .toList(),
                          value: maxPriceSelect,
                          onChanged: (value) {
                            _maxPrice.value = value ?? '';
                          },
                          buttonStyleData: ButtonStyleData(
                            height: 40,
                            width: 130,
                            padding: const EdgeInsets.only(left: 8, right: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: Colors.black26,
                              ),
                            ),
                          ),
                          dropdownStyleData: DropdownStyleData(
                            maxHeight: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            scrollbarTheme: ScrollbarThemeData(
                              radius: const Radius.circular(40),
                              thickness: MaterialStateProperty.all<double>(6),
                              thumbVisibility:
                                  MaterialStateProperty.all<bool>(true),
                            ),
                          ),
                          menuItemStyleData: const MenuItemStyleData(
                            height: 40,
                            padding: EdgeInsets.only(left: 14, right: 14),
                          ),
                        );
                      }),
                ],
              ),
            ],
          ),
          SizedBox(height: 10),
          const Text('Category List'),
          const SizedBox(height: 6),
          ValueListenableBuilder(
              valueListenable: _categoryNotifier,
              builder: (_, selectCategory, __) {
                return DropdownButton2<CategoryModel>(
                  isExpanded: true,
                  hint: const Row(children: [
                    Icon(Icons.view_list, size: 16),
                    SizedBox(width: 6),
                    Text('Select Category',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis)
                  ]),
                  items: widget.categoryList
                      ?.map((CategoryModel categoryList) =>
                          DropdownMenuItem<CategoryModel>(
                              value: categoryList,
                              child: Text(categoryList.name!,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.ellipsis)))
                      .toList(),
                  value: selectCategory,
                  onChanged: (value) {
                    _categoryNotifier.value = value ?? CategoryModel();
                  },
                  buttonStyleData: ButtonStyleData(
                    height: 40,
                    width: 180,
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: Colors.black26,
                      ),
                    ),
                  ),
                  dropdownStyleData: DropdownStyleData(
                    maxHeight: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    scrollbarTheme: ScrollbarThemeData(
                      radius: const Radius.circular(40),
                      thickness: MaterialStateProperty.all<double>(6),
                      thumbVisibility: MaterialStateProperty.all<bool>(true),
                    ),
                  ),
                  menuItemStyleData: const MenuItemStyleData(
                    height: 40,
                    padding: EdgeInsets.only(left: 14, right: 14),
                  ),
                );
              }),
          SizedBox(height: 20),
          ElevatedButton(
              onPressed: () {
                _minPrice.value = null;
                _maxPrice.value = null;
                _categoryNotifier.value = null;
              },
              child: Text('Clear Filter')),
          const Spacer(),
          Row(
            children: [
              Expanded(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black54),
                      onPressed: () {
                        locator<NavigationService>().goBack();
                      },
                      child: const Text(
                        'Cancle',
                        style: TextStyle(color: Colors.white),
                      ))),
              const SizedBox(width: 10),
              Expanded(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black54),
                      onPressed: () {
                        locator<ProductBloc>().add(GetProductList(
                          min: _minPrice.value ?? '',
                          max: _maxPrice.value ?? '',
                          categoryId: _categoryNotifier.value != null
                              ? _categoryNotifier.value!.id.toString()
                              : '',
                        ));

                        locator<NavigationService>().goBack();
                      },
                      child: const Text(
                        'Done',
                        style: TextStyle(color: Colors.white),
                      ))),
            ],
          )
        ],
      ),
    ));
  }
}
