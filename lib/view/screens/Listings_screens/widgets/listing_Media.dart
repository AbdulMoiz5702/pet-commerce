import 'package:animals/core/constants/presentation/app_colors.dart';
import 'package:animals/providers/Listing_provider/add_listing_provider.dart';
import 'package:animals/view/common/custom_button.dart';
import 'package:animals/view/common/image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/vedio_player.dart';

class ListingMediaImages extends StatelessWidget {
  const ListingMediaImages({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context,ref,_){
      var state = ref.watch(addListingProvider.select((state)=>state.images));
      var data = ref.read(addListingProvider.notifier);
      if( state == null || state.isEmpty) {
        return GridView.builder(
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
          ),
          itemCount: 4,
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColor.primaryColor),
              ),
              child: TapIcon(iconData: Icons.image,color: AppColor.secondaryColor, onTap: (){
                data.requestAndPickImages(context: context);
              }),
            );
          },
        );
      }else{
        return GridView.builder(
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
          ),
          itemCount: state.length,
          itemBuilder: (context, index) {
            return ImageWidget(imageFile: state[index],);
          },
        );
      }
    });
  }
}


class ListingMediaVideo extends StatelessWidget {
  const ListingMediaVideo({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context,ref,_){
      var state = ref.watch(addListingProvider.select((state)=>state.video));
      var data = ref.read(addListingProvider.notifier);
      if(state == null){
        return Container(
          width: MediaQuery.sizeOf(context).width * 0.9,
          height:  MediaQuery.sizeOf(context).height * 0.2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColor.primaryColor),
          ),
          child: TapIcon(iconData: Icons.video_camera_back_rounded, color: AppColor.secondaryColor,onTap: (){
            data.requestAndPickImages(context: context);
          }),
        );
      }else{
        return Container(
          width: MediaQuery.sizeOf(context).width * 0.9,
          height:  MediaQuery.sizeOf(context).height * 0.2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColor.primaryColor),
          ),
          child: VideoThumbnail(source: state),
        );
      }
    });
  }
}

