import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:platzi_store/auth/Internet_cubit/cubit/internet_cubit.dart';
import 'package:platzi_store/auth/login_bloc/bloc/login_bloc.dart';
import 'package:platzi_store/details/bloc/product_details_bloc.dart';
import 'package:platzi_store/entry_screen.dart';
import 'package:platzi_store/home/bloc/product_bloc.dart';
import 'package:platzi_store/routes/route_generator.dart';
import 'package:platzi_store/services/navigation_service.dart';
import 'package:platzi_store/services/service_locator.dart';
import 'package:platzi_store/services/shared_preference_service.dart';
import 'update/bloc/update_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  setupLocator().then((value) => locator<SharedPrefsServices>().init());
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // SystemChrome.setSystemUIOverlayStyle(
  //     const SystemUiOverlayStyle(statusBarColor: Colors.black12));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => InternetCubit()),
        BlocProvider<LoginBloc>(create: (_) => LoginBloc()),
        BlocProvider<ProductBloc>(create: (_) => ProductBloc()),
        BlocProvider<ProductDetailsBloc>(create: (_) => ProductDetailsBloc()),
        BlocProvider<UpdateBloc>(create: (_) => UpdateBloc()),
      ],
      child: MaterialApp(
        title: 'Platzi Store',
        navigatorKey: NavigationService.navigatorKey,
        onGenerateRoute: RouteGenerator.generateRouter,
        debugShowCheckedModeBanner: false,
        locale: const Locale('ne'),
        supportedLocales: const <Locale>[Locale('ne'), Locale('en')],
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const EntryScreen(),
      ),
    );
  }
}
