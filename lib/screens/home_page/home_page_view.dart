import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:perkiraan_cuaca/data/services/weater_services.dart';

import '../../data/model/weather_model.dart';

class HomepageView extends StatefulWidget {
  const HomepageView({Key? key}) : super(key: key);

  @override
  State<HomepageView> createState() => _HomepageViewState();
}

class _HomepageViewState extends State<HomepageView> {
  var services = WeatherServices();
  String? errorMessage;
  Weather? weatherData;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    await Future.delayed(const Duration(seconds: 2));
    var result = await services.getWeather();
    result.fold(
      (error) {
        errorMessage = error;
      },
      (weather) {
        weatherData = weather;
      },
    );
    setState(() {});
  }

  var namaAnggota = [
    {"nama": "Ade gianti", "nim": "2013045"},
    {"nama": "Indi zhafitra", "nim": "2013007"},
    {"nama": "Muhammad aji", "nim": "2013075"},
    {"nama": "Ahmda fauzi", "nim": "2013055"},
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffDCE3E9),
        body: (errorMessage != null)
            ? SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Error",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "$errorMessage",
                        style: const TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : SingleChildScrollView(
                child: (weatherData == null)
                    ? SizedBox(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: const Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(),
                              SizedBox(
                                height: 20.0,
                              ),
                              Text(
                                "Loading data",
                                style: TextStyle(
                                  fontSize: 20.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 50.0,
                            ),
                            Text(
                              weatherData!.location.name,
                              style: GoogleFonts.montserrat(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "${weatherData!.location.region} ${weatherData!.location.country}",
                              style: GoogleFonts.montserrat(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            Container(
                              height: 200.0,
                              width: 200.0,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                    "https:${weatherData!.current.condition.icon}",
                                  ),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(
                                    16.0,
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              weatherData!.current.condition.text,
                              style: GoogleFonts.montserrat(
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            SizedBox(
                              height: 50,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${weatherData!.current.tempC}",
                                    style: GoogleFonts.montserrat(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const ImageIcon(
                                    AssetImage(
                                      "assets/simbol/degree.png",
                                    ),
                                    size: 30.0,
                                  ),
                                  Text(
                                    "C",
                                    style: GoogleFonts.montserrat(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 30.0,
                            ),
                            Container(
                              height: 100.0,
                              width: MediaQuery.of(context).size.width / 1.5,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    16.0,
                                  ),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 50.0,
                                          width: 50.0,
                                          decoration: const BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                "assets/simbol/rain.png",
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                16.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const Text(
                                          "Kecepatan angin",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          "${weatherData!.current.windMph}",
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  const VerticalDivider(
                                    color: Colors.black,
                                    thickness: 1,
                                    width: 20,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 50.0,
                                          width: 50.0,
                                          decoration: const BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                "assets/simbol/clouds.png",
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                16.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const Text(
                                          "Persentase penutupan awan",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 10.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          "${weatherData!.current.cloud}",
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 50.0,
                            ),
                            Container(
                              width: 280,
                              decoration: const BoxDecoration(),
                              child: Column(
                                children: [
                                  const Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "Nama",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18.0,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          "Nim",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18.0,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: List.generate(namaAnggota.length,
                                        (index) {
                                      var item = namaAnggota[index];
                                      return Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              "${item['nama']}",
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                fontSize: 18.0,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              "${item['nim']}",
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                fontSize: 18.0,
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    }),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
              ),
      ),
    );
  }
}
