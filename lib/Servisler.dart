import 'package:flutter/material.dart';

class Servisler{
  final String title;
  final String description;
  final String description2;
  final String data;
  final String data2;
  final String image;
  final Color color;

  Servisler({this.title,this.description,this.description2,this.data,this.data2,this.image,this.color});


}
Servisler el0 = new Servisler(title: "Hedef Kitle Analizi", description:"Bu magazayi en fazla ziyaret eden profil",data: "29-40 Yas",image: 'images/Resim1.png',color: Color(0xFF5E2750));
Servisler el1 = new Servisler(title: "Kisi Sayar", description:"Magazasi Giris Sayisi",data: "29-40 Yas",image: 'images/Resim2.png',color: Color(0xFF4A4D4E));
Servisler el2 = new Servisler(title: "Musteri Memnuyiet Analizi", description:"Ortalama Puan ",data: "8.00",description2: "Kullanilan Oy",data2:"10",image: 'images/Resim3.png',color: Color(0xFF007C92));
Servisler el3 = new Servisler(title: "Ekran Yonetimi", description:"Icerik sayisi",data: "4",image: 'images/Resim4.png',color: Color(0xFF9C2AA0));
Servisler el4 = new Servisler(title: "NPS Yonetimi", description:"Soru seti sayisi",data: "4",image: 'images/Resim5.png',color: Color(0xFFA8B400));

List<Servisler> srvLst=[el0,el1,el2,el3,el4];