import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'custom_text_field.dart';

class PhoneNoInput extends StatefulWidget {
  final String initialSelection;
  final ValueChanged<CountryCode> onChangedCountryCode;
  final ValueChanged<String> onChangedTextField;
  final FormFieldValidator<String> validator;
  final String hintText, title;
  final String labelText;
  final TextEditingController controller;
  final bool enabled;

  const PhoneNoInput({
    Key key,
    this.labelText,
    this.title,
    this.hintText,
    this.controller,
    this.enabled,
    this.initialSelection = "GH",
    this.validator,
    @required this.onChangedCountryCode,
    this.onChangedTextField,
  }) : super(key: key);

  @override
  _PhoneNoInputState createState() => _PhoneNoInputState();
}

class _PhoneNoInputState extends State<PhoneNoInput> {
  @override
  Widget build(BuildContext context) {
    final _countryCodePicker = CountryCodePicker(
      initialSelection: widget.initialSelection,
      favorite: const ['GB', 'GH'],
      showCountryOnly: true,
      showOnlyCountryWhenClosed: false,
      showFlag: false,
      alignLeft: true,
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      onChanged: (CountryCode countryCode) {
        setState(() {
          widget.onChangedCountryCode(countryCode);
        });
      },
    );

    final _inputField = CustomTextField(
      labelText: widget.labelText,
      hintText: widget.hintText,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      controller: widget.controller,
      onChanged: widget.onChangedTextField,
      prefixIcon: SizedBox(
        width: 110.0,
        child: _countryCodePicker,
      ),
      validator: widget.validator,
      enabled: widget.enabled,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitle(),
        _inputField,
      ],
    );
  }

  Widget _buildTitle() {
    return widget.title == null
        ? Container()
        : Text(
            widget.title,
            style: const TextStyle(color: Colors.black, fontSize: 16.0),
          );
  }
}
