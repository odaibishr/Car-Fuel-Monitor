import 'package:car_monitor/core/errors/failure.dart';
import 'package:car_monitor/features/auth/data/models/user_model.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepo {
  Future<Either<Failure, UserModel>> signUpWithEmailAndPassword(
      String email, String password, String? name, String? phone);
  Future<Either<Failure, UserModel>> signInWithEmailAndPassword(
      String email, String password);
  Future<void> signOut();
  Future<Either<Failure, UserModel>> getCurrentUser();
}
