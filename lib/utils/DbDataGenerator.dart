import 'dart:core';

import 'package:cannabis_calculator/models/models.dart';


List<DbOilType> getOilTypes() {
  List<DbOilType> categoryModelArrayList = List<DbOilType>();

  DbOilType item1 = DbOilType();
  item1.image = "images/420chef/butter_icon_4.png";
  item1.id = 1;
  item1.name = "Butter";
  item1.value = 0.0;

  DbOilType item2 = DbOilType();
  item2.image = "images/420chef/olive_oil_2.png";
  item2.id = 2;
  item2.name = "Olive Oil";
  item2.value = 0.0;

  DbOilType item3 = DbOilType();
  item3.image = "images/420chef/coconut_oil_2.png";
  item3.name = "Coconut Oil";
  item3.value = 0.0;

  DbOilType item5 = DbOilType();
  item5.image = "images/420chef/avocado_oil.png";
  item5.name = "Avocado Oil";
  item5.value = 0.0;

  DbOilType item6 = DbOilType();
  item6.image = "images/420chef/grape_seed_oil.png";
  item6.name = "Grapeseed Oil";
  item6.value = 0.0;

  DbOilType item7 = DbOilType();
  item7.image = "images/420chef/peanut_oil.png";
  item7.name = "Peanut Oil";
  item7.value = 0.0;


  categoryModelArrayList.add(item1);
  categoryModelArrayList.add(item2);
  categoryModelArrayList.add(item3);
  categoryModelArrayList.add(item5);
  categoryModelArrayList.add(item6);
  categoryModelArrayList.add(item7);

  return categoryModelArrayList;
}