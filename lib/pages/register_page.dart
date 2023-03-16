import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../bloc/login_bloc.dart';
import '../view_item/login_view_item.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> key = GlobalKey<FormState>();
    final TextEditingController controller1 = TextEditingController();
    final TextEditingController controller2 = TextEditingController();
    final TextEditingController controller3 = TextEditingController();
    return ChangeNotifierProvider(
      create: (context)=> LoginBloc(),
      child: Form(
        key: key,
        child: Scaffold(
          body: LoginItemView(globalKey: key,nameController: controller1,passwordController: controller2, confirmPasswordController: controller3,isChecked: false, title: 'SignUp',),
        ),
      )
    );
  }
}
