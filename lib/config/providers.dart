import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loan_originator_poc/views/repository/auth.repository.dart';

final firebaseAuthProvider =
    Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

final authStateChangesProvider = StreamProvider<User>(
        (ref) => ref.watch(firebaseAuthProvider).authStateChanges());

final fireStoreProvider =
    Provider<FirebaseFirestore>((ref) => FirebaseFirestore.instance);

final authRepositoryProvider =
    Provider<AuthRepository>((ref) => AuthRepository(ref.read));
