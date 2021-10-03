import 'package:flutter/material.dart';
import 'package:search_delegate_example/src/country.dart';
import 'package:search_delegate_example/src/search_country_delegate.dart';

class SearchDelegateExample extends StatelessWidget {
  const SearchDelegateExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Country> countries = [
      const Country('United States of America'),
      const Country('Ecuador'),
      const Country('México'),
      const Country('Venezuela'),
      const Country('Francia'),
      const Country('Colombia'),
      const Country('Panamá'),
      const Country('Alemania'),
      const Country('España'),
      const Country('Cuba'),
    ];
    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          onTap: () {
            showSearch(
              context: context,
              delegate: SearchCountryDelegate(countries),
            );
          },
          title: const Text('Search'),
        ),
      ),
      body: ListView.builder(
        itemCount: countries.length,
        itemBuilder: (_, index) {
          return ListTile(
            title: Text(countries[index].name),
          );
        },
      ),
    );
  }
}
