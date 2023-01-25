import 'package:docshero/components/constants.dart';
import 'package:flutter/material.dart';


class RoundedInputField extends StatefulWidget {
  final String hintText;
  final String prefixIcon;
  final String sufficIcon;
  final TextInputType keyboardType;
  final Color fillColor;
  final Color textColor;
  final ValueChanged<String> onChanged;
  final ValueChanged<String?> onSaved;
  final FormFieldValidator<String>? validator;
  double borderRadiusValue;
  String? initialValue;
  String? suffixText;
  Color hintTextColor;
  double textSize;
  double hintTextSize;
  bool obscure;


  
   RoundedInputField({
    Key ? key,
    required this.hintText,
    required this.onChanged,
    required this.onSaved,
    required this.validator,
    required this.prefixIcon,
     required this.sufficIcon,
     this.obscure=false,
     this.initialValue,
    this.keyboardType=TextInputType.text,
    this.fillColor = kWhiteColor,
    this.textColor = Colors.white,
    this.borderRadiusValue =5,
     this.suffixText="Rs",
     this.hintTextColor=Colors.white54,
     this.textSize=14,
     this.hintTextSize=14,
  }) : super(key: key);

  @override
  State<RoundedInputField> createState() => _RoundedInputFieldState();
}

class _RoundedInputFieldState extends State<RoundedInputField> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return  TextFormField(
      obscureText: widget.obscure,
      textAlign: TextAlign.start,
        style: TextStyle(fontSize:widget.textSize, color: widget.textColor),
        validator: widget.validator,
        initialValue: widget.initialValue,
        onChanged: widget.onChanged,
        onSaved: widget.onSaved,
        keyboardType: widget.keyboardType,
        decoration: InputDecoration(
          prefixIcon: widget.prefixIcon == null || widget.prefixIcon == '' ? null :
          Padding(
            padding: EdgeInsets.all(size.height * 0.012),
            child: Image.asset(
              widget.prefixIcon,
              width: size.width * 0.02,
              height: size.height * 0.02,
            ),
          ),
          suffixIcon: widget.sufficIcon == null || widget.sufficIcon == '' ? null :
          InkWell(
              onTap: (){
                setState(() {
                  widget.obscure = !widget.obscure;
                });

              },
              child: Icon(Icons.remove_red_eye_outlined)),
          // focusedBorder: InputBorder.none,
          isDense: true,
          contentPadding:
          EdgeInsets.all(12),
          //EdgeInsets.symmetric(vertical: 12, horizontal: 10.0),
          focusColor: Colors.white,
          fillColor: widget.fillColor == null? Colors.white : widget.fillColor,
          filled: true,
          hintText: widget.hintText,
          hintStyle: TextStyle(
              color: widget.hintTextColor,
            fontSize: widget.hintTextSize

          ),


          //suffixText: suffixText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(widget.borderRadiusValue)),
            borderSide: BorderSide(color: Colors.white24)
            ),
        ),
    );
  }
}