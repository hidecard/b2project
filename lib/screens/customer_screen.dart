import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/customer.dart';
import '../models/customer.dart';


class CustomerScreen extends StatefulWidget {
  final CustomerController customerController = Get.find<CustomerController>();
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  CustomerScreen({super.key});

  @override
  State<CustomerScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}