
import 'package:flutter/material.dart';

import '../services/weather.dart';
import 'location_screen.dart';

class ListViewSearchExample extends StatefulWidget {
  const ListViewSearchExample({Key? key}) : super(key: key);

  @override
  State<ListViewSearchExample> createState() => _ListViewSearchExampleState();
}

class _ListViewSearchExampleState extends State<ListViewSearchExample> {
  final List<String> myCoolStrings = [
    'Gaza',
    'Rafah',
    'Jerusalem',
    'Ramallah',
    'Nablus',
    'Jenin',
    'Tubas',
    'Hebron',
    'Jericho',
    'Bethlehem',
    'Tulkarm',
    'Khan Yunis',
  ];
  int allTyping =0;

  final List<String> _results = [];

  @override
  void initState() {
   // getWeatherDataSelected();
    super.initState();
  }

  void getWeatherDataSelected(String c) async {
    WeatherModel weatherInfo = WeatherModel();
    await weatherInfo.getCurrentLocationWeatherSelected(c);
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(
        weatherData: weatherInfo,
      );
    }));
  }

  void _handleSearch(String input) {
    _results.clear();
    allTyping =0;
    for (var str in myCoolStrings) {
        setState(() {
          allTyping++;
        });
      if (str.toLowerCase().contains(input.toLowerCase())) {
        setState(() {
          _results.add(str);
          //allTyping++;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Search For City")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              height: 45,
              width: 360,
              child: TextField(
                onChanged: _handleSearch,
                style: const TextStyle(
                  color: Color(0xff020202),
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.5,
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[300],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  hintText: "Type a City Name.. ",
                  hintStyle:  TextStyle(
                      color: Colors.grey[500],
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.5,
                      decorationThickness: 6),
                  prefixIcon: const Icon(Icons.search),
                  prefixIconColor: Colors.black,
                ),
              ),
            ),
          ),
          Expanded(
            child:  _results.isEmpty && allTyping>0
                ? const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 100,vertical: 50),
                  child: Text("The City Does Not Exist",style: TextStyle(color: Colors.red,fontSize: 20),),
                )
                : _results.isEmpty && allTyping==0
              ?
            ListView.builder(             //  all list without any typing
                itemCount: myCoolStrings.length,
                itemBuilder: (context, index) {
                  // myCoolStrings.sort();
                  final data = myCoolStrings[index];
                  return  ListTile(
                      onTap: () {
                        print(data);
                        getWeatherDataSelected(data);
                    },
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Text(data),
                          ),
                          const Divider(
                            height: 20,
                            thickness: 1,
                            color: Colors.black,
                          ),
                        ],
                      ));
                })
            :
              ListView.builder(
                itemCount: _results.length,
                itemBuilder: (context, index) {
                  final data = _results[index];
                  return ListTile(
                      title: ElevatedButton(
                          child: Text(data),
                       onPressed: () {
                        print(data);
                        getWeatherDataSelected(data);
                              },
                      ));
                }),
          ),
        ],
      ),
    );
  }
}
