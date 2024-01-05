import 'package:delivery/constants.dart';
import 'package:delivery/controllers/network_controller.dart';
import 'package:delivery/controllers/register_controller.dart';
import 'package:delivery/widgets/button.dart';
import 'package:delivery/widgets/nointernet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
class OTPScreen extends StatelessWidget {
  OTPScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RegisterationController rc = Get.find();

    NetworkController nc=Get.find();
    return Obx(()=>nc.hasConnection.value?Scaffold(
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height:200,width:400,child:Image.asset('${assetUrl(context)}/otp.png')),
            Text('OTP Verification',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.black, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10.0),
            Text("Enter 6 digit OTP sent to your registered phone number ",
                style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(height: 5.0),

            if(rc.otp_response.isNotEmpty)
              Text('${rc.otp_response}',style:TextStyle(color:Colors.green)),
            const SizedBox(height: 20.0),


            OTPTextField(
              controller: rc.otpbox,
              length: 6,
              width: MediaQuery.of(context).size.width,
              fieldWidth: 50,
              style: TextStyle(
                  fontSize: 17
              ),
              textFieldAlignment: MainAxisAlignment.spaceAround,
              fieldStyle: FieldStyle.box,
              onCompleted: (pin) {
                rc.otp.value = pin;
                print("Entered OTP Code: $pin");
              },
            ),
            const SizedBox(height: 20.0),
             Obx(
                () => DefaultButton(context,'Submit', () {
                  print('okokok');
                  rc.verifyOtp();
                }, null, isLoading: rc.isLoading.value),
              ),
            const SizedBox(height: 20.0),
            InkWell(onTap:(){
                rc.resend_otp();
            },child: Text('Resend OTP',style:TextStyle(color:Colors.red,decoration: TextDecoration.underline)))

          ],
        ),
      )):NoInternet(context)
    );
  }
}
