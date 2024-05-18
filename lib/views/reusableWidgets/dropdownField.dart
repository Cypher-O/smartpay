import '../../../utilities/imports/generalImport.dart';

class CountryPicker extends StatefulWidget {
  final Function(Countries) onSelect;
  final List<Countries> countries;
  bool errorTextActive;

  CountryPicker({
    Key? key,
    required this.onSelect,
    required this.countries,
    this.errorTextActive = false,
  }) : super(key: key);

  @override
  _CountryPickerState createState() => _CountryPickerState();
}

class _CountryPickerState extends State<CountryPicker> {
  // Countries? selectedCountry;
  TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Sort the countries alphabetically
    widget.countries.sort((a, b) => a.countryName.compareTo(b.countryName));
    // Move the selected country to the top
    if (selectedCountry != null && widget.countries.contains(selectedCountry)) {
      widget.countries.remove(selectedCountry);
      widget.countries.insert(0, selectedCountry!);
    }
    return Container(
      height: sS(context).cH(height: 48),
      width: sS(context).cW(width: 358),
      decoration: BoxDecoration(
        // color: AppColors.gray6(),
        color: AppColors.gray6(),
        borderRadius: BorderRadius.circular(sS(context).cW(width: 16)),
      ),
      alignment: Alignment.center,
      child: DropdownSearch<Countries>(
        popupProps: PopupProps.bottomSheet(
          itemBuilder:
              (BuildContext context, Countries? country, bool isSelected) {
            if (country != null) {
              bool isCountrySelected =
                  selectedCountry != null && selectedCountry == country;
              return Container(
                // color: isCountrySelected ? AppColors.gray1() : null,
                child: Padding(
                  padding: const EdgeInsets.only(left: 12.0, right: 4.0),
                  child: ListTile(
                    tileColor: isCountrySelected ? AppColors.gray6() : null,
                    leading: Image.network(
                      country.flagUrl ?? '',
                      width: 32,
                      height: 32,
                      errorBuilder: (context, error, stackTrace) =>
                          Icon(Icons.flag),
                    ),
                    title: RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: [
                          TextSpan(
                            text: '${country.countryCode}',
                            style: TextStyle(fontWeight: FontWeight.normal),
                          ),
                          TextSpan(
                            text: '    ${country.countryName}',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    trailing: isCountrySelected
                        ? Icon(Icons.check, color: blueLight)
                        : null,
                    selected: isSelected,
                  ),
                ),
              );
            } else {
              return SizedBox.shrink();
            }
          },
          bottomSheetProps: BottomSheetProps(
            enableDrag: true,
            elevation: 16,
            backgroundColor: AppColors.white(),
          ),
          showSearchBox: true,
          searchFieldProps: TextFieldProps(
            controller: _searchController,
            padding: const EdgeInsets.all(20),
            cursorColor: AppColors.gray4(),
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.text,
            maxLines: 1,
            style: GoogleFonts.inter(
                textStyle: TextStyle(
                    color: AppColors.black(),
                    fontSize: 15,
                    fontWeight: FontWeight.w500)),
            decoration: InputDecoration(
                fillColor: AppColors.gray6(),
                filled: true,
                hintStyle: GoogleFonts.inter(
                    textStyle: TextStyle(
                        fontSize: sS(context).cH(height: 14),
                        color: AppColors.gray3(),
                        fontWeight: FontWeight.normal)),
                hintText: 'Search for a country',
                prefixIcon: Icon(Icons.search, color: AppColors.gray3()),
                suffixIcon: IconButton(
                  icon: GeneralTextDisplay(
                    'Cancel',
                    AppColors.gray3(),
                    1,
                    18,
                    FontWeight.bold,
                    "",
                  ),
                  onPressed: () {
                    _searchController.clear();
                    Navigator.pop(context);
                  },
                ),
                prefixIconConstraints:
                    const BoxConstraints(minWidth: 0, minHeight: 0),
                contentPadding: EdgeInsets.fromLTRB(sS(context).cW(width: 16),
                    sS(context).cH(height: 12), 0, 0),
                disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius:
                        BorderRadius.circular(sS(context).cW(width: 8))),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius:
                        BorderRadius.circular(sS(context).cW(width: 8))),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius:
                        BorderRadius.circular(sS(context).cW(width: 8)))),
          ),
        ),
        items: widget.countries,
        dropdownBuilder: (context, Countries? country) {
          if (country != null) {
            selectedCountryString = country.countryCode;
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  Image.network(
                    country.flagUrl ?? '',
                    width: 32,
                    height: 32,
                    errorBuilder: (context, error, stackTrace) =>
                        Icon(Icons.flag),
                  ),
                  SizedBox(width: 8),
                  Text(
                    '${country.countryName}',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            );
          } else {
            // return SizedBox.shrink();
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: GeneralTextDisplay(
                'Select Country',
                AppColors.gray3(),
                1,
                14,
                FontWeight.normal,
                "",
              ),
            );
          }
        },
        itemAsString: (Countries country) =>
            '(${country.countryCode}) ${country.countryName}',
        dropdownDecoratorProps: DropDownDecoratorProps(
          baseStyle: selectedCountry == null
              ? GoogleFonts.inter(
                  textStyle: TextStyle(
                      fontSize: sS(context).cH(height: 14),
                      color: AppColors.gray3(),
                      fontWeight: FontWeight.normal))
              : GoogleFonts.inter(
                  textStyle: TextStyle(
                      color: AppColors.black(),
                      fontSize: 15,
                      fontWeight: FontWeight.w500)),
          dropdownSearchDecoration: InputDecoration(
            labelStyle: GoogleFonts.inter(
                textStyle: TextStyle(
                    color: AppColors.black(),
                    fontSize: 15,
                    fontWeight: FontWeight.w500)),
            contentPadding: EdgeInsets.fromLTRB(
                sS(context).cW(width: 8), sS(context).cH(height: 0), 0, 0),
            disabledBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(sS(context).cW(width: 8))),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(sS(context).cW(width: 8))),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(sS(context).cW(width: 8)),
            ),
          ),
        ),
        onChanged: (value) {
          widget.onSelect(value!);
          setState(() {
            selectedCountry = value;
            _searchController.clear();
            widget.errorTextActive = false;
            // Move the selected country to the top
            widget.countries.remove(value);
            widget.countries.insert(0, value);
          });
        },
        selectedItem: selectedCountry,
      ),
    );
  }
}
