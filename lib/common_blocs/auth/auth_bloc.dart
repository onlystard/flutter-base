import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:boomracing/common_blocs/auth/auth_event.dart';
import 'package:boomracing/common_blocs/auth/auth_state.dart';
import 'package:boomracing/services/local_storage/local_storage.dart';

@lazySingleton
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(
    this._storage,
  ) : super(AuthState.init()) {
    on<AuthEventInitialize>(_onInitialize);

    add(AuthEventInitialize());
  }

  final LocalStorage _storage;

  Future<void> _onInitialize(
    AuthEventInitialize event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(isInitializing: true));

    String? refreshToken = await _storage.getString('refresh_token');

    if (refreshToken != null) {
      try {} on Exception catch (e) {
        print(e);
        // Handle error
      }
    } else {
      emit(state.copyWith(isInitializing: false, user: () => null));
    }
  }
}
