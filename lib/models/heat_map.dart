import 'package:befit/datetime/date_time.dart';
import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';

class MyHeatMap extends StatefulWidget {
  final Map<DateTime , int>? datasets;
  final String startDateYYYYMMDD;
  
  const MyHeatMap({super.key,
  required this.datasets,
  required this.startDateYYYYMMDD,
  });

  @override
  State<MyHeatMap> createState() => _MyHeatMapState();
}
class _MyHeatMapState extends State<MyHeatMap> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding:const EdgeInsets.all(8),
      key: UniqueKey(),
      child: HeatMap(
        startDate: createDateTimeObject(widget.startDateYYYYMMDD),
        endDate: DateTime.now().add(const Duration(days: 0)),
        datasets: widget.datasets,
        colorMode: ColorMode.color,
        colorsets: const{
          1:Colors.green,
        },
        defaultColor: Colors.grey[200],
        textColor: Colors.white,
        showColorTip: false,
        showText: true,
        scrollable: true,
        size: 30,
        
      ),
    );
  }
}