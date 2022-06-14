import 'package:flutter/material.dart';
import 'package:world_time/services/world_time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {


  void setupWorldTime () async {
    WorldTime instance = WorldTime(location: 'Tokyo', flag: 'https://www.countries-ofthe-world.com/flags-normal/flag-of-Japan.png', url: 'Asia/Tokyo');
    await instance.getTime();
    Navigator.pushReplacementNamed(context, '/home', arguments: {
      'location': instance.location,
      'flag': instance.flag,
      'time': instance.time,
      'isDayTime': instance.isDayTime,
    });

  }

  @override
  void initState() {

    super.initState();
    setupWorldTime();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/loading.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SpinKitThreeInOut(
            color: Colors.white,
            size: 20.0,
          ),
        ),
      ),
    );
  }
}
