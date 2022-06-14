import 'package:flutter/material.dart';
import 'package:bordered_text/bordered_text.dart';
import 'package:world_time/pages/Navbar.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Map data = {};

  @override
  Widget build(BuildContext context) {

    data = data.isNotEmpty ? data : ModalRoute.of(context)!.settings.arguments as Map;
    //print(data['isDayTime']);

    //String bgImage = data['isDayTime'] ? 'day.png' : 'night.png';
    //Color? bgColor = data['isDayTime'] ? Colors.red[800] : Colors.purple[900];

    String bgi = data['location']+'.png';
    //print(bgi);

    return Scaffold(
      //backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Colors.purple[900],
      ),
      drawer: navbar(),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/'+bgi),
              fit: BoxFit.fill,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 120.0, 0, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    BorderedText(
                      strokeWidth: 2.0,
                      strokeColor: Colors.blueGrey,
                      child: Text(
                        data['location'],
                        style: TextStyle(
                          fontSize: 28.0,
                          letterSpacing: 2.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0,),
                BorderedText(
                  strokeWidth: 4.0,
                  strokeColor: Colors.blueGrey,
                  child: Text(
                    data['time'],
                    style: TextStyle(
                      fontSize: 66.0,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 20.0,),
                TextButton.icon(
                  onPressed: () async {
                    dynamic result = await Navigator.pushNamed(context, '/location');
                    setState(() {
                      data = {
                        'location': result['location'],
                        'flag': result['flag'],
                        'time': result['time'],
                        'isDayTime': result['isDayTime'],
                      };
                    });
                  },
                  icon: Icon(
                    Icons.edit_location,
                    size: 30.0,
                  ),
                  label: BorderedText(
                    strokeWidth: 2.0,
                    strokeColor: Colors.blueGrey,
                    child: Text(
                      'Edit location',
                      style: TextStyle(
                        letterSpacing: 3.0
                      ),
                    ),
                  ),
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(Colors.grey[300]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
