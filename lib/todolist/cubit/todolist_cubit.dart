import 'dart:developer';

import 'package:appdemo/model/user_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'todolist_state.dart';

class TodolistCubit extends Cubit<TodolistState> {
  TodolistCubit() : super(TodolistState());

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  Future<void> addData() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      emit(state.copyWith(status: TodolistStatus.loading));
      try {
        List<UserModel>? userData = [];
        var user = UserModel(
          id: int.parse(DateTime.now().second.toString()),
          name: nameController.text,
          email: emailController.text,
        );
        userData.add(user);
        emit(state.copyWith(
          user: state.user! + userData,
          status: TodolistStatus.success,
        ));
        log('list user: ${state.user!.length}');
        nameController.clear();
        emailController.clear();
      } catch (e) {
        emit(state.copyWith(status: TodolistStatus.error));
        log('error: $e');
      }
    }
  }

  onDeleted(int index) {
    emit(state.copyWith(status: TodolistStatus.loading));
    emit(
      state.copyWith(
          status: TodolistStatus.success,
          user: state.user?..removeWhere((element) => element.id == index)),
    );
  }

  onFillDataEdit(UserModel userModel) {
    emit(state.copyWith(isEditing: true,userEdit: userModel));
    nameController.text = userModel.name;
    emailController.text = userModel.email;
  }

  onEdit() async {
    if (state.userEdit == null) return;
    emit(state.copyWith(status: TodolistStatus.loading));
    for (var element in state.user!) {
      if (element.id == state.userEdit!.id) {
        element.name = nameController.text;
        element.email = emailController.text;
      }
    }
    emit(state.copyWith(status: TodolistStatus.success));
    nameController.clear();
    emailController.clear();
    //done
  }
}
