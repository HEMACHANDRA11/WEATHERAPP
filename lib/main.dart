import 'package:flutter/material.dart';
import 'package:myweatherapp/CurrentWeather.dart1.dart';
import 'package:myweatherapp/additionalinformation.dart';
import 'package:myweatherapp/weatherapiclient.dart';
import 'package:myweatherapp/weathermodel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  WeatherApiClient client = WeatherApiClient();
  Weather? data;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    client.getCurrentWeather("Hyderabad");
  }
  Future<void> getData() async{
    data = await client.getCurrentWeather("BANGALORE");

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      appBar: AppBar(
        elevation: 0.0,
        title: Text("WEATHER APP",style: TextStyle(color: Colors.black),),
        centerTitle: true,
        leading: IconButton(onPressed: (){},icon: Icon(Icons.menu),color: Colors.black,
        ),
      ),
      body: FutureBuilder(
        future: getData(),
        builder: (context,snapshot){
    if (snapshot.connectionState == ConnectionState.done) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          currentWeather(
              Icons.wb_sunny_rounded, "${data!.temp}", "${data!.cityName}"),
          SizedBox(
            height: 60.0,
          ),
          Text("Additional information",
            style: TextStyle(fontSize: 24.0,
                color: Colors.yellow, fontWeight: FontWeight.bold),),
          Divider(),
          SizedBox(
            height: 20.0,
          ),
          additionalInformation(
              "${data!.wind}", "${data!.humidity}", "${data!.pressure}",
              "${data!.feels_like}")
    ],
      );

    }else if(snapshot.connectionState == ConnectionState.waiting){
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Container();
        }
      ),
    );
  }
}

