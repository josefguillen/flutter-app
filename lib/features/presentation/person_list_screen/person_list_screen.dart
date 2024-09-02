import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterexamapp/core/constants/strings.dart';
import 'package:flutterexamapp/features/presentation/widgets/app_scaffold.dart';

class PersonListScreen extends StatelessWidget {
  const PersonListScreen({super.key});

  static String routeName = "/userList";

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: Strings.titlePersonList.toUpperCase(),
      body: Container(),
    );
  }
}
