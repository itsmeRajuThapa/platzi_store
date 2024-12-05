import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:platzi_store/common/type_defs.dart';
import 'package:platzi_store/home/Repo/product_repo.dart';
import 'package:platzi_store/home/model/productModel.dart';
part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepo _repo = ProductRepo();
  ProductBloc() : super(ProductInitial()) {
    on<GetProductList>(_getProductList);
    on<GetProductCategoryList>(_getProductCategoryList);
  }

  void _getProductList(GetProductList event, Emitter<ProductState> emit) async {
    // try {
    emit(state.copyWith(productList: [], status: ProductStateStatus.loading));

    DynamicFailure repo = await _repo.fetchAllProducts(
        min: event.min!, max: event.max!, categoryId: event.categoryId!);

    repo.fold((l) {
      List<ProductDetailsModel> productList = [];
      if (l != null && l!.isNotEmpty) {
        List<dynamic> respData = l;
        for (var element in respData) {
          productList.add(ProductDetailsModel.fromJson(element));
        }
      }
      emit(state.copyWith(
          status: ProductStateStatus.success, productList: productList));
    }, (r) {
      emit(state.copyWith(status: ProductStateStatus.error));
    });
    //  } catch (e) {
    //  emit(state.copyWith(status: ProductStateStatus.error));
    // }
  }

  void _getProductCategoryList(
      GetProductCategoryList event, Emitter<ProductState> emit) async {
    try {
      if (event.isRefresh) {
        emit(state.copyWith(
            categoryList: [], categorystatus: CategoryStatus.loading));
      }
      DynamicFailure repo = await _repo.fetchAllCategorys();
      repo.fold((l) {
        List<CategoryModel> categoryList = [];
        if (l != null && l!.isNotEmpty) {
          List<dynamic> respData = l;
          for (var element in respData) {
            categoryList.add(CategoryModel.fromJson(element));
          }
          emit(state.copyWith(
              categorystatus: CategoryStatus.success,
              categoryList: categoryList));
        }
      }, (r) {
        emit(state.copyWith(categorystatus: CategoryStatus.error));
      });
    } catch (e) {
      emit(state.copyWith(categorystatus: CategoryStatus.error));
    }
  }
}
