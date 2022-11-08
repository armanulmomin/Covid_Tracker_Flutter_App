import 'package:covid_tracker/Services/states_services.dart';
import 'package:flutter/material.dart';

import 'detail_screen.dart';

class CountriesList extends StatefulWidget {
  const CountriesList({Key? key}) : super(key: key);

  @override
  State<CountriesList> createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8),
              child: TextFormField(
                onChanged: (value){
                  setState(() {

                  });
                },
                controller: searchController,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 20),
                    hintText: 'Search with country name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    )),
              ),
            ),
            Expanded(
                child: FutureBuilder(
                    future: statesServices.CountriesListApi(),
                    builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                      if (!snapshot.hasData) {
                        return Text('Loading...');
                      } else {
                        return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              String name = snapshot.data![index]['country'];
                              if(searchController.text.isEmpty){
                                return Column(
                                  children: [
                                    InkWell(
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreen(
                                          name : snapshot.data![index]['country'],
                                          image : snapshot.data![index]
                                          ['countryInfo']['flag'],
                                          totalCases : snapshot.data![index]['cases'],
                                          totalRecovered : snapshot.data![index]['recovered'],
                                          totalDeaths : snapshot.data![index]['deaths'],
                                          active : snapshot.data![index]['active'],
                                          test : snapshot.data![index]['tests'],
                                          todayRecovered : snapshot.data![index]['todayRecovered'],
                                          critical : snapshot.data![index]['critical'],





                                        )));

                                },
                                      child: ListTile(
                                        title:
                                        Text(snapshot.data![index]['country']),
                                        subtitle: Text(snapshot.data![index]
                                        ['cases']
                                            .toString()),
                                        leading: Image(
                                          height: 50,
                                          width: 50,
                                          image: NetworkImage(snapshot.data![index]
                                          ['countryInfo']['flag']),
                                        ),
                                      ),
                                    )
                                  ],
                                );

                              }
                              else if(name.toLowerCase().contains(searchController.text.toLowerCase()))
                                {
                                  return Column(
                                    children: [
                                      ListTile(
                                        title:
                                        Text(snapshot.data![index]['country']),
                                        subtitle: Text(snapshot.data![index]
                                        ['cases']
                                            .toString()),
                                        leading: Image(
                                          height: 50,
                                          width: 50,
                                          image: NetworkImage(snapshot.data![index]
                                          ['countryInfo']['flag']),
                                        ),
                                      )
                                    ],
                                  );

                                }
                              else
                                {
                                  return Container(


                                  );

                                }


                              return Column(
                                children: [
                                  ListTile(
                                    title:
                                        Text(snapshot.data![index]['country']),
                                    subtitle: Text(snapshot.data![index]
                                            ['cases']
                                        .toString()),
                                    leading: Image(
                                      height: 50,
                                      width: 50,
                                      image: NetworkImage(snapshot.data![index]
                                          ['countryInfo']['flag']),
                                    ),
                                  )
                                ],
                              );
                            });
                      }
                    }))
          ],
        ),
      ),
    );
  }
}
