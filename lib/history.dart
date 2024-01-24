import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:multitranslation/historymodel.dart';



class SearchHistoryScreen extends StatefulWidget {
  String token;
  SearchHistoryScreen({required this.token});
  @override
  _SearchHistoryScreenState createState() => _SearchHistoryScreenState();
}

class _SearchHistoryScreenState extends State<SearchHistoryScreen> {
  List<String> dates = [];
  Map<String, dynamic> searchData = {}; // Change the type to Map<String, dynamic>

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.post(
      Uri.parse('https://translation.saeedantechpvt.com/api/app/get-user-search-history'),
       headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${widget.token}'
        },
      // Add any required headers or body parameters here
    );
print(response.statusCode);
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final Map<String, dynamic> data = responseData['data']["data"];
      //final List<Map<String,dynamic>> datas = responseData["data"]["data"][0];
      //print(datas);
      print(data);

      setState(() {
        dates = data.keys.toList();
        searchData = Map.from(data);
      });
    } else {
      // Handle error
      print('Failed to fetch data. Error: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search History'),
      ),
      body: ListView.builder(
        itemCount: dates.length,
        itemBuilder: (context, index) {
          final date = dates[index];
          final List<dynamic> dateData = searchData[date] ?? [];

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  date,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: dateData.length,
                itemBuilder: (context, innerIndex) {
                  final searchItem = dateData[innerIndex];

                  return ListTile(
                    title: Text(searchItem['word']),
                    subtitle: Text(searchItem['trans_1']),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}



class MyHomePage extends StatefulWidget {
  String token;
 MyHomePage({required this.token});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".



  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        appBar: AppBar(
          // TRY THIS: Try changing the color here to a specific color (to
          // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
          // change color while the other colors stay the same.
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(""),
        ),
        body: Center(
            // Center is a layout widget. It takes a single child and positions it
            // in the middle of the parent.
            child: FutureBuilder(
          future: fetchHistoryData(widget.token),
          builder: (context, AsyncSnapshot<HistoryModel> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.data!.data!.length,
                itemBuilder: (context, index) {
                  // Get the date
                  String date =
                      snapshot.data!.data!.data!.keys.elementAt(index);

                  // Get the list of items for the current date
                  List<Datum> items = snapshot.data!.data!.data![date]!;

                  // Now, you can use the 'date' and 'items' in your UI
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        date,
                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17,color: Colors.black),
                      ), // Display the date

                      // Display the list of items for the current date
                      Column(
                        children: items.map((item) {
                          return Container(
                           
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Selected Language:"+items[index].selectedLang.toString(),style: TextStyle(color: Colors.black),),
                                Text("Word:"+items[index].word.toString(),style: TextStyle(color: Colors.black),),
                                Text("Translations: "+items[index].trans1.toString()+", "+items[index].trans2.toString(),style: TextStyle(color: Colors.black),),
                             
                                Divider(),
                                // Add other widgets to display other item details
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  );
                },
              );
            }
          },
        )));
  }

  // Future<void> textToSpeech() async {
  //   // final String apiKey = Platform.environment['SnAEBdbq564owoayOZpBX1YvRVZTlzaO5Qkbluo6'] ?? '';
  //   const String voice = 'mickey';
  //   const String text = 'Hello, ruhan sir how are you?';
  //   final String url =
  //       'https://api.narakeet.com/text-to-speech/mp3?voice=$voice';

  //   // if (apiKey.isEmpty) {
  //   //   print('Please set NARAKEET_API_KEY environment variable');
  //   //   return;
  //   // }

  //   final http.Client client = http.Client();

  //   try {
  //     final http.Response response = await client.post(
  //       Uri.parse(url),
  //       headers: {
  //         'Accept': 'application/octet-stream',
  //         'Content-Type': 'text/plain',
  //         'x-api-key': "SnAEBdbq564owoayOZpBX1YvRVZTlzaO5Qkbluo6",
  //       },
  //       body: utf8.encode(text),
  //     );

  //     if (response.statusCode == 200) {
  //       final Directory tempDir = await getTemporaryDirectory();
  //       final File file = File('${tempDir.path}/output.mp3');
  //       final IOSink sink = file.openWrite();
  //       sink.add(response.bodyBytes);
  //       await sink.close();

  //       // Play the audio
  //       await playAudio(file.path);

  //       print('File saved at: ${file.path}');
  //     } else {
  //       print('Failed to download file: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     print('Error: $e');
  //   } finally {
  //     client.close();
  //   }
  // }

  // Future<void> playAudio(String filePath) async {
  //   final AudioPlayer audioPlayer = AudioPlayer();
  //   await audioPlayer.play(
  //     UrlSource(filePath),
  //   );
  // }

  Future<HistoryModel> fetchHistoryData(String token) async {
    final response = await http.post(
      Uri.parse(
          'https://translation.saeedantechpvt.com/api/app/get-user-search-history'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization':
              "Bearer " + token, 
      },
  //  headers: {
  //         'Authorization':
  //             "Bearer " + token, // Replace with your actual auth token
  //       },      
      // Add any required headers or body parameters here
    );

    if (response.statusCode == 200) {
      return HistoryModel.fromJson(jsonDecode(response.body));
    }
    return HistoryModel.fromJson(response.body as Map<String, dynamic>);
  }
}