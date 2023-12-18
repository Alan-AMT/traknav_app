import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:traknav_app/ui/config/toasts/main.dart';
import 'package:traknav_app/ui/presentation/home/cubit/home_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:traknav_app/ui/router/android.gr.dart';
//Libreria para usar variables globales:
import '../global/globals.dart' as globalss;

class SignUpForm extends StatelessWidget {
  SignUpForm({Key? key}) : super(key: key);

  final signUpKey = GlobalKey<FormBuilderState>();

  Future<void> onFormSent(BuildContext context) async {
    if (signUpKey.currentState?.saveAndValidate() ?? false) {
      try {
        await EasyLoading.show();
        final name = signUpKey.currentState!.fields["name"]!.value;
        final email = signUpKey.currentState!.fields["email"]!.value;
        final password = signUpKey.currentState!.fields["password"]!.value;
        final city = signUpKey.currentState!.fields["city"]!.value;
        final phone = signUpKey.currentState!.fields["phone"]!.value;
        final userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        //globalss.globalUserCredential = userCredential;
        //globalss.globalUserCredential;
        final usersCollection = FirebaseFirestore.instance.collection('users');
        await usersCollection.doc(userCredential.user?.uid).set({
          "name": name,
          "city": city,
          "phone": phone,
          "favourites": [],
          "recommendations": []
        });
        // await FirebaseAuth.instance.sendSignInLinkToEmail(email: email, actionCodeSettings: actionCodeSettings)
        await EasyLoading.dismiss();
        AutoRouter.of(context).navigate(const RecommendationsRoute());
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
          key: signUpKey,
          child: Column(
            children: <Widget>[
              FormBuilderTextField(
                name: "email",
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.formEmail,
                  labelText: AppLocalizations.of(context)!.formEmail,
                  suffixIcon: const Icon(Icons.email),
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
                name: "name",
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.formName,
                  labelText: AppLocalizations.of(context)!.formName,
                  suffixIcon: const Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                      errorText: AppLocalizations.of(context)!.errorRequired),
                ]),
              ),
              const SizedBox(
                height: 30.0,
              ),
              FormBuilderTextField(
                name: "phone",
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                maxLength: 10,
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.formPhone,
                  labelText: AppLocalizations.of(context)!.formPhone,
                  suffixIcon: const Icon(Icons.phone),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                      errorText: AppLocalizations.of(context)!.errorRequired),
                  FormBuilderValidators.numeric(
                      errorText: AppLocalizations.of(context)!.errorPhone),
                  FormBuilderValidators.minLength(10,
                      errorText: AppLocalizations.of(context)!.errorPhone)
                ]),
              ),
              const SizedBox(
                height: 30.0,
              ),
              FormBuilderTextField(
                name: "password",
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                textInputAction: TextInputAction.next,
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
                      errorText: AppLocalizations.of(context)!.errorRequired),
                  (String? val) {
                    final missed = ["la contraseña debe tener al menos: "];
                    final validations = {
                      r'[a-z]': "Una letra minúscula",
                      r'[A-Z]': "Una letra mayúscula",
                      r'\d': "Un número",
                      r'[!@#\$%^&*(),.?":{}|<>]': "Un carácter especial",
                      r'.{8,}': "Al menos 8 caracteres"
                    };
                    validations.forEach((key, value) {
                      RegExp(key).hasMatch(val!) ? null : missed.add(value);
                    });
                    if (missed.length > 1) {
                      return missed.join("\n- ");
                    }
                    return null;
                  },
                ]),
              ),
              const SizedBox(
                height: 30.0,
              ),
              FormBuilderTextField(
                name: "city",
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.send,
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.formCity,
                  labelText: AppLocalizations.of(context)!.formCity,
                  suffixIcon: const Icon(Icons.location_city),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                      errorText: AppLocalizations.of(context)!.errorRequired),
                ]),
              ),
              const Divider(
                height: 30.0,
              ),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () async {
                    await onFormSent(context);
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 15, 106, 180),
                    padding: const EdgeInsets.all(13.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40.0),
                    ),
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.signupTapTitle,
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
