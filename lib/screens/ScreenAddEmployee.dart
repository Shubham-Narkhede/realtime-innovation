import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:realtime_innovation/cubit/CubitSqFliteDatabse.dart';
import 'package:realtime_innovation/helper/HelperExtension.dart';
import 'package:realtime_innovation/helper/HelperFunction.dart';
import 'package:realtime_innovation/helper/HelperNavigation.dart';
import 'package:realtime_innovation/models/ModelUser.dart';
import 'package:realtime_innovation/widgets/WidgetAppBar.dart';
import 'package:realtime_innovation/widgets/WidgetTextField.dart';

import '../widgets/WidgetAssetImage.dart';
import '../widgets/WidgetRowButton.dart';
import '../widgets/WidgetUserRoles.dart';

class ScreenAddEmployee extends StatefulWidget {
  ModelUser? user;
  ScreenAddEmployee({this.user});
  @override
  _ScreenAddEmployeeState createState() => _ScreenAddEmployeeState();
}

class _ScreenAddEmployeeState extends State<ScreenAddEmployee> {
  TextEditingController controllerEmpName = TextEditingController();
  TextEditingController controllerRole = TextEditingController();
  TextEditingController controllerFromDate = TextEditingController();
  TextEditingController controllerToDate = TextEditingController();

  final key = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    if (widget.user != null) {
      assignInfo();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: WidgetAppBar(
        title: " ${widget.user != null ? "Edit" : "Add"} Employee Details",
      ),
      body: Form(
        key: key,
        child: Container(
          padding: EdgeInsets.only(top: 24.sp, left: 16.sp, right: 16.sp),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      WidgetTextFormField(
                        modelTextField: ModelTextField(isCompulsory: true),
                        enumValidator: EnumValidator.text,
                        frontIconDynamic: WidgetAssetImage(
                          imagePath: "emp",
                          width: 20,
                        ),
                        controller: controllerEmpName,
                        hintText: "Employee name",
                      ),
                      WidgetTextFormField(
                        modelTextField: ModelTextField(isCompulsory: true),
                        enumValidator: EnumValidator.text,
                        frontIconDynamic: WidgetAssetImage(
                          imagePath: "role",
                          width: 20,
                        ),
                        controller: controllerRole,
                        hintText: "Select Role",
                        eNum: EnumTextField.dropdown,
                        suffixIcon: Icon(
                          Icons.arrow_drop_down,
                          color: Theme.of(context).primaryColor,
                        ),
                        onTap: () {
                          ModalBottomSheet.moreModalBottomSheet(context,
                              (value) {
                            controllerRole.text = value;
                          });
                        },
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: WidgetTextFormField(
                              modelTextField:
                                  ModelTextField(isCompulsory: true),
                              enumValidator: EnumValidator.text,
                              bottomMargin: 0,
                              controller: controllerFromDate,
                              hintText: "Today",
                              eNum: EnumTextField.datePicker,
                              selectedDate: (value) {
                                controllerFromDate.text =
                                    HelperFunction.dateFormat(
                                        "dd MMM yyyy", value);
                              },
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 19.sp),
                            child: Icon(
                              Icons.arrow_forward,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          Expanded(
                            child: WidgetTextFormField(
                              bottomMargin: 0,
                              controller: controllerToDate,
                              hintText: "No Date",
                              isToDate: true,
                              eNum: EnumTextField.datePicker,
                              selectedDate: (value) {
                                controllerToDate.text =
                                    HelperFunction.dateFormat(
                                        "dd MMM yyyy", value);
                              },
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              WidgetRowButton(
                onTapSave: () {
                  if (key.currentState!.validate()) {
                    addUpdateEmployee(ModelUser(
                        id: widget.user != null ? widget.user!.id : null,
                        userName:
                            controllerEmpName.text.toString().capitalize(),
                        userRole: controllerRole.text.toString(),
                        fromDate: controllerFromDate.text.toString(),
                        toDate: controllerToDate.text.toString()));
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  assignInfo() {
    controllerEmpName.text = widget.user!.userName;
    controllerRole.text = widget.user!.userRole;
    controllerFromDate.text = widget.user!.fromDate;
    controllerToDate.text = widget.user!.toDate;
  }

  addUpdateEmployee(ModelUser user) {
    SqFlitDatabaseCubit cubit = SqFlitDatabaseCubit.get(context);
    if (widget.user != null) {
      cubit.updateUserInfo(user);
    } else {
      cubit.addUser(user);
    }
    HelperNavigation.instance.navigatePop(context);
  }
}
