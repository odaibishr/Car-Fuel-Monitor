import 'package:bloc/bloc.dart';
import 'package:car_monitor/features/auth/data/models/user_model.dart';
import 'package:car_monitor/features/auth/data/repos/auth_repo.dart';
import 'package:flutter/material.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authRepo) : super(AuthInitial());
  final AuthRepo authRepo;

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    emit(AuthLoading());
    try {
      final user = await authRepo.signInWithEmailAndPassword(email, password);
      user.fold((failure) => emit(AuthError(failure.errorMessage)),
          (user) => emit(AuthAuthenticated(user: user)));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> signUpWithEmailAndPassword(
      String email, String password, String? name, String? phone) async {
    emit(AuthLoading());
    try {
      final user = await authRepo.signUpWithEmailAndPassword(
          email, password, name, phone);
      user.fold((failure) => emit(AuthError(failure.errorMessage)),
          (user) => emit(AuthAuthenticated(user: user)));
    } catch (e) {
      return emit(AuthError(e.toString()));
    }
  }

  Future<void> signOut() async {
    emit(AuthLoading());
    try {
      await authRepo.signOut();
      emit(AuthInitial());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
