import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:to_do/bloc/create_task_bloc.dart';
import 'package:to_do/bloc/home_page_bloc.dart';
import 'package:to_do/bloc/login_bloc.dart';

extension Extension on BuildContext{
  HomePageBloc getHomePageBlocInstance() => read<HomePageBloc>();
  LoginBloc getLoginBlocInstance() => read<LoginBloc>();

  CreateTaskBloc getCreateTaskBlocInstance()=> read<CreateTaskBloc>();
  void backToScreen(context){
    Navigator.pop(context);
  }
}