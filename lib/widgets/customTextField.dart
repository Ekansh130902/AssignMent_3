import 'package:flutter/material.dart';
import 'package:test3/consts/styles/style.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final String hintText;
  final bool isPassword;
  final IconData prefixIcon;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String?>? onSaved;

  const CustomTextField({
    required this.label,
    required this.hintText,
    this.isPassword = false,
    required this.prefixIcon,
    this.validator,
    this.onChanged,
    this.onSaved,
    Key? key,
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;
  bool _isFieldEmpty = true;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextFormField(
            obscureText: widget.isPassword ? _obscureText : false,
            decoration: InputDecoration(
              fillColor: fillColor,
              filled: true,
              hintText: widget.hintText,
              hintStyle: const TextStyle(color: Color(0xFFDBDBDB)),
              border: const OutlineInputBorder(),
              errorMaxLines: 3,
              enabledBorder: UnderlineInputBorder(
                borderSide: const BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: InputBorder.none,
              prefixIcon: Padding(
                padding: EdgeInsets.only(bottom: 5),
                child: Icon(
                  size: 27,
                  widget.prefixIcon,
                  color: _isFieldEmpty ? Color(0xFFDBDBDB) : Colors.blue,
                ),
              ),
              suffixIcon: widget.isPassword
                  ? GestureDetector(
                onTap: _togglePasswordVisibility,
                child: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                  color: Color(0xFFDBDBDB),
                ),
              )
                  : null,
            ),
            validator: widget.validator,
            onChanged: (value) {
              setState(() {
                _isFieldEmpty = value.isEmpty;
              });
              if (widget.onChanged != null) {
                widget.onChanged!(value);
              }
            },
            onSaved: widget.onSaved,
          ),
        ),
      ],
    );
  }
}
