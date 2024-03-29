import 'package:covid_tracker/Model/WorldStatesModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter/gestures.dart';

import '../Services/states_services.dart';
import 'countries_list.dart';

class WorldStatesScreen extends StatefulWidget {
  const WorldStatesScreen({Key? key}) : super(key: key);

  @override
  State<WorldStatesScreen> createState() => _WorldStatesScreenState();
}

class _WorldStatesScreenState extends State<WorldStatesScreen>
    with TickerProviderStateMixin {
  late final AnimationController controller = AnimationController(
      //late = value will be given soon
      // final = as instance variable, don't occupy memeory unless it used, can be assigned diffrent values
      duration: const Duration(seconds: 3),
      vsync: this)
    ..repeat();
  //vsync = to keep the tract of the screen
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  final colorList = <Color>[
    Color(0xff4285F4),
    Color(0xff1aa260),
    Color(0xffde5246),
  ];
  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * .01),

                /*
                  padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height * .06),

                */
                FutureBuilder(
                    future: statesServices.FetchWordlSatesRecord(),
                    builder:
                        (context, AsyncSnapshot<WorldStatesModel> snapshot) {
                      if (!snapshot.hasData) {
                        return Expanded(
                          flex: 1,
                          child: SpinKitFadingCircle(
                            color: Colors.white,
                            size: 50,
                            controller: controller,
                          ),
                        );
                      } else {
                        return Column(
                          children: [
                            PieChart(
                              dataMap: {
                                'total': double.parse(
                                    snapshot.data!.cases.toString()),
                                'Recovered': double.parse(
                                    snapshot.data!.recovered.toString()),
                                'Deaths': double.parse(
                                    snapshot.data!.deaths.toString()),
                              },
                              chartValuesOptions: const ChartValuesOptions(
                                  showChartValuesInPercentage: true),
                              chartRadius:
                                  MediaQuery.of(context).size.width / 3.2,
                              animationDuration: Duration(milliseconds: 1200),
                              chartType: ChartType.ring,
                              colorList: colorList,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical:
                                      MediaQuery.of(context).size.height * .02),
                              child: Card(
                                child: Column(
                                  children: [
                                    ReusableRow(
                                        title: 'total',
                                        value: snapshot.data!.cases.toString()),
                                    ReusableRow(
                                        title: 'Recovered',
                                        value: snapshot.data!.recovered
                                            .toString()),
                                    ReusableRow(
                                        title: 'Deaths',
                                        value:
                                            snapshot.data!.deaths.toString()),
                                    ReusableRow(
                                        title: 'Active',
                                        value:
                                            snapshot.data!.active.toString()),
                                    ReusableRow(
                                        title: 'Critical',
                                        value:
                                            snapshot.data!.critical.toString()),
                                    ReusableRow(
                                        title: 'Today Deaths',
                                        value: snapshot.data!.todayDeaths
                                            .toString()),
                                    ReusableRow(
                                        title: 'Today Recovered',
                                        value: snapshot.data!.todayRecovered
                                            .toString()),
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CountriesList()));
                              },
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                    color: Color(0xff1aa260),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                  child: Text('Track Countries'),
                                ),
                              ),
                            )
                          ],
                        );
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ReusableRow extends StatelessWidget {
  String title, value;
  ReusableRow({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Divider(),
        ],
      ),
    );
  }
}
