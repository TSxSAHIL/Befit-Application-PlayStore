//return todays date as yy//mm//dd
String todaysDateYYYYMMDD(){
  var dateTimeObject = DateTime.now();
  //year in the format yyyy
  String year = dateTimeObject.year.toString();
  //month in the format mm
  String month = dateTimeObject.month.toString();
  if(month.length==1){
    month = '0$month';
  }
  //day on the format dd
  String day = dateTimeObject.day.toString();
  if(day.length==1){
    day = '0$day';
  }
  String yyyymmdd = year + month + day;
  return yyyymmdd;
}
//convert string yy//mm//dd to DateTime Object
DateTime createDateTimeObject(String yyyymmdd){
  int yyyy = int.parse(yyyymmdd.substring(0,4));
  int mm = int.parse(yyyymmdd.substring(4,6));
  int dd = int.parse(yyyymmdd.substring(6,8));

  DateTime dateTimeObject = DateTime(yyyy , mm , dd);
  return dateTimeObject;
}
//convert DateTime object to a string yy//mm//dd
String convertDateTimeToYYYYMMDD(DateTime dateTime){
  String year = dateTime.year.toString();
  //month in the format mm
  String month = dateTime.month.toString();
  if(month.length == 1){
    month = '0$month';
  }
  //day in the format dd
  String day = dateTime.day.toString();
  if(day.length==1){
    day = '0$day';
  }
  //final format
  String yyyymmdd = year + month + day;
  return yyyymmdd;
}