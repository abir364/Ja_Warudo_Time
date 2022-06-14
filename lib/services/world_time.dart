import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:intl/intl.dart';

class WorldTime{

  String location;//location name for UI
  String? time = null;//time for that location
  String flag;//asset url to a flag
  String url;// url of api endpoint for the specific location
  bool? isDayTime;

  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async{
    //make request
    try{
      var u = Uri.parse( 'http://worldtimeapi.org/api/timezone/'+url );
      var response = await http.get(u);
      Map data = convert.jsonDecode(response.body);
      //print(data);

      //get properties from data
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1,3);
      //print(datetime);
      //print(offset);

      //create datetime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

      //set the time property
      isDayTime = now.hour >= 6 && now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now);
    }
    catch(e){
      print(e);
      time = 'could not load time data';
    }

}
}