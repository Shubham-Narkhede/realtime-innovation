import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'package:realtime_innovation/helper/HelperColor.dart';
import 'package:realtime_innovation/helper/HelperNavigation.dart';

import 'WidgetAssetImage.dart';
import 'WidgetButton.dart';
import 'widgetCalendart/WidgetCustomDatePicker.dart';
import 'WidgetText.dart';

/// this widget is use for text field
enum EnumTextFieldTitle { sideTitle, topTitle }

enum EnumTextField {
  none,
  datePicker,
  dropdown,
  verified,
  unverified,
}

enum EnumTextInputType {
  mobile,
  email,
  capitalLettersWithDigitsNoSpecialChars, //eg:ifsc
  onlyDigits, //eg:bank account no
  capitalLettersWithDigitsWithSpecialChars,
  onlyLetters, //eg:bank name
  panCardNumber,
  digitsWithDecimal,
  birthDate,
  vehicleNumber
}

enum EnumValidator {
  mobile,
  email,
  ifsc,
  adhar,
  text,
  panCard,
  passport,
  voterId,
  gstNumber,
  bankAccountNo,
  pincode,
  vehicleNo,
  upiId
}

class ModelTextField {
  String? title;
  EnumTextFieldTitle? enumTextFieldTitle;
  bool? isCompulsory, isEnable;

  ModelTextField({
    this.title,
    this.enumTextFieldTitle = EnumTextFieldTitle.topTitle,
    this.isCompulsory = false,
    this.isEnable = true,
  });
}

class WidgetTextFormField extends StatefulWidget {
  EnumTextField? eNum;
  final EnumTextInputType? enumTextInputType;
  final EnumValidator? enumValidator;
  final EnumWidgetSize? size;
  String? heleperText, suffixText, hintText, dropDownPreSelectedId, errorText;
  final int? maxLength;
  final int? maxLines;
  final int? minLines; // should be always less than maxLines

  final Color? fillColor;
  final Color? borderColor;

  final bool? isLoading; //isCompulsory
  final bool? obscureText;
  final DateTime? initialDate, firstDate;
  final Widget? frontIconDynamic, backIconDynamic;

  final TextEditingController controller;

  final Function(DateTime)? selectedDate;
  final Function(DateTimeRange)? selectedDateRage;

  final Function(String)? onChanged;
  final Function(String)? onSearch;

  final Function(String)? validator;

  final Function? onDelete;
  final VoidCallback? onEditingComplete;
  final Function? onEdit;

  final Function? clear;
  final Function? onTap;

  final TextStyle? errorStyle;

  final double? bottomMargin;
  final ModelTextField? modelTextField;

  final TextStyle? suffixTextStyle;
  TextAlign? textAlign;
  String? labelText;
  double? borderRadius;
  Widget? suffixIcon;
  bool isToDate;

  WidgetTextFormField(
      {Key? key,
      required this.controller,
      this.enumTextInputType,
      this.eNum,
      this.enumValidator,
      this.dropDownPreSelectedId,
      this.heleperText,
      this.hintText,
      this.suffixText,
      this.errorText,
      this.maxLength,
      this.fillColor,
      this.borderColor,
      this.isLoading,
      this.frontIconDynamic,
      this.backIconDynamic,
      this.validator,
      this.selectedDate,
      this.selectedDateRage,
      this.onChanged,
      this.onDelete,
      this.clear,
      this.onEdit,
      this.onTap,
      this.onSearch,
      this.errorStyle,
      this.bottomMargin,
      this.initialDate,
      this.size,
      this.maxLines = 1,
      this.minLines,
      this.modelTextField,
      this.onEditingComplete,
      this.obscureText,
      this.firstDate,
      this.suffixTextStyle,
      this.textAlign,
      this.labelText,
      this.borderRadius = 4,
      this.suffixIcon,
      this.isToDate = false});

  @override
  _WidgetTextFormFieldState createState() => _WidgetTextFormFieldState();
}

class _WidgetTextFormFieldState extends State<WidgetTextFormField> {
  bool isError = false;
  @override
  void initState() {
    super.initState();
    widget.eNum ?? EnumTextField.none;
  }

  Color iconColor = const Color(0xff656565);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.modelTextField?.enumTextFieldTitle ==
            EnumTextFieldTitle.topTitle)
          if (widget.modelTextField?.title != null)
            Container(
                margin: const EdgeInsets.only(bottom: 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [widgetTextTitle(), widgetIsCompulsory()],
                )),
        Container(
          height: widget.size == EnumWidgetSize.sm ? 55 : null,
          padding: EdgeInsets.only(
              bottom:
                  widget.bottomMargin != null ? widget.bottomMargin! : 23.sp),
          child: Row(
            children: [
              if (widget.modelTextField?.enumTextFieldTitle ==
                  EnumTextFieldTitle.sideTitle)
                if (widget.modelTextField?.title != null)
                  Flexible(
                    flex: 1,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Container(
                            margin: const EdgeInsets.only(left: 7),
                            child: widgetTextTitle(),
                          ),
                        ),
                        widgetIsCompulsory()
                      ],
                    ),
                  ),
              Flexible(flex: 4, child: widgetTextField()),
            ],
          ),
        )
      ],
    );
  }

  Widget widgetTextTitle() {
    return Container(
      margin: const EdgeInsets.only(bottom: 3),
      child: Text(
        widget.modelTextField!.title!,
        maxLines: 3,
        style: textStyle(
            fontSize: 15,
            textColor: Colors.grey.shade700,
            fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget widgetIsCompulsory() {
    return Visibility(
        visible: widget.modelTextField?.isCompulsory == true &&
            widget.modelTextField!.title!.isNotEmpty,
        child: const Text(
          '*',
          style: TextStyle(color: Colors.red),
        ));
  }

  Widget widgetTextField() {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            maxLines: widget.maxLines,
            minLines: widget.minLines,
            autofocus: false,
            //checking widget.eNUm==null because if we click same textfield more than once it gets assign null so
            //i am checking null condition
            readOnly: widget.eNum == EnumTextField.none || widget.eNum == null
                ? false
                : true,
            controller: widget.controller,
            obscureText: widget.obscureText ?? false,
            maxLength: widget.maxLength,
            //if custom validator is provided it will override widget.enumValidator
            validator: (value) => widget.validator != null
                ? widget.validator!(value!)
                : widget.enumValidator != null
                    ? validation(value!)
                    : null,

            enabled: widget.modelTextField != null
                ? widget.modelTextField?.isEnable == true
                    ? true
                    : false
                : true,
            onChanged: widget.onChanged == null
                ? null
                : (value) => widget.onChanged!(value),
            onEditingComplete: widget.onEditingComplete,
            keyboardType: keyBoardType(),
            textInputAction: TextInputAction.next,
            style: TextStyle(
              fontSize: () {
                switch (widget.size) {
                  case EnumWidgetSize.sm:
                    return 14.0;
                  case EnumWidgetSize.md:
                    return 16.0;
                  case EnumWidgetSize.lr:
                    return 18.0;
                  default:
                    return 16.0;
                }
              }(),
            ),
            onTap: () {
              if (widget.eNum == EnumTextField.datePicker) {
                FocusScope.of(context).unfocus();
                showDatePickerDialog(context);
              } else if (widget.eNum == EnumTextField.dropdown) {
                FocusScope.of(context).unfocus();
                widget.onTap!();
              }
            },
            textAlign: widget.textAlign ?? TextAlign.start,
            decoration: InputDecoration(
                contentPadding: widget.labelText != null
                    ? const EdgeInsets.all(0.0)
                    : () {
                        switch (widget.size) {
                          case EnumWidgetSize.sm:
                            return const EdgeInsets.all(10.0);
                          case EnumWidgetSize.md:
                            return const EdgeInsets.all(12.0);
                          case EnumWidgetSize.lr:
                            return const EdgeInsets.only(
                                left: 12, top: 20, bottom: 20, right: 12);
                          default:
                            return const EdgeInsets.all(12.0);
                        }
                      }(),
                filled: widget.modelTextField?.isEnable == false
                    ? true
                    : widget.fillColor != null
                        ? true
                        : false,
                fillColor: widget.modelTextField?.isEnable == false
                    ? const Color(0xffF5F5F5)
                    : widget.fillColor ?? Colors.white,
                label: widget.labelText != null
                    ? Text(
                        widget.labelText!,
                        style: GoogleFonts.montserrat(),
                      )
                    : null,
                labelStyle: textStyle(),
                floatingLabelStyle: textStyle(),
                floatingLabelAlignment: FloatingLabelAlignment.start,
                prefixIcon: prifix(),
                suffixIcon: widget.suffixIcon,
                suffixText: widget.suffixText,
                suffixStyle: widget.suffixTextStyle,
                helperText: widget.heleperText,
                helperStyle: TextStyle(
                    fontSize: () {
                      switch (widget.size) {
                        case EnumWidgetSize.sm:
                          return 12.0;
                        case EnumWidgetSize.md:
                          return 14.0;
                        case EnumWidgetSize.lr:
                          return 16.0;
                        default:
                          return 14.0;
                      }
                    }(),
                    color: widget.borderColor != null
                        ? widget.borderColor!
                        : const Color(0xff656565)),
                errorText: widget.errorText,
                errorStyle: widget.errorStyle,
                hintText: widget.hintText,
                hintStyle:
                    textStyle(textColor: HelperColor.instance.colorGrey_7),
                counter: () {
                  if (widget.eNum == EnumTextField.verified) {
                    return const Text("verified");
                  } else if (widget.eNum == EnumTextField.unverified) {
                    return const Text("unverified");
                  } else {
                    return null;
                  }
                }(),
                // enabledBorder: UnderlineInputBorder(
                //   borderSide: BorderSide(color: Colors.cyan),
                // ),
                // focusedBorder: UnderlineInputBorder(
                //   borderSide: BorderSide(color: Colors.cyan),
                // ),
                disabledBorder: inputBorder(widget.borderColor != null
                    ? widget.borderColor!
                    : Colors.grey),
                enabledBorder: inputBorder(widget.borderColor != null
                    ? widget.borderColor!
                    : HelperColor.instance.colorBorderColor),
                focusedBorder: inputBorder(Theme.of(context).primaryColor),
                errorBorder: widget.labelText != null
                    ? const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      )
                    : inputBorder(Colors.red),
                focusedErrorBorder: inputBorder(Colors.red)),
            inputFormatters: textInputformatter(),
          ),
        ),
        if (widget.onDelete != null)
          InkWell(
            onTap: widget.onDelete == null ? null : () => widget.onDelete!(),
            child: Container(
              child: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
              margin: const EdgeInsets.only(
                  left: 12, right: 12, top: 10, bottom: 10),
            ),
          ),
      ],
    );
  }

  InputBorder inputBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(widget.borderRadius!),
      borderSide: BorderSide(
        width: 1,
        color: color,
      ),
    );
  }

  TextInputType keyBoardType() {
    if (widget.enumTextInputType == EnumTextInputType.digitsWithDecimal) {
      return const TextInputType.numberWithOptions(
          signed: false, decimal: true);
    } else if (widget.enumTextInputType == EnumTextInputType.mobile ||
        widget.enumTextInputType == EnumTextInputType.onlyDigits) {
      return const TextInputType.numberWithOptions(
          decimal: false, signed: false);
    } else if (widget.enumTextInputType == EnumTextInputType.email) {
      return TextInputType.emailAddress;
    }
    return TextInputType.text;
  }

  List<TextInputFormatter> textInputformatter() {
    List<TextInputFormatter> listFormatters = [];
    if (widget.enumTextInputType == EnumTextInputType.mobile) {
      listFormatters.add(FilteringTextInputFormatter.digitsOnly);
      listFormatters.add(LengthLimitingTextInputFormatter(10));
    } else if (widget.enumTextInputType == EnumTextInputType.onlyDigits) {
      listFormatters.add(FilteringTextInputFormatter.digitsOnly);
    } else if (widget.enumTextInputType ==
        EnumTextInputType.capitalLettersWithDigitsNoSpecialChars) {
      listFormatters.add(UpperCaseTextFormatter());
      listFormatters
          .add(FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9]")));
    } else if (widget.enumTextInputType ==
        EnumTextInputType.capitalLettersWithDigitsWithSpecialChars) {
      listFormatters.add(UpperCaseTextFormatter());
    } else if (widget.enumTextInputType == EnumTextInputType.onlyLetters) {
      listFormatters.add(FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")));
    } else if (widget.enumTextInputType == EnumTextInputType.panCardNumber) {
      listFormatters.add(UpperCaseTextFormatter());
      listFormatters
          .add(FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9]")));
      listFormatters.add(LengthLimitingTextInputFormatter(10));
    } else if (widget.enumTextInputType ==
        EnumTextInputType.digitsWithDecimal) {
      listFormatters.add(
        FilteringTextInputFormatter.allow(RegExp(r"^(\d+)?([.]?\d{0,3})?$")),
      );
    }
    return listFormatters;
  }

  Widget? prifix() {
    return Container(
      margin: const EdgeInsets.only(top: 1, left: 1, bottom: 1, right: 0),
      child: Container(
        margin: const EdgeInsets.only(right: 7, left: 7),
        child: widget.eNum == EnumTextField.datePicker
            ? WidgetAssetImage(
                imagePath: "date",
                width: 20.sp,
              )
            : widget.frontIconDynamic,
      ),
    );
  }

  Widget? sufix() {
    if (widget.eNum == EnumTextField.verified ||
        (widget.clear != null || widget.onSearch != null) &&
            widget.controller.text.isNotEmpty ||
        (widget.modelTextField?.isEnable == false) ||
        widget.backIconDynamic != null ||
        widget.isLoading != null ||
        widget.eNum == EnumTextField.dropdown) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.eNum == EnumTextField.verified)
            const Icon(
              Icons.done_rounded,
              color: Colors.green,
            ),
          if (widget.eNum == EnumTextField.dropdown)
            const Icon(
              Icons.arrow_drop_down,
              color: Colors.grey,
            ),
          if (isError)
            const Icon(
              Icons.warning,
              color: Colors.red,
            ),
          if ((widget.clear != null || widget.onSearch != null) &&
              widget.controller.text.isNotEmpty)
            IconButton(
              onPressed: () {
                widget.clear != null ? widget.clear!() : print('no action');
              },
              icon: const Icon(
                Icons.close,
                color: Colors.grey,
              ),
            ),
          if (widget.modelTextField?.isEnable == false)
            const Icon(
              Icons.not_interested,
              color: Colors.grey,
            ),
          if (widget.backIconDynamic != null) widget.backIconDynamic!,
          if (widget.isLoading != null)
            Visibility(
              visible: widget.isLoading!,
              child: const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                  )),
            )
        ],
      );
    } else {
      return null;
    }
  }

  validation(String value) {
    if (value.isEmpty && widget.modelTextField?.isCompulsory != true) {
      return null;
    } else if (value.isEmpty && widget.modelTextField?.isCompulsory == true) {
      return 'This field should not be empty';
    }
    return null;
  }

  setError() {
    setState(() {
      isError = true;
    });
  }

  showDatePickerDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      actionsPadding: EdgeInsets.zero,
      insetPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      content: WidgetCustomCalendar(
        isToDate: widget.isToDate,
        selectedDate: (value) {
          widget.selectedDate!(value);
          HelperNavigation.instance.navigatePop(context);
        },
      ),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
