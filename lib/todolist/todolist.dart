import 'package:appdemo/todolist/cubit/todolist_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodayList extends StatefulWidget {
  const TodayList({super.key});

  @override
  State<TodayList> createState() => _TodayListState();
}

class _TodayListState extends State<TodayList> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodolistCubit, TodolistState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = context.read<TodolistCubit>();
        return Scaffold(
          appBar: AppBar(
            title: Text('Todo list'),
          ),
          body: Column(
            children: [
              Form(
                key: cubit.formKey,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  //color: Colors.blue.shade100,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: cubit.nameController,
                        decoration: const InputDecoration(
                          hintText: 'Enter your name',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: cubit.emailController,
                        decoration: const InputDecoration(
                          hintText: 'Enter your email',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (state.isEditing == true) {
                            cubit.onEdit();
                          } else {
                            cubit.addData();
                          }
                        },
                        child:
                            Text(state.isEditing == true ? 'eidt' : 'submit'),
                      ),
                    ],
                  ),
                ),
              ),
              const Divider(),
              Expanded(
                child: Builder(builder: (context) {
                  if (state.status == TodolistStatus.loading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state.user == null || state.user!.isEmpty) {
                    return const Center(
                      child: Text('No data'),
                    );
                  }
                  return ListView.builder(
                    itemCount: state.user!.length,
                    itemBuilder: (c, i) {
                      var list = state.user;

                      return Container(
                          padding: const EdgeInsets.all(10),
                          child: ListTile(
                            leading: CircleAvatar(
                              child: Text(list![i].id.toString()),
                            ),
                            title: Text(list[i].name),
                            subtitle: Text(list[i].email),
                            trailing: Container(
                              width: 80,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: IconButton(
                                      onPressed: () {
                                        cubit.onFillDataEdit(list[i]);
                                      },
                                      icon: const Icon(Icons.edit),
                                    ),
                                  ),
                                  Expanded(
                                    child: IconButton(
                                      onPressed: () {
                                        cubit.onDeleted(list[i].id);
                                      },
                                      icon: const Icon(Icons.delete),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ));
                    },
                  );
                }),
              ),
            ],
          ),
        );
      },
    );
  }
}
