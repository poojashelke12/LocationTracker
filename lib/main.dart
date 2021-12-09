import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/Views/FirstPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);



  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
 final Completer<GoogleMapController> _controller = Completer();
 TextEditingController searchController = TextEditingController(text: "");
   bool showSearch = false;
  final Set<Marker> listMarkers = {};
  late Marker destMark;
  String search="";
  


  double zoom = 18;
  
  CameraPosition currentLocation =  const CameraPosition(target: LatLng(19.177090, 72.843239), zoom: 18);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: showSearch == false?
        Container(
           padding: const EdgeInsets.only(
                          left: 18, right: 18, top: 8, bottom: 8),
                      width: MediaQuery.of(context).size.width * 1,
                     height: MediaQuery.of(context).size.height * 0.07,
          child: TypeAheadField(
  textFieldConfiguration: const TextFieldConfiguration(
    autofocus: true,
    style:    TextStyle(fontSize: 18.0, color: Color.fromARGB(255, 8, 8, 8)),
    decoration: InputDecoration(
      prefixIcon:  Icon(Icons.search),
     filled: true,
                          fillColor: Colors.white,
                          hintText: 'Search Here',
                          contentPadding:  EdgeInsets.only(
                              left: 14.0, bottom: 8.0, top: 1.0),
                              hintStyle:  TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily: 'Bahnschrift',
                                                    color: Color(0xffB4B4B4)),
                                                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.zero)
    )
  ),
  suggestionsCallback: (pattern) async {
    return listMarkers.where((e) {return e.infoWindow.title!.toLowerCase().contains(search.toLowerCase());});
  },
  itemBuilder: (context, suggestion) {
    dynamic temp=suggestion;
    return ListTile(
     
      title: Text(temp.infoWindow.title.toString()),
      subtitle: Text(temp.infoWindow.snippet.toString()),
    );
  },
  onSuggestionSelected: (Marker suggestion) {
setState(() {
    currentLocation =   CameraPosition(target: suggestion.position, zoom: 18);

});    
    
  },
),
        ):Container()

      ),
      body: GoogleMap(
        compassEnabled: true,
        zoomControlsEnabled: false,
        mapType: MapType.normal,
        initialCameraPosition: currentLocation,
        onMapCreated: (GoogleMapController controller) {
           _controller.complete(controller);
         
        },
        onTap: (click){
          print(click);
           destMark = Marker(
              markerId: const MarkerId('current'),
              icon: BitmapDescriptor.defaultMarkerWithHue(195),
              infoWindow: const InfoWindow(title: "Last", snippet: "destination"),
              position: click,
            );
            print(listMarkers);
            setState(() {
              if(listMarkers.contains(destMark)){
                   listMarkers.remove(destMark);
              }

                 listMarkers.add(destMark);
            });
        },
        onCameraMove: (position) {
          setState(() {
            zoom = position.zoom;
          });
        },
        markers: Set<Marker>.of(listMarkers),
      
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(
              context, MaterialPageRoute(builder: (context) =>  FirstPage(current: listMarkers, deskMark: destMark,))).then((value) {
                print(listMarkers);
                setState(() {
                   listMarkers.remove(destMark);
                });
               
              });
        },
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
