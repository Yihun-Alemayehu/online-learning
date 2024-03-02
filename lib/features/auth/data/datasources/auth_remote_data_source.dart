import 'dart:convert';
import 'dart:io';
import 'dart:js_interop';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart' as ui_auth;
import 'package:flutter/cupertino.dart';
import 'package:online_learning/core/enums/update_user.dart';
import 'package:online_learning/core/errors/exception.dart';
import 'package:online_learning/core/errors/failure.dart';
import 'package:online_learning/features/auth/data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<void> forgotPassword(String email);

  Future<MyUserModel> signIn({
    required String email,
    required String password,
  });

  Future<void> signUp({
    required String email,
    required String fullName,
    required String password,
  });

  Future<void> updateUser({
    required UpdateUserAction action,
    required dynamic userData,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth _authClient;
  final FirebaseFirestore _cloudStoreclient;
  final FirebaseStorage _dbClient;

  AuthRemoteDataSourceImpl(
      {required FirebaseAuth authClient,
      required FirebaseFirestore cloudStoreclient,
      required FirebaseStorage dbClient})
      : _authClient = authClient,
        _cloudStoreclient = cloudStoreclient,
        _dbClient = dbClient;

  @override
  Future<void> forgotPassword(String email) async {
    try {
      await _authClient.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw ServerFailure(
          message: e.message ?? 'Error occured', statusCode: e.code);
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerFailure(message: e.toString(), statusCode: '505 haha');
    }
  }

  @override
  Future<MyUserModel> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _authClient.signInWithEmailAndPassword(
          email: email, password: password);

      final user = result.user;

      if (user == null) {
        throw const ServerFailure(
            message: 'Please try again later !', statusCode: 'Unknown error');
      }
      var userData = await _getUserData(user.uid);

      if (userData.exists) {
        return MyUserModel.fromMap(userData.data()!);
      }

      // upload the user
      await _setUserData(user, email);

      userData = await _getUserData(user.uid);

      return MyUserModel.fromMap(userData.data()!);
    } on ServerException {
      rethrow;
    } on FirebaseAuthException catch (e) {
      throw ServerFailure(
          message: e.message ?? 'Error occured', statusCode: e.code);
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerFailure(message: e.toString(), statusCode: '505 haha');
    }
  }

  @override
  Future<void> signUp(
      {required String email,
      required String fullName,
      required String password}) async {
    try {
      final userCred = await _authClient.createUserWithEmailAndPassword(
          email: email, password: password);

      await userCred.user?.updateDisplayName(fullName);
      await userCred.user?.updatePhotoURL('photoURL');
    } on FirebaseAuthException catch (e) {
      throw ServerFailure(
          message: e.message ?? 'Error occured', statusCode: e.code);
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerFailure(message: e.toString(), statusCode: '505 haha');
    }
  }

  @override
  Future<void> updateUser({
    required UpdateUserAction action,
    required userData,
  }) async {
    try {
      switch (UpdateUserAction) {
        case UpdateUserAction.email:
          await _authClient.currentUser
              ?.verifyBeforeUpdateEmail(userData as String);
          await _updateUserData({'email': userData});
          break;
        case UpdateUserAction.displayName:
          await _authClient.currentUser?.updateDisplayName(userData as String);
          await _updateUserData({'fullName': userData});
          break;
        case UpdateUserAction.bio:
          await _updateUserData({'bio': userData as String});
          break;
        case UpdateUserAction.profilePic:
          final ref = _dbClient
              .ref()
              .child('profile_pics${_authClient.currentUser?.uid}');
          await ref.putFile(userData as File);
          final url = await ref.getDownloadURL();
          await _authClient.currentUser?.updatePhotoURL(url);
          await _updateUserData({'profilePic': url});
          break;
        case UpdateUserAction.password:
          if (_authClient.currentUser?.email == null) {
            throw const ServerFailure(
                message: 'User does not exist ',
                statusCode: 'UnAuthorized access');
          }
          final newData =
              jsonDecode(userData as String) as Map<String, dynamic>;

          await _authClient.currentUser?.reauthenticateWithCredential(
              EmailAuthProvider.credential(
                  email: _authClient.currentUser!.email!,
                  password: newData['oldPasword'] as String));

          await _authClient.currentUser
              ?.updatePassword(newData['newPassword'] as String);
        default:
      }
    } on FirebaseException catch (e) {
      throw ServerFailure(
          message: e.message ?? 'Error occured', statusCode: e.code);
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerFailure(message: e.toString(), statusCode: '505 haha');
    }
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> _getUserData(
      String uid) async {
    return _cloudStoreclient.collection('users').doc(uid).get();
  }

  Future<void> _setUserData(User user, String fallbackEmail) async {
    await _cloudStoreclient.collection('users').doc(user.uid).set(
          MyUserModel(
            uid: user.uid,
            email: user.email ?? fallbackEmail,
            fullName: user.displayName ?? '',
            profilePic: user.photoURL ?? '',
            points: 0,
          ).toMap(),
        );
  }

  Future<void> _updateUserData(Map<String, dynamic> data) async {
    return await _cloudStoreclient
        .collection('users')
        .doc(_authClient.currentUser?.uid)
        .update(data);
  }
}
