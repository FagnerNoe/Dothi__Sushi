import 'dart:ui';
import 'package:dothi/colors/gradient_text.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dothi/colors/tema.dart';
import 'package:dothi/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SushiListScreen extends StatefulWidget {
  @override
  _SushiListScreenState createState() => _SushiListScreenState();
}

class _SushiListScreenState extends State<SushiListScreen> {
  final ApiService apiService = ApiService();
  late Future<List<dynamic>> sushiList;

  // Threshold for scroll direction change

  @override
  void initState() {
    super.initState();
    sushiList = apiService.fetchSushi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        toolbarHeight: 80,
        excludeHeaderSemantics: true,
        title: Text(
          "Olá , Usuário",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'Arial',
          ),
        ),
        automaticallyImplyLeading: false,
        toolbarOpacity: 1,
        actions: [
          CircleAvatar(
            backgroundColor: Colors.orangeAccent,
            backgroundImage: NetworkImage(
              "https://img.freepik.com/psd-gratuitas/ilustracao-de-icone-de-contacto-isolada_23-2151903337.jpg?ga=GA1.1.194282251.1665883760&semt=ais_hybrid&w=740",
            ),
            radius: 25,
          ),
          SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            child: Column(
              spacing: 5,
              children: [
                Container(
                  padding: EdgeInsets.all(5.0),
                  margin: EdgeInsets.only(top: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          SizedBox(width: 10),
                          GradientText(
                            "Mais Pedidos",
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              fontFamily: GoogleFonts.praise().fontFamily,
                            ),
                            gradient: LinearGradient(
                              colors: [
                                dothiSushi.primaryColor,
                                const Color.fromARGB(255, 244, 179, 164),
                              ],
                            ),
                          ),
                        ],
                      ),

                      SizedBox(
                        height: 350,
                        child: FutureBuilder<List<dynamic>>(
                          future: sushiList,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Center(child: Text("Erro ao carregar"));
                            } else {
                              return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  var sushi = snapshot.data![index];

                                  return Container(
                                    margin: EdgeInsets.all(14),
                                    padding: EdgeInsets.only(bottom: 10),
                                    width: 180,
                                    height: 200,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(sushi['image']),
                                        fit: BoxFit.cover,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color.fromARGB(
                                            255,
                                            202,
                                            202,
                                            202,
                                          ),
                                          spreadRadius: 2,
                                          blurRadius: 3,
                                          offset: Offset(0, 2),
                                        ),
                                      ],
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: const Color.fromARGB(
                                        219,
                                        255,
                                        255,
                                        255,
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      spacing: 10,
                                      children: [
                                        ClipRect(
                                          child: BackdropFilter(
                                            filter: ImageFilter.blur(
                                              sigmaX: 5,
                                              sigmaY: 5,
                                            ),
                                            child: Container(
                                              width: 160,
                                              height: 70,
                                              decoration: BoxDecoration(
                                                color: const Color.fromARGB(
                                                  22,
                                                  255,
                                                  255,
                                                  255,
                                                ),
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(10),
                                                ),
                                              ),

                                              child: Column(
                                                children: [
                                                  GradientText(
                                                    "${sushi['name']}",
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily:
                                                          GoogleFonts.satisfy()
                                                              .fontFamily,
                                                    ),
                                                    gradient: LinearGradient(
                                                      colors: [
                                                        Colors.lightGreenAccent,
                                                        dothiSushi
                                                            .scaffoldBackgroundColor,
                                                      ],
                                                    ),
                                                  ),

                                                  GradientText(
                                                    "R\$ ${sushi['price']}",
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily:
                                                          GoogleFonts.archivoBlackTextTheme()
                                                              .headlineMedium!
                                                              .fontFamily,
                                                    ),
                                                    gradient: LinearGradient(
                                                      colors: [
                                                        Colors.white54,
                                                        Colors.white,
                                                      ],
                                                    ),
                                                  ),
                                                  Text(
                                                    "${sushi['quantidade']} unidades",
                                                    style: TextStyle(
                                                      fontSize: 7,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10.0),
                  margin: EdgeInsets.only(top: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 50,
                        padding: EdgeInsets.only(left: 20),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: dothiSushi.primaryColor,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: GradientText(
                          "Combos",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            fontFamily: GoogleFonts.praise().fontFamily,
                          ),
                          gradient: LinearGradient(
                            colors: [
                              const Color.fromARGB(255, 243, 195, 35),
                              dothiSushi.primaryColor,
                            ],
                          ),
                        ),
                      ),

                      SizedBox(
                        height: 350,
                        child: FutureBuilder<List<dynamic>>(
                          future: sushiList,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Center(child: Text("Erro ao carregar"));
                            } else {
                              return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: 4,
                                itemBuilder: (context, index) {
                                  var sushi = snapshot.data![index];

                                  return Container(
                                    margin: EdgeInsets.all(14),
                                    padding: EdgeInsets.only(bottom: 10),
                                    width: 310,
                                    height: 200,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(sushi['image']),
                                        fit: BoxFit.cover,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color.fromARGB(
                                            255,
                                            202,
                                            202,
                                            202,
                                          ),
                                          spreadRadius: 2,
                                          blurRadius: 3,
                                          offset: Offset(0, 2),
                                        ),
                                      ],
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: const Color.fromARGB(
                                        219,
                                        255,
                                        255,
                                        255,
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      spacing: 10,
                                      children: [
                                        ClipRect(
                                          child: BackdropFilter(
                                            filter: ImageFilter.blur(
                                              sigmaX: 5,
                                              sigmaY: 5,
                                            ),
                                            child: Container(
                                              width: 160,
                                              height: 70,
                                              decoration: BoxDecoration(
                                                color: const Color.fromARGB(
                                                  22,
                                                  255,
                                                  255,
                                                  255,
                                                ),
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(10),
                                                ),
                                              ),

                                              child: Column(
                                                children: [
                                                  GradientText(
                                                    "${sushi['name']}",
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily:
                                                          GoogleFonts.satisfy()
                                                              .fontFamily,
                                                    ),
                                                    gradient: LinearGradient(
                                                      colors: [
                                                        const Color.fromARGB(
                                                          255,
                                                          147,
                                                          241,
                                                          32,
                                                        ),
                                                        dothiSushi
                                                            .scaffoldBackgroundColor,
                                                      ],
                                                    ),
                                                  ),

                                                  GradientText(
                                                    "R\$ ${sushi['price']}",
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily:
                                                          GoogleFonts.archivoBlackTextTheme()
                                                              .headlineMedium!
                                                              .fontFamily,
                                                    ),
                                                    gradient: LinearGradient(
                                                      colors: [
                                                        Colors.white54,
                                                        Colors.white,
                                                      ],
                                                    ),
                                                  ),
                                                  Text(
                                                    "${sushi['quantidade']} unidades",
                                                    style: TextStyle(
                                                      fontSize: 7,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Container(width: double.infinity, height: 100),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
