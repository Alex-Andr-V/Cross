import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:book_finder/auth_service.dart';
import 'package:go_router/go_router.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService authService;

  AuthBloc(this.authService) : super(AuthInitial()) {
    on<SignUpRequested>(_onSignUpRequested);
    on<LoginRequested>(_onLoginRequested);
    on<LogoutRequested>(_onLogoutRequested);
      on<CheckAuthStatus>(_onCheckAuthStatus); // Добавляем обработчик для проверки состояния аутентификации
  }

 void _onCheckAuthStatus(CheckAuthStatus event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await authService.getCurrentUser(); // Проверяем текущего пользователя
      if (user != null) {
        emit(AuthSuccess()); // Пользователь авторизован
      } else {
        emit(AuthInitial()); // Пользователь не авторизован
        
      }
    } catch (e) {
      emit(AuthFailure(e.toString())); // Обработка ошибки
    }
  }

  void _onSignUpRequested(SignUpRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await authService.signUp(email: event.email, password: event.password);
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  void _onLoginRequested(LoginRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await authService.logIn(email: event.email, password: event.password);
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

void _onLogoutRequested(LogoutRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await authService.logOut(); // Вызываем метод выхода
      emit(AuthInitial()); // Возвращаем состояние в начальное
      
    } catch (e) {
      emit(AuthFailure(e.toString())); // Обработка ошибки
    }
  }
}