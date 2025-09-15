import 'package:bloc/bloc.dart';
import 'package:car_monitor/features/auth/data/models/user_model.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
}
