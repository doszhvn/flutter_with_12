import 'package:bloc/bloc.dart';
import '../repository/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository _authRepository;
  LoginBloc(this._authRepository) : super(LoginInitial()) {
    on<LoginEvent>((event, emit) async {
      if (event is LoginButtonPressed) {
        emit(LoginLoading());
        try {
          await Future.delayed(const Duration(seconds: 3), () async {
            final token =
                await _authRepository.logIn(event.username, event.password);
            print(token);
            emit(LoginSuccess());
          });
        } catch (e) {
          print(e);
          emit(LoginError(e.toString()));
        }
      }
    });
  }
}
