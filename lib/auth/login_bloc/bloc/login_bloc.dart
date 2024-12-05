import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:platzi_store/auth/login_Repo/login_repo.dart';
import 'package:platzi_store/auth/model/login_model.dart';
import 'package:platzi_store/routes/route_name.dart';
import 'package:platzi_store/services/navigation_service.dart';
import 'package:platzi_store/services/service_locator.dart';
import 'package:platzi_store/services/shared_preference_service.dart';
import 'package:platzi_store/services/toast/app_toast.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginState(status: LoginUserStatus.initial)) {
    on<LoginButtonClickEvent>(_loginButtonClickEvent);
  }

  void _loginButtonClickEvent(
      LoginButtonClickEvent event, Emitter<LoginState> emit) async {
    try {
      emit(state.copyWith(status: LoginUserStatus.loading));
      LoginRepo repo = LoginRepo();
      final resp =
          await repo.loginUser(email: event.email, password: event.password);
      resp.fold((l) {
        emit(state.copyWith(status: LoginUserStatus.success));
        locator<SharedPrefsServices>()
            .setString(key: 'token', value: '${l['data']['access_token']}');
        _onLoginSuccess();
      }, (r) {
        emit(state.copyWith(status: LoginUserStatus.failure));
      });
    } catch (e) {
      emit(state.copyWith(status: LoginUserStatus.failure));
    }
  }
}

void _onLoginSuccess() {
  locator<NavigationService>().navigateTo(Routes.homeScreen);
  AppToasts().showToast(
    message: 'Logged In Successfully',
    isSuccess: true,
  );
}
