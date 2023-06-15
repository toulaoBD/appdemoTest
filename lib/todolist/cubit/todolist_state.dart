part of 'todolist_cubit.dart';

enum TodolistStatus { initial, loading, success, error }

class TodolistState extends Equatable {
  const TodolistState({
    this.user = const [],
    this.status = TodolistStatus.initial,
    this.isEditing = false,
    this.userEdit,
  });
  final List<UserModel>? user;
  final TodolistStatus status;
  final bool? isEditing;
  final UserModel? userEdit;

  @override
  List<Object?> get props => [
        user,
        status,
        isEditing,
        userEdit,
      ];
  TodolistState copyWith({
    List<UserModel>? user,
    TodolistStatus? status,
    bool? isEditing,
    UserModel? userEdit,
  }) {
    return TodolistState(
      user: user ?? this.user,
      status: status ?? this.status,
      isEditing: isEditing ?? this.isEditing,
      userEdit: userEdit ?? this.userEdit,
    );
  }
}
