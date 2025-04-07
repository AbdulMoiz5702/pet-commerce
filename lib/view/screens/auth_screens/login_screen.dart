import 'package:animals/view/common/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/routes/routes.dart';
import '../../../core/utils/helper_fuctions/format_validator.dart';
import '../../../providers/auth_providers/login_provider.dart';
import '../../common/custom_button.dart';
import '../../common/custom_loading.dart';
import '../../common/custom_sizedBox.dart';
import '../../common/custom_textfeild.dart';



class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    var provider = ref.watch(loginProvider.notifier);
    var key = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
          child: Form(
            key: key,
            child: Column(
              children: [
                const Sized(height: 0.05,),
                CustomTextField(controller: provider.emailController, hintText: 'Email', validate: (value){
                  return  FormValidators.validateEmail(value);
                }),
                const Sized(height: 0.02,),
                CustomTextField(controller: provider.passwordController, hintText: 'Password', validate: (value){
                  return  FormValidators.validatePassword(value);
                }),
                const Sized(height: 0.05,),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, Routes.forgotPassword);
                    },
                    child: lightText(title: 'Forgot Password?'),
                  ),
                ),
                const Sized(height: 0.05,),
                Consumer(
                    builder: (context,reference,_){
                      var data = reference.watch(loginProvider.select((state)=> state.isLoading));
                      return data == true ? const CustomLoading() : CustomButton(title: 'Login', onTap: (){
                        if(key.currentState!.validate()){
                          reference.read(loginProvider.notifier).loginUser(context: context);
                        }
                      });
                    }),
                const Sized(height: 0.05,),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacementNamed(context, Routes.signup);
                  },
                  child: lightText(title: 'Don\'t  have an account? Create Account'),
                )

              ],
            ),
          )),

    );
  }
}
