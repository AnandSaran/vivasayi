import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_picker_dropdown.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:flutter/material.dart';
import 'package:vivasayi/constants/constant.dart';

class PhoneNumber extends StatelessWidget {
  //final GestureTapCallback onTap;
  final String label;
  final EdgeInsets edgeInsets;
  final Stream<String> stream;
  final Function function;
  final TextInputAction textInputAction;
  final FocusNode fnCurrentFocus;
  final FocusNode? fnNextFocus;
  String countryCode = COUNTRY_CODE_INDIA;
  String textValue = EMPTY_STRING;

  PhoneNumber({
    Key? key,
    required this.label,
    required this.edgeInsets,
    required this.stream,
    required this.function,
    required this.textInputAction,
    required this.fnCurrentFocus,
    required this.fnNextFocus,
    //  required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: edgeInsets,
        child: _buildCountryPickerDropdown(context,
            hasPriorityList: true, sortedByIsoCode: true));
  }

  _buildCountryPickerDropdown(BuildContext context,
      {bool sortedByIsoCode = false,
      bool hasPriorityList = false,
      bool hasSelectedItemBuilder = false}) {
    double dropdownButtonWidth = MediaQuery.of(context).size.width * 0.40;
    //respect dropdown button icon size
    double dropdownItemWidth = dropdownButtonWidth - 30;
    double dropdownSelectedItemWidth = dropdownButtonWidth - 30;
    return Row(
      children: <Widget>[
        SizedBox(
          width: dropdownButtonWidth,
          child: CountryPickerDropdown(
            onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
            itemHeight: null,
            isDense: false,
            selectedItemBuilder: hasSelectedItemBuilder == true
                ? (Country country) => _buildDropdownSelectedItemBuilder(
                    country, dropdownSelectedItemWidth)
                : null,
            itemBuilder: (Country country) => hasSelectedItemBuilder == true
                ? _buildDropdownItemWithLongText(country, dropdownItemWidth)
                : _buildDropdownItem(country, dropdownItemWidth),
            initialValue: 'IN',
            priorityList: hasPriorityList
                ? [
                    CountryPickerUtils.getCountryByIsoCode('IN'),
                  ]
                : null,
            sortComparator: sortedByIsoCode
                ? (Country a, Country b) => a.isoCode.compareTo(b.isoCode)
                : null,
            onValuePicked: (Country country) {
              countryCode = SYMBOL_PLUS + country.phoneCode;
              function(countryCode + textValue);
            },
          ),
        ),
        SizedBox(
          width: 5.0,
        ),
        Expanded(
          child: _editText(),
        )
      ],
    );
  }

  _editText() {
    return StreamBuilder(
        stream: stream,
        builder: (context, AsyncSnapshot<String> snapshot) {
          return TextFormField(
            onChanged: (text) {
              textValue = text;
              function(countryCode + textValue);
            },
            focusNode: fnCurrentFocus,
            onFieldSubmitted: (term) {
              FocusScope.of(context).requestFocus(fnNextFocus);
            },
            textInputAction: textInputAction,
            decoration: InputDecoration(
                errorText: snapshot.error?.toString(),
                labelText: label,
                labelStyle: TextStyle(fontSize: 14.0),
                isDense: true,
                //contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                border: OutlineInputBorder()),
            keyboardType: TextInputType.number,
          );
        });
  }

  Widget _buildDropdownItem(Country country, double dropdownItemWidth) =>
      SizedBox(
        width: dropdownItemWidth,
        child: Row(
          children: <Widget>[
            CountryPickerUtils.getDefaultFlagImage(country),
            SizedBox(
              width: 8.0,
            ),
            Expanded(
                child: Text(
              "+${country.phoneCode}(${country.isoCode})",
              style: new TextStyle(
                fontSize: 14.0,
              ),
            )),
          ],
        ),
      );

  Widget _buildDropdownItemWithLongText(
          Country country, double dropdownItemWidth) =>
      SizedBox(
        width: dropdownItemWidth,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              CountryPickerUtils.getDefaultFlagImage(country),
              SizedBox(
                width: 8.0,
              ),
              Expanded(
                  child: Text(
                "${country.name}",
                style: new TextStyle(
                  fontSize: 15.0,
                ),
              )),
            ],
          ),
        ),
      );

  Widget _buildDropdownSelectedItemBuilder(
          Country country, double dropdownItemWidth) =>
      SizedBox(
          width: dropdownItemWidth,
          child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: <Widget>[
                  CountryPickerUtils.getDefaultFlagImage(country),
                  SizedBox(
                    width: 8.0,
                  ),
                  Expanded(
                      child: Text(
                    '${country.name}',
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  )),
                ],
              )));
}
