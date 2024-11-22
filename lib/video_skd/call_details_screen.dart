import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../core/app_constants.dart';
import '../core/common/common_text_widget.dart';
import '../core/responsive.dart';
import '../provider/appointments_provider.dart';
import '../provider/patient_provider.dart';
import '../screen/agora_video_call.dart';
class CallDetailsScreen extends StatelessWidget {
  const CallDetailsScreen({super.key});




  Future<void> getTrackRecording() async {


    final response = await http.get(
      Uri.parse(
          'https://api.videosdk.live/v2/recordings?roomId=3dsq-mqv9-6871&page=1&perPage=10'),
      headers: {
        "Authorization": token,
        "Content-Type": "application/json",
      },
      /* body: jsonEncode(body),*/
    );
    print("==========+End${response.statusCode}");
    print("==========+End${response.body}");
    if (response.statusCode == 200) {
      // print(jsonDecode(response.body));

    } else {
      print('Failed to stop track recording');
    }
  }

  Future<void> getTextRecording() async {


    final response = await http.get(
      Uri.parse(
          'https://api.videosdk.live/ai/v1/post-transcriptions/?roomId=3dsq-mqv9-6871&page=1&perPage=20'),
      headers: {
        "Authorization": token,
        "Content-Type": "application/json",
      },
      /* body: jsonEncode(body),*/
    );
    print("==========+End${response.statusCode}");
    print("==========+End${response.body}");
    if (response.statusCode == 200) {
      // print(jsonDecode(response.body));

    } else {
      print('Failed to stop track recording');
    }
  }
  @override
  Widget build(BuildContext context) {
    var isMobile = Responsive.isMobile(context);
    var isDesktop = Responsive.isDesktop(context);
    var size = MediaQuery.sizeOf(context);
    final formAddApt = GlobalKey<FormState>();
    var width = MediaQuery.of(context).size.width;
    final provider = context.read<PatientProvider>();
    final providerApt = context.read<AppointmentsProvider>();
    return SizedBox(
      width: isMobile
          ? width * zero9
          : isDesktop
          ? width * 0.3
          : width * 0.19,
      child: Form(
        key: formAddApt,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CommonTextWidget(
                              text: "Call Details Screen",
                              fontSize: 16,
                              textAlign: TextAlign.center,
                              fontWeight: FontWeight.w700,
                              // top: 20,
                            ),
                            IconButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                icon: const Icon(
                                  Icons.close,
                                  size: 18,
                                  color: Colors.black,
                                ))
                          ],
                        ),
                        const SizedBox(height: 20),




                      ],
                    ),
                  ),
                ),
              /*  context.watch<AppointmentsProvider>().isAdding
                    ? showLoaderList()
                    : const SizedBox.shrink()*/
              ],
            ),
          ],
        ),
      ),
    );
  }
}
