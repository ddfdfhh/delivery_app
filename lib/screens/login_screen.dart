import 'package:delivery/constants.dart';
import 'package:delivery/controllers/login_controller.dart';
import 'package:delivery/controllers/network_controller.dart';
import 'package:delivery/controllers/register_controller.dart';
import 'package:delivery/theme.dart';
import 'package:delivery/widgets/button.dart';
import 'package:delivery/widgets/nointernet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _autovalidate = false;
  @override
  Widget build(BuildContext context) {
   LoginController lc = Get.put(LoginController());
   NetworkController nc=Get.find();
    return Obx(()=>nc.hasConnection.value?
         SafeArea(
        child:  Scaffold(
          resizeToAvoidBottomInset:true,
          // extendBodyBehindAppBar: true,
          backgroundColor: AppTheme(context:context).colors['primary'],

          body: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.40,

                child: Padding(
                  padding: const EdgeInsets.all(2),
                  child: SizedBox(
                    // height: 100,
                    child: Image.asset(
                      '${assetUrl(context)}/del-boy3.png',
                      // height: 100,
                      // fit:BoxFit.fill
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25.0),
                      topRight: Radius.circular(25.0),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        //  width: 300,
                          child: Text(
                            'Login to your account',
                            style:
                            AppTheme(context:context).textTheme["headingSmallBlack"],
                            // textAlign: TextAlign.left,
                          )),
                      SizedBox(height:40),
                      SizedBox(width:270,
                        child: Form(
                            key: lc.formKey,
                            autovalidateMode: _autovalidate
                                ? AutovalidateMode.always
                                : AutovalidateMode.disabled,
                            child:
                            TextFormField(
                              textAlign: TextAlign.center,
                          controller: lc!.phoneController,
                          validator: (val) {
                            return lc!.validatePhone();
                          },
                          //maxLength: 10,
                          maxLines: 1,
                          minLines: 1,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            //labelText: "Phone number",
                              hintText: "Enter registered phone number",
                              contentPadding: EdgeInsets.all(
                                  5), //  <- you can it to 0.0 for no space
                              isDense: true,
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey)),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.purple))
                            //border: InputBorder.none
                          ),
                        )),
                      ),
                      SizedBox(height:40),
                      // Text('eSchool serve you virtual education at your home',style:AppTheme(context).text["titleLargeBlackLight"],textAlign: TextAlign.center,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Obx(
                              () => DefaultButton(context,"Login", () {
                            if (lc!.formKey.currentState!.validate()) {

                              lc!.sub();
                            } else {
                              setState(() {
                                _autovalidate = true;
                              });
                            }
                          }, null,
                              isLoading: lc.isLoading.value),
                        ),
                      ),
                      // AppTheme(context).Buttonwithtransparentbackground("Login"),
                    ],
                  ),
                ),
              )
            ],
          ),
        )

    ):NoInternet(context)
    );
  }
}
