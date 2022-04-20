import 'package:albanote_project/etc/custom_class/base_view.dart';
import 'package:albanote_project/presentation/view_model/app/workplace/employee/employee_workplace_main_view_model.dart';
import 'package:flutter/material.dart';

class EmployeeWorkplaceMainView extends BaseView<EmployeeWorkplaceViewModel> {
  const EmployeeWorkplaceMainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildBaseAppBar(title: "employee"),
    );
  }
}
