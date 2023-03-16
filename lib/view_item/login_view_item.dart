import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/bloc/login_bloc.dart';
import 'package:to_do/pages/register_page.dart';
import 'package:to_do/utils/extension.dart';
import 'package:to_do/utils/screen_extension.dart';

import '../constant/color.dart';
import '../constant/dimen.dart';
import '../constant/string.dart';
import '../pages/home_page.dart';
import '../widget/easy_text.dart';

class LoginItemView extends StatelessWidget {
  const LoginItemView(
      {Key? key,
      required this.globalKey,
      required this.nameController,
      required this.passwordController,
      this.isChecked = true,
      required this.confirmPasswordController,
      required this.title})
      : super(key: key);
  final GlobalKey<FormState> globalKey;
  final TextEditingController nameController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final bool isChecked;
  final String title;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Stack(children: [
      Image.asset(
        kLoginImage,
        fit: BoxFit.cover,
        width: getWidth(context),
        height: getHeight(context),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: kMp20x),
        child: Center(
          child: SizedBox(
            width: kWh300x,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: kWh100x,
                ),

                // title
                EasyText(
                  data: title,
                  fontSize: kFi30x,
                  fontWeight: FontWeight.bold,
                  fontColor: cWhite,
                ),
                const SizedBox(
                  height: kMp20x,
                ),

                // default profile
                CircleAvatar(
                  radius: kRi60x,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(kRi60x),
                      child: Image.asset(
                        kProfileImage,
                        fit: BoxFit.cover,
                      )),
                ),
                const SizedBox(
                  height: kMp20x,
                ),

                // username
                TextFormField(
                  validator: (value) {
                    if (value?.isEmpty ?? false) {
                      return 'Text Field is Empty';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.people),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(kRi10x),
                          borderSide: const BorderSide(color: cWhite)),
                      label: const Text('Username'),
                      labelStyle: const TextStyle(color: cWhiteShadow)),
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(
                  height: kMp20x,
                ),

                // password
                Selector<LoginBloc, bool>(
                  selector: (_, selector) => selector.getVisibility,
                  builder: (_, getVisibility, __) => TextFormField(
                    validator: (value) {
                      if (value?.isEmpty ?? false) {
                        return 'Text Field is Empty';
                      }
                      if ((value?.length ?? 0) < 8) {
                        return 'minimum requirement 8 letters';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.password),
                        suffixIcon: IconButton(
                            icon: Icon(
                              getVisibility
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: cBlack,
                            ),
                            onPressed: () =>
                                context.getLoginBlocInstance().setVisibility()),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(kRi10x),
                            borderSide: const BorderSide(color: cWhite)),
                        label: const Text(
                          'Password',
                        ),
                        labelStyle: const TextStyle(color: cWhiteShadow)),
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: getVisibility,
                  ),
                ),
                SizedBox(height: isChecked ? 0 : kMp20x),

                // is Checked true
                isChecked
                    ? const SizedBox(
                        height: 0,
                      )
                    : Selector<LoginBloc, bool>(
                        selector: (_, selector) => selector.getVisibility,
                        builder: (_, getVisibility, __) => TextFormField(
                          validator: (value) {
                            if (value?.isEmpty ?? false) {
                              return 'Text Field is Empty';
                            }
                            if ((value?.length ?? 0) < 8) {
                              return 'minimum requirement 8 letters';
                            }
                            if (passwordController.text !=
                                confirmPasswordController.text) {
                              return 'password not the same';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.password),
                              suffixIcon: IconButton(
                                  icon: Icon(
                                    getVisibility
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: Colors.black,
                                  ),
                                  onPressed: () => context
                                      .getLoginBlocInstance()
                                      .setVisibility()),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(kRi10x),
                                  borderSide: const BorderSide(color: cWhite)),
                              label: const Text(
                                'Confirm password',
                              ),
                              labelStyle: const TextStyle(color: cWhiteShadow)),
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: getVisibility,
                        ),
                      ),
                const SizedBox(
                  height: kMp20x,
                ),

                // SingIn SignUp Button
                TextButton(
                  style: TextButton.styleFrom(
                      fixedSize: Size(getWidth(context), kWh50x),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(kMp20x),
                          side: const BorderSide(color: cWhite))),
                  onPressed: () {
                    if (globalKey.currentState?.validate() ?? false) {
                      nextScreenPush(context, const HomePage());
                    }
                    nameController.clear();
                    passwordController.clear();
                  },
                  child: EasyText(
                    data: title,
                    fontColor: cWhite,
                  ),
                ),
                const SizedBox(
                  height: kMp20x,
                ),

                // sign in or sign up
                isChecked
                    ? GestureDetector(
                        onTap: () {
                          nextScreenPush(context, const RegisterPage());
                        },
                        child: RichText(
                            text: const TextSpan(
                                text: 'Do not have an account? ',
                                style: TextStyle(
                                    color: cPrimaryTextColor,
                                    fontSize: kFi20x,
                                    fontWeight: FontWeight.w400),
                                children: [
                              TextSpan(
                                text: 'Create',
                                style: TextStyle(
                                    color: Colors.cyan,
                                    fontSize: kFi20x,
                                    fontWeight: FontWeight.bold),
                              )
                            ])),
                      )
                    : GestureDetector(
                        onTap: () {
                          previousScreenPush(context);
                        },
                        child: RichText(
                            text: const TextSpan(
                                text: ' Have an account? ',
                                style: TextStyle(
                                    color: cPrimaryTextColor,
                                    fontSize: kFi20x,
                                    fontWeight: FontWeight.w400),
                                children: [
                              TextSpan(
                                text: 'Sing In',
                                style: TextStyle(
                                    color: Colors.cyan,
                                    fontSize: kFi20x,
                                    fontWeight: FontWeight.bold),
                              )
                            ])),
                      ),
              ],
            ),
          ),
        ),
      ),
    ]));
  }
}
