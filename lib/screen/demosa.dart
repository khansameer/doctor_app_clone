import 'dart:io';

import 'package:doctor_app/core/common/common_button_widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Demosa extends StatefulWidget {
  const Demosa({super.key});

  @override
  State<Demosa> createState() => _DemosaState();
}

class _DemosaState extends State<Demosa> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:CommonButtonWidget(
          text: "pick",
          onPressed: () async {
            try
            {
              //_pickFile();
            }
            on PlatformException catch (e) {
              print('===ssss${e.toString()}');
            } catch(e){
              print('===errr${e}');
            }

          },
        ),
      ),
    );
  }
}
