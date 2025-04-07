import 'package:animals/models/user_model/user_profle_model.dart';
import 'package:animals/view/screens/user_profile/widgets/profile_picture_update_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/utils/helper_fuctions/format_validator.dart';
import '../../../providers/user_profile_provider/update_profile_provider.dart';
import '../../common/custom_button.dart';
import '../../common/custom_loading.dart';
import '../../common/custom_sizedBox.dart';
import '../../common/custom_textfeild.dart';
import '../../common/text_widgets.dart';


class UpdateUserProfile extends ConsumerStatefulWidget {
  final UserProfile userModel;
  const UpdateUserProfile({super.key, required this.userModel});

  @override
  _UpdateUserProfileState createState() => _UpdateUserProfileState();
}

class _UpdateUserProfileState extends ConsumerState<UpdateUserProfile> {

  @override
  void initState() {
    super.initState();
    Future.microtask((){
      var provider = ref.watch(userProfileUpdate.notifier);
      provider.name.text =  widget.userModel.name;
      provider.state = provider.state.copyWith(imageUrl: widget.userModel.imageUrl);
      print('provider.state.url ${provider.state.imageUrl}');
    });
  }


  @override
  Widget build(BuildContext context) {
    var key = GlobalKey<FormState>();
    var provider = ref.watch(userProfileUpdate.notifier);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: mediumText(title: 'Edit Profile'),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Form(
          key: key,
          child: Column(
            children: [
              const Sized(height: 0.05,),
              const ProfilePictureUpdateBox(),
              const Sized(height: 0.02,),
              CustomTextField(
                keyboardType: TextInputType.streetAddress,
                controller: provider.name,
                hintText: 'Name',
                validate: (value) {
                  return FormValidators.validateNormalField(value, 'Name');
                },
              ),
              const Sized(height: 0.05,),
              Consumer(builder: (context,ref,_){
                var data = ref.watch(userProfileUpdate.select((state)=> state.isLoading));
                return data == true ? const CustomLoading(): CustomButton(title: 'Save', onTap: (){
                 if(key.currentState!.validate()){
                   ref.read(userProfileUpdate.notifier).updateUserProfile(context: context);
                 }
                });
              })

            ],
          ),
        ),
      ),
    );
  }
}

