import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:traknav_app/ui/config/toasts/main.dart';
import 'package:traknav_app/ui/presentation/home/cubit/home_cubit.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:traknav_app/ui/router/android.gr.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginForm extends StatelessWidget {
  LoginForm({Key? key}) : super(key: key);
  final loginKey = GlobalKey<FormBuilderState>();

  Future<void> login(BuildContext context) async {
    if (loginKey.currentState?.saveAndValidate() ?? false) {
      try {
        await EasyLoading.show();
        final email = loginKey.currentState!.fields["email"]!.value;
        final password = loginKey.currentState!.fields["password"]!.value;
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        AutoRouter.of(context).navigate(const HomeRoute());
        await EasyLoading.dismiss();
      } catch (_) {
        await EasyLoading.dismiss();
        await ToastApp.error(AppLocalizations.of(context)!.failedSignIn);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
      return FormBuilder(
          key: loginKey,
          child: Column(
            children: <Widget>[
              FormBuilderTextField(
                name: "email",
                keyboardType: TextInputType.emailAddress,
                enableInteractiveSelection: false,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.formEmail,
                  labelText: AppLocalizations.of(context)!.formEmail,
                  suffixIcon: const Icon(Icons.alternate_email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                      errorText: AppLocalizations.of(context)!.errorRequired),
                  FormBuilderValidators.email(
                      errorText: AppLocalizations.of(context)!.errorEmail)
                ]),
              ),
              const SizedBox(
                height: 30.0,
              ),
              FormBuilderTextField(
                  name: "password",
                  obscureText: true,
                  enableInteractiveSelection: false,
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.formPassword,
                    labelText: AppLocalizations.of(context)!.formPassword,
                    suffixIcon: const Icon(Icons.lock_outline),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                        errorText: AppLocalizations.of(context)!.errorRequired)
                  ])),
              const Divider(
                height: 30.0,
              ),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () async {
                    await login(context);
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 15, 106, 180),
                    padding: const EdgeInsets.all(13.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40.0),
                    ),
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.signinTapTitle,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontFamily: 'Nunito',
                    ),
                  ),
                ),
              ),
            ],
          ));
    });
  }
}
