import 'package:flutter/material.dart';
import 'package:mvvm/res/components/round_button.dart';
import 'package:mvvm/utils/routes/routes_name.dart';
import 'package:mvvm/utils/utils.dart';
import 'package:mvvm/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  ValueNotifier<bool> _obsecurePassword = ValueNotifier<bool>(true);
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    _obsecurePassword.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authViewMode = Provider.of<AuthViewModel>(context);
    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Signup'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              focusNode: emailFocusNode,
              onFieldSubmitted: (value) {
                Utils.fieldFocusChange(
                    context, emailFocusNode, passwordFocusNode);
              },
              decoration: const InputDecoration(
                  hintText: 'Email',
                  label: Text('Email'),
                  prefixIcon: Icon(Icons.alternate_email)),
            ),
            ValueListenableBuilder(
                valueListenable: _obsecurePassword,
                builder: (context, value, child) {
                  return TextFormField(
                    controller: _passwordController,
                    obscureText: _obsecurePassword.value,
                    focusNode: passwordFocusNode,
                    obscuringCharacter: "*",
                    decoration: InputDecoration(
                        hintText: 'Password',
                        label:const Text('Password'),
                        prefixIcon:const Icon(Icons.password),
                        suffixIcon: InkWell(
                          onTap: () {
                            _obsecurePassword.value = !_obsecurePassword.value ;
                          },
                          child: Icon(_obsecurePassword.value?Icons.visibility_off_outlined:Icons.visibility))),
                  );
                }),
                SizedBox(height: height * .085,),
                RoundButton(
                title: "Signup", 
                loading: authViewMode.signUpLoading,
                onPress:(){
                  if(_emailController.text.isEmpty){
                    Utils.flushBarErrorMessage("Please enter email", context);
                  }
                  else if(_passwordController.text.isEmpty){
                    Utils.flushBarErrorMessage("Please enter password", context);
                  }
                  else if(_passwordController.text.length<6){
                    Utils.flushBarErrorMessage("Password length must be greater than 6", context);
                  }
                  else{
                    Map data={
                      'email': _emailController.text.toString(),
                      'password': _passwordController.text.toString()
                    };
                    authViewMode.loginApi(data, context);
                  }
                }),
                SizedBox(height: height * .085,),
                InkWell(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: const Text("Already have an account? Login"))
          ],
        ),
      ),
    );
  }
}
