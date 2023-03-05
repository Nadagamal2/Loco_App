import 'package:http/http.dart' as http;

import '../models/country_model.dart';


var url='http://eibtekone-001-site18.atempurl.com/api/GetAll_Questions';
getData()async{
  var responce=await http.get(Uri.parse(url));
  if(responce.statusCode==200){

    CountryModel data=countryModelFromJson(responce.body);
    return data;
  }
}