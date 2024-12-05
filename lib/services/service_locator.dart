import 'package:get_it/get_it.dart';
import 'package:platzi_store/home/bloc/product_bloc.dart';
import 'package:platzi_store/services/api_handling/api_manager.dart';
import 'package:platzi_store/services/navigation_service.dart';
import 'package:platzi_store/services/shared_preference_service.dart';

final GetIt locator = GetIt.instance;
Future<void> setupLocator() async {
  locator.registerSingleton<NavigationService>(NavigationService());
  locator.registerSingleton<SharedPrefsServices>(SharedPrefsServices());
  locator.registerSingleton<ApiManager>(ApiManager());
  locator.registerLazySingleton<ProductBloc>(() => ProductBloc());
}
