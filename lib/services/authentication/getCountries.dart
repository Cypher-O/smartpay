import 'package:smartpay/utilities/imports/generalImport.dart';

Future getCountriesService() async {
  Map<String, String> requestHeaders = {
    "Accept": "application/json",
    "Content-Type": "application/json",
  };
  final response = await get(
    Uri.parse(countriesUrl),
    headers: requestHeaders,
  );

  if (response.statusCode == 200 || response.statusCode == 201) {
    final decodedResponse = json.decode(response.body);
    // Extract countries using the Country model
    List<Countries> countries = [];
    for (var element in decodedResponse) {
      if (element.containsKey('flags') &&
          element['flags'].containsKey('png') &&
          element.containsKey('cca2') &&
          element.containsKey('name') &&
          element['name'].containsKey('common')) {
        countries.add(Countries.fromJson(element));
      }
    }
    return countries;
  } else {
    return [];
  }
}
