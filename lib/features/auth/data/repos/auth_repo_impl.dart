import 'dart:developer';

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
          .signInWithPassword(email: email.trim(), password: password);

      if (response.user == null) {
        return Left(Failure(
            'فشل تسجيل الدخول. يرجى التحقق من البريد الإلكتروني وكلمة المرور.'));
      }

      final userData = response.user;

      if (userData == null || userData.email == null) {
        return Left(
            Failure('بيانات المستخدم غير متوفرة. يرجى المحاولة مرة أخرى.'));
      }

      if (userData.userMetadata == null ||
          userData.userMetadata!['name'] == null ||
          userData.userMetadata!['phone'] == null) {
        return Left(Failure(
            'بيانات الملف الشخصي غير مكتملة. يرجى التواصل مع الدعم الفني.'));
      }

      return Right(UserModel(
        id: userData.id,
        email: userData.email!,
        name: userData.userMetadata!['name'] as String,
        phone: userData.userMetadata!['phone'] as String,
      ));
    } on AuthException catch (e) {
      String errorMessage = 'حدث خطأ أثناء تسجيل الدخول';
      if (e.message.contains('Invalid login credentials')) {
        errorMessage = 'البريد الإلكتروني أو كلمة المرور غير صحيحة';
      } else if (e.message.contains('Email not confirmed')) {
        errorMessage = 'الرجاء تأكيد بريدك الإلكتروني أولا';
      } else if (e.message.contains('Network')) {
        errorMessage = 'خطأ في الاتصال بالإنترنت. يرجى التحقق من اتصالك';
      }
      return Left(Failure(errorMessage));
    } catch (e) {
      // Handle any other errors
      return Left(Failure('حدث خطأ غير متوقع: ${e.toString()}'));
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

      log(response.toString());
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
