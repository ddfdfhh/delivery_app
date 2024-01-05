import 'package:delivery/widgets/button.dart';
import 'package:delivery/constants.dart';
import 'package:delivery/controllers/network_controller.dart';
import 'package:delivery/controllers/register_controller.dart';
import 'package:delivery/routes.dart';
import 'package:delivery/theme.dart';
import 'package:delivery/widgets/nointernet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _autovalidate = false;
  final RegisterationController c = Get.put(RegisterationController());
  @override
  Widget build(BuildContext context) {
    bool _autovalidate = false;

    NetworkController nc=Get.find();
    return Obx(()=>nc.hasConnection.value?Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white10,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.only(
                    left:10,right:10,
                    bottom: MediaQuery.of(context).viewInsets.bottom),
          child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                        height: 100,
                        width: 100,
                        child: Image.asset('${assetUrl(context)}/logo.png')),
                    SizedBox(height: 10),
                    Text("Welcome Back",
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    Text("Create your account ",
                        style: AppTheme(context: context).textTheme['light']),
                    SizedBox(height: 40),
                    SizedBox(
                        width: 400,
                        //height: 250,
                        child: Form(
                            key: c.formKey,
                            autovalidateMode: _autovalidate
                                ? AutovalidateMode.always
                                : AutovalidateMode.disabled,
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  NameField(c),
                                  SizedBox(height: 30),
                                  EmailTextField(c),
                                  SizedBox(height: 30),
                                  PhoneField(c),
                                  SizedBox(height: 30),
                                  // PasswordTextField(c),
                                  // SizedBox(height: 30),
                                  Obx(
                                    () =>
                                        DefaultButton(context, "Submit", () {
                                      if (c!.formKey.currentState!
                                          .validate()) {
                                        c!.registerWithEmail();
                                      } else {
                                        setState(() {
                                          _autovalidate = true;
                                        });
                                      }
                                    }, null, isLoading: c!.isLoading.value),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('Already Registered?',
                                          style: AppTheme(context: context)
                                              .textTheme['light']),
                                      TextButton(
                                          onPressed: () {
                                            Get.toNamed(AppRoutes.login);
                                          },
                                          child: const Text('Signin')),
                                    ],
                                  )
                                ])))
                  ])),
        ))):NoInternet(context));
  }

  OutlineInputBorder outlineInputBorder() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(width: .3));
  }

  Widget PhoneField(RegisterationController? c) {
    return TextFormField(
      keyboardType: TextInputType.phone,
      controller: c!.phoneController,
      validator: (val) {
        return c!.validatePhone();
      },
      decoration: InputDecoration(
        enabledBorder: outlineInputBorder(),
        focusedBorder: outlineInputBorder(),
        border: outlineInputBorder(),
        labelText: "Phone Number",
        hintText: "Enter your mobile no",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  Widget NameField(RegisterationController? c) {
    return TextFormField(
      controller: c!.nameController,
      validator: (val) {
        return c!.validateName();
      },
      decoration: InputDecoration(
        enabledBorder: outlineInputBorder(),
        focusedBorder: outlineInputBorder(),
        border: outlineInputBorder(),
        labelText: "Name",
        hintText: "Enter your name",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  Widget EmailTextField(RegisterationController? c) {
    return TextFormField(
      controller: c!.emailController,
      validator: (val) {
        return c!.validateEmail();
      },
      decoration: InputDecoration(
          enabledBorder: outlineInputBorder(),
          focusedBorder: outlineInputBorder(),
          border: outlineInputBorder(),
          labelText: "Email",
          hintText: "Enter your email",
          floatingLabelBehavior: FloatingLabelBehavior.always,
         // suffixIcon: Icon(Icons.email)
     ),
    );
  }

  Widget PasswordTextField(RegisterationController? c) {
    return TextFormField(
      controller: c!.passwordController,
      validator: (val) {
        return c!.validatePassword();
      },
      obscureText: c!.showPassword.value ? false : true,
      decoration: InputDecoration(
          enabledBorder: outlineInputBorder(),
          focusedBorder: outlineInputBorder(),
          border: outlineInputBorder(),
          labelText: "Password",
          hintText: "Enter your password",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: IconButton(
            icon: Icon(c!.showPassword.value
                ? Icons.visibility
                : Icons.visibility_off),
            onPressed: () {
              c!.showPassword.value = !c!.showPassword.value;
            },
          )),
    );
  }
}
