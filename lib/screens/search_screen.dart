import 'package:flutter/material.dart';
import 'package:weatherapp_madtwo/widgets/city_block.dart';
import '../widgets/search.dart';
import '../utils/colors.dart';
import '../utils/providers.dart';
import '../models/location.dart';


class SearchTab extends StatefulWidget {
  const SearchTab({Key? key}) : super(key: key);

  @override
  _SearchTabState createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  String _searchKeyword = "";

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: secondaryColor,
        title:  const Text("Search"),
      ),
      body: Stack(
        children: [
          if (_searchKeyword.isEmpty)
            const Center(
              child: Text(
                "Search Results",
              ),
            )
          else
            FutureBuilder(
              future: Providers.getLocation(_searchKeyword),
              builder: (context, AsyncSnapshot<Location?> snapshot) {
                if (snapshot.hasError) {
                  return Scaffold(
                    body: Center(
                      child: Text("Error: ${snapshot.error}"),
                    ),
                  );
                }
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.data != null){
                    return ListView(
                        padding: const EdgeInsets.only(
                          top: 128.0,
                          bottom: 12.0,
                        ),
                        children: [
                          CityBlock(location: snapshot.data!),
                        ]
                    );
                  } else {
                    return const Center(
                      child: Text("Error: Can not find the city."),
                    );
                  }
                }
                // Loading
                return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            ),
          Padding(
            padding: const EdgeInsets.only(
              top: 25.0,
            ),
            child: CustomInput(
              hintText: "Search here...",
              onSubmitted: (value) {
                setState(() {
                  _searchKeyword = value.toLowerCase();
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
