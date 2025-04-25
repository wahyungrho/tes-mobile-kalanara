import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tes_mobile_kalanara_group/task_2_auth_api/domain/auth_repositories.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepositories _authRepositories;
  AuthBloc(this._authRepositories) : super(AuthInitial()) {
    on<AuthLoginEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final token = await _authRepositories.login(
          event.username,
          event.password,
        );
        emit(AuthAuthenticated(token));
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });

    on<AuthLogoutEvent>((event, emit) {
      try {
        _authRepositories.logout();
        emit(AuthLogout());
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });

    on<AuthCheckEvent>((event, emit) {
      emit(AuthLoading());
      try {
        if (_authRepositories.hasToken()) {
          final token = _authRepositories.getToken();
          emit(AuthAuthenticated(token!));
        } else {
          emit(AuthUnauthenticated());
        }
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });
  }
}
