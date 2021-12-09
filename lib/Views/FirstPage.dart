import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/config.dart';


class FirstPage extends StatefulWidget {
  final dynamic current;
  final dynamic  deskMark;
  const FirstPage({Key? key, required this.current,this.deskMark}) : super(key: key) ;

  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  TextEditingController titleCOntroller = TextEditingController();
  TextEditingController labelCOntroller = TextEditingController();
  bool validate = false;
  Color pickerColor = const Color(0xff443a49);
  late Color currentColor =Colors.red;

  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  @override
  void initState() {
    // setState(() {
    // currentColor= widget.current;
    // });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            IconButton(icon: const Icon(Icons.arrow_back_ios), onPressed: () {
                Navigator.pop(context);
            }),
            Container(
              color: Colors.white,
              width: 1.3,
              child: const Text(""),
            ),
            const Padding(padding: EdgeInsets.only(right: 15)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Labeled',
                  // style: ,
                ),
              ],
            ),
          ],
        ),
       
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                Container(
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.11,
                    right: MediaQuery.of(context).size.width * 0.11,
                  ),
                  child: Form(
                    child: Column(
                      children: [
                        Padding(
                            padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.12,
                        )),
                       
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Padding(padding: EdgeInsets.only()),
                            Expanded(
                                child: Container(
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.zero,
                                color: Color(0xffB4B4B4),
                              ),
                              child: Column(
                                children: [
                                  // ignore: avoid_unnecessary_containers
                                  Container(
                                    child: TextFormField(
                                        controller: titleCOntroller,
                                        style: const TextStyle(
                                            fontSize: 19,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: 'Bahnschrift',
                                            color: Color.fromARGB(255, 15, 11, 11)),
                                        keyboardType: TextInputType.text,
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.only(
                                              left: 22,
                                              bottom: 10,
                                              top: 10,
                                              right: 15),
                                          hintText: 'Enter Title',
                                          hintStyle: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: 'Bahnschrift',
                                              color: Color.fromARGB(255, 15, 11, 11)),
                                        )),
                                  ),
                                ],
                              ),
                            )),
                          ],
                        ),
                         titleCOntroller.text.isEmpty && validate
                                  ? Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: const Text(
                                          "Title cannot be blank.",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.red,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    )
                                  : Container(),
                              // Padding(
                              //     padding: EdgeInsets.only(
                              //   top: MediaQuery.of(context).size.height * 0.02,
                              // )),
                        Padding(
                            padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.03,
                        )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Padding(padding: EdgeInsets.only()),
                            Expanded(
                                child: Container(
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.zero,
                                color: Color(0xffB4B4B4),
                              ),
                              child: Column(
                                children: [
                                  // ignore: avoid_unnecessary_containers
                                  Container(
                                    child: TextFormField(
                                        controller: labelCOntroller,
                                        style: const TextStyle(
                                            fontSize: 19,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: 'Bahnschrift',
                                            color: Color.fromARGB(255, 15, 11, 11)),
                                        keyboardType: TextInputType.text,
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.only(
                                              left: 22,
                                              bottom: 10,
                                              top: 10,
                                              right: 15),
                                          hintText: 'Enter Label',
                                          hintStyle: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: 'Bahnschrift',
                                              color: Color.fromARGB(255, 15, 11, 11)),
                                        )),
                                  ),
                                ],
                              ),
                            )),
                          ],
                        ),
                         labelCOntroller.text.isEmpty && validate
                                  ? Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: const Text(
                                          "Label cannot be blank.",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.red,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    )
                                  : Container(),
                              // Padding(
                              //     padding: EdgeInsets.only(
                              //   top: MediaQuery.of(context).size.height * 0.02,
                              // )),
                         Padding(
                            padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.03,
                        )),

                        
                        Row(
                          children: [
                            Expanded(
                              child: TextButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text('Pick a color!'),
                                          content: SingleChildScrollView(
                                            child: ColorPicker(
                                              pickerColor: pickerColor,
                                              onColorChanged: changeColor,
                                            ),
                                          ),
                                          actions: <Widget>[
                                            ElevatedButton(
                                              child: const Text('Got it'),
                                              onPressed: () {
                                                setState(() =>
                                                    currentColor = pickerColor);
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        );
                                      });
                                },
                                
                                
                                child: Center(
                                  
                                  
                                  child: Container(
                                    
                                    height: 25,
                                    width: 150,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.zero,
                                      color: currentColor,
                                    ),
                                    // ignore: avoid_unnecessary_containers
                                    child: Container(
                                      child: const Align(
                                        child: Text(
                                          "Select Color",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Color(0xffFFFFFF)),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        //  validate
                        //           ? Align(
                        //               alignment: Alignment.centerLeft,
                        //               child: Container(
                        //                 padding: const EdgeInsets.only(top: 5),
                        //                 child: const Text(
                        //                   "Please enter at least one color",
                        //                   style: TextStyle(
                        //                       fontSize: 18,
                        //                       color: Colors.red,
                        //                       fontWeight: FontWeight.w600),
                        //                 ),
                        //               ),
                        //             )
                        //           : Container(),
                        Padding(
                            padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.06,
                        )),
                        Row(
                          children: [
                            Expanded(
                              child: TextButton(
                                onPressed: () {
                                  if (titleCOntroller.text.isNotEmpty &&
                                      labelCOntroller.text.isNotEmpty ) {
                                        String ltlng = (widget.deskMark.position.latitude.toString()+widget.deskMark.position.longitude.toString());
                                         Marker newMarker= Marker(
                                                  markerId:  MarkerId('current'+ltlng),
                                                  icon: BitmapDescriptor.defaultMarkerWithHue(HSVColor.fromColor(pickerColor).hue),
                                                  infoWindow:  InfoWindow(title: titleCOntroller.text, snippet: labelCOntroller.text),
                                                  position: widget.deskMark.position,
                                                  // position: LatLng(19.178895, 72.843181),
                                                );
                                    setState(() {
                                      widget.current.add(newMarker);
                                      validate = false;
                                    });
                                     Navigator.pop(context);
                                  } else {
                                     
                                    setState(() {
                                      validate = true;
                                    });
                                  }
                                },
                                child: Center(
                                  child: Container(
                                    height: 45,
                                    //width: double.infinity,
                                    width: 200,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: themePrimaryColor,
                                    ),
                                    // ignore: avoid_unnecessary_containers
                                    child: Container(
                                      child: const Align(
                                        child: Text(
                                          "Save",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Color(0xffFFFFFF)),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
