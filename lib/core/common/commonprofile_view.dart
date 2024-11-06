import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:doctor_app/core/colors.dart';

import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/core/image/image_path.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';


class CommonProfileView extends StatefulWidget {
final  FilePickerResult? filePickerResult;

final double? width;
final double? height;

final String? urlImage;


  const CommonProfileView({
    super.key,
    this.filePickerResult,

    this.height,
    this.width,
    this.urlImage,
  });

  @override
  State<StatefulWidget> createState() {
    return CustomProfileWidgetState();
  }
}

class CustomProfileWidgetState extends State<CommonProfileView> {


  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipOval(
          child: Container(
            width: widget.width,
            height: widget.height,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.primary, width: 1)),
              child: buildImage())),
    );
  }




  Widget buildImage() {
    if (widget.filePickerResult != null) {

      if(kIsWeb){
     return   ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child:  Image.memory(
            widget.filePickerResult?.files.first.bytes??Uint8List(0),
            width: widget.width,
            height: widget.height,
            fit: BoxFit.cover,
          ),
        );
      }
      else
        {

          return ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child:  Image.file(
              File( widget.filePickerResult?.files.first.path??''),
              width: widget.width,
              height: widget.height,
              fit: BoxFit.cover,
            ),
          );
        }



    }

    if (widget.urlImage != null) {
      return ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: CachedNetworkImage(
        alignment: Alignment.center,
        placeholder: (context, url) => showLoaderList(),
        errorWidget: (context, url, error) => ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.asset(
          icDummyUser,
          width: widget.width,
          height: widget.height,
          fit: BoxFit.scaleDown,
        )),
        imageUrl: widget.urlImage ?? '',
        fit: BoxFit.fitHeight,
        imageBuilder: (context, imageProvider) => Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
          ),
        ),
      ));
    } else {
      //when i am used  AppUtils.containerDecoration UI was not rendring perfact then i am used this normal box BoxDecoration
      return ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: Image.asset(
        icMen,
        width: widget.width,
        height: widget.height,
        fit: BoxFit.cover,
      ));
    }
  }





}
