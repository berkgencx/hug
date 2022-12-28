import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HUG GAME',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Hibrit Uygulama Geliştirme - 3. Grup'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Timer timer1;
  double ust = -60, sol = 10, ust2 = -60, sol2 = 10, zeminTop = 450, balonYukseklik = 30;
  int puan = 0, hiz = 1;

  void baslat(){
    print("Oyun Başladı");
    setState(() {
      timer1 =  Timer.periodic(const Duration( milliseconds: 30), (timer) {
        setState(() {
          ust = ust + hiz;
          ust2 = ust2 + hiz;
          if (puan < 500) {
            ust2 = -60;
          }
          if(ust + balonYukseklik >= zeminTop || ust2 + balonYukseklik >= zeminTop) { 
            timer1.cancel();
            print("Oyun Bitti");
          }
        });
      });
    });
  }

  void puanKontrol(){
    if(puan % 250 == 0) {
      hiz = hiz + 1;
      print("Hız Arttı");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
         centerTitle: true,
      ),
      body: Center(
        child: Stack(
          children: <Widget> [
            Positioned(
              top: ust,
              left: sol,
              height: 70,
              width: 70,
              child: IconButton(
                icon: Image.asset("images/hd-dark-red-vector-decoration-balloon-png-citypng.png",fit: BoxFit.cover,),
                onPressed: () {
                  puan = puan + 50;
                  ust = -35;
                  Random random = Random();
                  double randomSayi() {
                    return random.nextDouble() * MediaQuery.of(context).size.width; //balonların yeni konumlarını ekran genişliği üzerinden belirler
                  }
                  print(randomSayi());
                  sol = randomSayi();
                  puanKontrol();
                },
              ),
            ),
            Positioned(
              top: ust2,
              left: sol2,
              height: 70,
              width: 70,
              child: IconButton(
                icon: Image.asset("images/hd-dark-red-vector-decoration-balloon-png-citypng.png",fit: BoxFit.cover,),
                onPressed: (){
                  puan = puan + 50;
                  ust2 = -35;
                  Random random = Random();
                  double randomSayi() {
                    return random.nextDouble() * MediaQuery.of(context).size.width; //balonların yeni konumlarını ekran genişliği üzerinden belirler
                  }
                  print(randomSayi());
                  sol2 = randomSayi();
                  puanKontrol();
                },
              ),
            ),
            Positioned(
              left: 10,
              bottom: 20,
              child: ElevatedButton(
                onPressed: baslat,
                child: const Text("Oyunu Başlat"),
              ),
            ),
            Positioned(
              left: 0,
              top: zeminTop,
              width: MediaQuery.of(context).size.width, //alt barın genişliğini ekran genişliğinde ayarlar
              child: ElevatedButton(
                onPressed: (){},
                child: const Text(""),
              ),
            ),
            Positioned(
              right: 10,
              top: 10,
              child: Text('$puan')
            ),
          ],
        ),
      ),
    );
  }
}