import 'package:fclp_app/utils/assets_pahts.dart';
import 'package:flutter/material.dart';

class ProdudctCategoryViewController extends ChangeNotifier {
  List<Map<dynamic, dynamic>> productCategoryViewData = [
    {
      'title': 'কাগজ',
      'img': '${AssetsPahts.icons}/kagoj.png',
    },
    {
      'title': 'জুতা',
      'img': '${AssetsPahts.icons}/juta.png',
    },
    {
      'title': 'গেঞ্জি',
      'img': '${AssetsPahts.icons}/tshirt.png',
    },
    {
      'title': 'ব্যাগ',
      'img': '${AssetsPahts.icons}/bag.png',
    },
    {
      'title': 'প্যান্ট',
      'img': '${AssetsPahts.icons}/pant.png',
    },
    {
      'title': 'শাড়ি',
      'img': '${AssetsPahts.icons}/saree.png',
    },
    {
      'title': 'নকশী কাথা',
      'img': '${AssetsPahts.icons}/nakshi_kantha.png',
    },
    {
      'title': 'থ্রী পিচ',
      'img': '${AssetsPahts.icons}/three_piece.png',
    },
    {
      'title': 'পাঞ্জাবী',
      'img': '${AssetsPahts.icons}/panjabi.png',
    },
    {
      'title': 'শার্ট',
      'img': '${AssetsPahts.icons}/shirt.png',
    },
    {
      'title': 'আধুনিক লুঙ্গি',
      'img': '${AssetsPahts.icons}/lungi.png',
    },
    {
      'title': 'চাদর',
      'img': '${AssetsPahts.icons}/chador.png',
    },
  ];
}
