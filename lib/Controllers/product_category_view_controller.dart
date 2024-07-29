import 'package:fclp_app/utils/assets_paths.dart';
import 'package:flutter/material.dart';

class ProdudctCategoryViewController extends ChangeNotifier {
  List<Map<dynamic, dynamic>> productCategoryViewData = [
    {
      'title': 'কাগজ',
      'img': '${AssetsPaths.icons}/kagoj.png',
    },
    {
      'title': 'জুতা',
      'img': '${AssetsPaths.icons}/juta.png',
    },
    {
      'title': 'গেঞ্জি',
      'img': '${AssetsPaths.icons}/tshirt.png',
    },
    {
      'title': 'ব্যাগ',
      'img': '${AssetsPaths.icons}/bag.png',
    },
    {
      'title': 'প্যান্ট',
      'img': '${AssetsPaths.icons}/pant.png',
    },
    {
      'title': 'শাড়ি',
      'img': '${AssetsPaths.icons}/saree.png',
    },
    {
      'title': 'নকশী কাথা',
      'img': '${AssetsPaths.icons}/nakshi_kantha.png',
    },
    {
      'title': 'থ্রী পিচ',
      'img': '${AssetsPaths.icons}/three_piece.png',
    },
    {
      'title': 'পাঞ্জাবী',
      'img': '${AssetsPaths.icons}/panjabi.png',
    },
    {
      'title': 'শার্ট',
      'img': '${AssetsPaths.icons}/shirt.png',
    },
    {
      'title': 'আধুনিক লুঙ্গি',
      'img': '${AssetsPaths.icons}/lungi.png',
    },
    {
      'title': 'চাদর',
      'img': '${AssetsPaths.icons}/chador.png',
    },
  ];
}
