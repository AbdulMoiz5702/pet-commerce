import 'package:animals/core/routes/routes.dart';
import 'package:animals/view/common/text_widgets.dart';
import 'package:animals/view/screens/auth_screens/widgets/buildStrength.dart';
import 'package:animals/view/screens/auth_screens/widgets/valadation_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/presentation/app_colors.dart';
import '../../../core/utils/helper_fuctions/format_validator.dart';
import '../../../providers/auth_providers/signup_provider.dart';
import '../../common/custom_button.dart';
import '../../common/custom_loading.dart';
import '../../common/custom_sizedBox.dart';
import '../../common/custom_textfeild.dart';



class SignupScreen extends ConsumerWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    var provider = ref.watch(signupProvider.notifier);
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
                CustomTextField(controller: provider.nameController, hintText: 'Name', validate: (value){
                  return  FormValidators.validateNormalField(value, 'Name');
                }),
                const Sized(height: 0.02,),
                CustomTextField(controller: provider.emailController, hintText: 'Email', validate: (value){
                  return  FormValidators.validateEmail(value);
                }),
                const Sized(height: 0.02,),
                CustomTextField(
                    controller: provider.passwordController, hintText: 'Password',
                    validate: (value){return  FormValidators.validatePassword(value);},
                    onChanged: (value){
                      ref.read(signupProvider.notifier).updatePasswordStrength();
                  },
                ),
                const Sized(height: 0.02,),
                CustomTextField(controller: provider.confirmPassword, hintText: 'Re type', validate: (value){
                  return FormValidators.validateConfirmPassword(value,provider.confirmPassword.text);
                }),
                const Sized(height: 0.02,),
                Consumer(
                  builder: (context, reference, _) {
                    var buildState = reference.watch(signupProvider.select((state)=> state.password));
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        buildStrengthContainer(FormValidators.strength(buildState) == 1, AppColor.errorColor),
                        const SizedBox(width: 8),
                        buildStrengthContainer(FormValidators.strength(buildState) == 2, AppColor.warningColor),
                        const SizedBox(width: 8),
                        buildStrengthContainer(FormValidators.strength(buildState) == 3, AppColor.successColor),
                      ],
                    );
                  },
                ),
                const Sized(height: 0.02,),
                Consumer(
                    builder: (context,reference,_){
                      var buildState = reference.watch(signupProvider.select((state)=> state.password));
                      return Column(
                        children: [
                          buildValidationItem("At least 8 characters", FormValidators.hasMinLength(buildState)),
                          buildValidationItem("Contains an uppercase letter", FormValidators.hasUpperCase(buildState)),
                          buildValidationItem("Contains a special character", FormValidators.hasSpecialChar(buildState)),
                        ],
                      );
                    }),
                const Sized(height: 0.05,),
                Consumer(
                    builder: (context,reference,_){
                      var data = reference.watch(signupProvider.select((state)=> state.isLoading));
                      return data == true ? const CustomLoading() : CustomButton(title: 'Signup', onTap: (){
                        if(key.currentState!.validate()){
                          reference.read(signupProvider.notifier).signupUser(context: context);
                        }
                      });
                }),
                const Sized(height: 0.05,),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacementNamed(context, Routes.login);
                  },
                  child: lightText(title: 'Already have an account? Login'),
                )
              ],
            ),
          )),

    );
  }
}
