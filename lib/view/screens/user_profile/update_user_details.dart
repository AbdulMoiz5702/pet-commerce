import 'package:animals/models/user_model/user_profle_model.dart';
import 'package:animals/view/common/custom_textfeild.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/user_profile_provider/update_profile_provider.dart';
import '../../common/custom_button.dart';
import '../../common/custom_loading.dart';
import '../../common/custom_sizedBox.dart';
import '../../common/text_widgets.dart';


class UpdateUserDetails extends ConsumerStatefulWidget {
  final UserProfile userModel;
  const UpdateUserDetails({super.key, required this.userModel});

  @override
  _UpdateUserProfileState createState() => _UpdateUserProfileState();
}

class _UpdateUserProfileState extends ConsumerState<UpdateUserDetails> {

  @override
  void initState() {
    super.initState();
    Future.microtask((){
      var provider = ref.watch(userProfileUpdate.notifier);
      provider.description.text =  widget.userModel.description;
      provider.location.text =  widget.userModel.location;
      provider.phone.text =  widget.userModel.phone;
    });
  }


  @override
  Widget build(BuildContext context) {
    var provider = ref.watch(userProfileUpdate.notifier);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: mediumText(title: 'Edit Details'),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          children: [
            const Sized(height: 0.05,),
            CustomTextField(
              keyboardType: TextInputType.streetAddress,
              controller: provider.location,
              hintText: 'Location',
              validate: (value) {},
            ),
            const Sized(height: 0.02,),
            CustomTextField(
              keyboardType: TextInputType.phone,
              controller: provider.phone,
              hintText: 'Phone',
              validate: (value) {},
            ),
            const Sized(height: 0.02,),
            CustomTextField(
              maxLine: 4,
              controller: provider.description,
              hintText: 'Description',
              validate: (value) {},
            ),
            const Sized(height: 0.05,),
            Consumer(builder: (context,ref,_){
              var data = ref.watch(userProfileUpdate.select((state)=> state.isSecondLoading));
              return data == true ? const CustomLoading(): CustomButton(title: 'Save', onTap: (){
                ref.read(userProfileUpdate.notifier).updateUserDetails(context: context);
              });
            })

          ],
        ),
      ),
    );
  }
}

