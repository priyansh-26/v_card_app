// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:v_card_app/models/contact_model.dart';
import 'package:v_card_app/pages/home_page.dart';
import 'package:v_card_app/provider/contact_provider.dart';
import 'package:v_card_app/utils/constants.dart';
import 'package:v_card_app/utils/helper_functions.dart';

class FormPage extends StatefulWidget {
  static const String routeName = 'form';
  final ContactModel contactModel;
  const FormPage({super.key, required this.contactModel});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  final emailController = TextEditingController();
  final companyController = TextEditingController();
  final designationController = TextEditingController();
  final addressController = TextEditingController();
  final websiteController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    nameController.text = widget.contactModel.name;
    mobileController.text = widget.contactModel.mobile;
    emailController.text = widget.contactModel.email;
    companyController.text = widget.contactModel.company;
    designationController.text = widget.contactModel.designation;
    addressController.text = widget.contactModel.address;
    websiteController.text = widget.contactModel.website;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Form Page"),
        actions: [
          IconButton(
            onPressed: saveContact,
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "Name",
              ),
              validator: (value) {
                if (value!.isEmpty || value == null) {
                  return emptyFieldErrMsg;
                }
                return null;
              },
            ),
            TextFormField(
              keyboardType: TextInputType.phone,
              controller: mobileController,
              decoration: const InputDecoration(
                labelText: "Mobile Number",
              ),
              validator: (value) {
                if (value!.isEmpty || value == null) {
                  return emptyFieldErrMsg;
                }
                return null;
              },
            ),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: emailController,
              decoration: const InputDecoration(
                labelText: "Email",
              ),
              validator: (value) {
                if (value!.isEmpty || value == null) {
                  return emptyFieldErrMsg;
                }
                return null;
              },
            ),
            TextFormField(
              controller: companyController,
              decoration: const InputDecoration(
                labelText: "Company Name",
              ),
              validator: (value) {
                return null;
              },
            ),
            TextFormField(
              controller: designationController,
              decoration: const InputDecoration(
                labelText: "Designation",
              ),
              validator: (value) {
                return null;
              },
            ),
            TextFormField(
              controller: addressController,
              decoration: const InputDecoration(
                labelText: "Address",
              ),
              validator: (value) {
                return null;
              },
            ),
            TextFormField(
              controller: websiteController,
              decoration: const InputDecoration(
                labelText: "Website",
              ),
              validator: (value) {
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    mobileController.dispose();
    emailController.dispose();
    companyController.dispose();
    designationController.dispose();
    addressController.dispose();
    websiteController.dispose();
    super.dispose();
  }

  void saveContact() async {
    if (_formKey.currentState!.validate()) {
      widget.contactModel.name = nameController.text;
      widget.contactModel.mobile = mobileController.text;
      widget.contactModel.email = emailController.text;
      widget.contactModel.company = companyController.text;
      widget.contactModel.designation = designationController.text;
      widget.contactModel.address = addressController.text;
      widget.contactModel.website = websiteController.text;
    }
    Provider.of<ContactProvider>(context, listen: false)
        .insertContact(widget.contactModel)
        .then((value) {
      if (value > 0) {
        showMsg(context, 'Saved');
        context.goNamed(HomePage.routeName);
      }
    }).catchError((error) {
      showMsg(context, 'Failed to save');
    });
  }
}
