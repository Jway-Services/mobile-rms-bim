

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../models/data_record.dart';



class ColumnChart extends StatefulWidget {
  List<DataRecord> data;
  String title;

   ColumnChart({required this.data,required this.title});

  @override
  State<ColumnChart> createState() => _ColumnChartState();
}

class _ColumnChartState extends State<ColumnChart> {


  final TextStyle labelStyle=GoogleFonts.aBeeZee(color:Colors.black);
  late double chartHeight;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    print("===========================${widget.data.toString()}");

    double width=MediaQuery.sizeOf(context).width;
    return Container(
        width: width*0.9,
        height: calculeChartHeight(),
        padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 30
        ),
        constraints:const BoxConstraints(
            maxWidth: 400
        ),
        decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(15)
        ),
        child:  SizedBox(
          height: calculeChartHeight(),
          child: SfCartesianChart(

            primaryXAxis: const CategoryAxis(
              labelRotation: 90,
              maximumLabels: 100,
            ),
            title: ChartTitle(text:widget.title,
                textStyle: GoogleFonts.aBeeZee(color:Colors.black,fontWeight:FontWeight.bold,fontSize:16)
            ),
            legend:const Legend(isVisible: true),
            tooltipBehavior: TooltipBehavior(enable: true),
            series: <CartesianSeries>[
              ColumnSeries<DataRecord, String>(
                dataSource: widget.data,
                xValueMapper: (DataRecord data, _) => data.name,
                yValueMapper: (DataRecord data, _) =>data.value,
                name: 'Nombre de repas',
                color: Colors.blue,
                dataLabelSettings: DataLabelSettings(
                  textStyle:labelStyle
                ),
              ),
            ],
          ),
        )
    );
  }

  double calculeChartHeight(){

    String biggerLength="";
    for(DataRecord data in widget.data){
      if(data.name!.length>biggerLength.length){
        biggerLength=data.name!;
      }
    }
    print("bigger len : ${biggerLength}");
    TextPainter textPainter=TextPainter(
      text: TextSpan(text: biggerLength,style: labelStyle),
      textDirection: TextDirection.rtl
    )..layout(minWidth: 0, maxWidth: double.infinity);
    double width=textPainter.width;
    print("bigger width : ${width}");
    return (width+280);

  }





}
