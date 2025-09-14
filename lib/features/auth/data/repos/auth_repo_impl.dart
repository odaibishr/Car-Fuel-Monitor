import 'package:car_monitor/core/errors/failure.dart';
import 'package:car_monitor/features/auth/data/models/user_model.dart';
import 'package:car_monitor/features/auth/data/repos/auth_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepoImpl implements AuthRepo {
  final SupabaseClient supabaseClient;
  AuthRepoImpl(this.supabaseClient);
  @override
  Future<Either<Failure, UserModel>> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final response = await supabaseClient.auth
          .signInWithPassword(email: email, password: password);
      if (response.user == null) {
        return Left(Failure('Sign in Failed'));
      }

      final userData = supabaseClient.auth.currentUser;

      return Right(UserModel(
        id: userData!.id,
        email: response.user!.email!,
        name: userData.userMetadata!['name'] as String,
        phone: userData.userMetadata!['phone'] as String,
      ));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await supabaseClient.auth.signOut();
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  @override
  Future<Either<Failure, UserModel>> signUpWithEmailAndPassword(
      String email, String password, String? name, String? phone) async {
    try {
      final response = await supabaseClient.auth.signUp(
          password: password,
          email: email,
          data: {'name': name, 'phone': phone});

      if (response.user == null) {
        return Left(Failure('Sign up Failed'));
      }

      return Right(UserModel(
          id: response.user!.id,
          email: response.user!.email!,
          name: name,
          phone: phone));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserModel>> getCurrentUser() async {
    try {
      final userData = supabaseClient.auth.currentUser;
      if (userData == null) {
        return Left(Failure('User not found'));
      }
      return Right(UserModel(
          id: userData.id,
          email: userData.email!,
          name: userData.userMetadata!['name'] as String,
          phone: userData.userMetadata!['phone'] as String));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
