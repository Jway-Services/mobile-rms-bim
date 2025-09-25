import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../models/data_record.dart';

class PieChartWidget extends StatefulWidget {
  final List<DataRecord> data;
  final String title;

  const PieChartWidget({Key? key, required this.data, required this.title}) : super(key: key);

  @override
  State<PieChartWidget> createState() => _PieChartWidgetState();
}

class _PieChartWidgetState extends State<PieChartWidget> {
  final TextStyle labelStyle = GoogleFonts.aBeeZee(color: Colors.black);
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    super.initState();
    _tooltipBehavior=TooltipBehavior(
        color: Colors.white,
        enable: true,
        textStyle: GoogleFonts.aBeeZee(color:Colors.black)
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;

    return Container(
      width: width * 0.9,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
      constraints: const BoxConstraints(maxWidth: 400),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(15),
      ),
      child: SfCircularChart(
        title: ChartTitle(
          text: widget.title,
          textStyle: GoogleFonts.aBeeZee(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        legend: const Legend(
          isVisible: true,
          alignment: ChartAlignment.center,
          position: LegendPosition.auto,
          isResponsive: true,
          orientation: LegendItemOrientation.horizontal,
          overflowMode: LegendItemOverflowMode.scroll,
        ),
        tooltipBehavior: _tooltipBehavior,
          series: <PieSeries<DataRecord, String>>[
            PieSeries<DataRecord, String>(
              explode: true,
              explodeIndex: 0,
              dataSource: widget.data,
              xValueMapper: (DataRecord data, _) => data.name,
              yValueMapper: (DataRecord data, _) => data.value,
              dataLabelMapper: (DataRecord data,int)=>data.name,
              dataLabelSettings:  DataLabelSettings(
                  isVisible: true,
                  labelPosition: ChartDataLabelPosition.outside,
                  textStyle: GoogleFonts.poppins(color:Colors.black,fontSize:10,fontWeight:FontWeight.bold)
              ),

            ),
          ]
      ),
    );
  }
}
