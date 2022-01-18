import 'package:equatable/equatable.dart';

/// User model
///
/// [AuthUser.empty] represents an unauthenticated user.
class AuthUser extends Equatable {
  const AuthUser({
    required this.id,
    this.email,
    this.phoneNumber,
    this.name,
    this.photo,
  });

  /// The current user's email address.
  final String? email;

  /// The current user's phoneNumber address.
  final String? phoneNumber;

  /// The current user's id.
  final String id;

  /// The current user's name (display name).
  final String? name;

  /// Url for the current user's photo.
  final String? photo;

  /// Empty user which represents an unauthenticated user.
  static const empty = AuthUser(id: '');

  /// Convenience getter to determine whether the current user is empty.
  bool get isEmpty => this == AuthUser.empty;

  /// Convenience getter to determine whether the current user is not empty.
  bool get isNotEmpty => this != AuthUser.empty;

  @override
  List<Object?> get props => [email, phoneNumber, id, name, photo];
}
