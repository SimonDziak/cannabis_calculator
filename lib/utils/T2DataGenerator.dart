import 'package:cannabis_calculator/models/models.dart';
import 'package:cannabis_calculator/utils/Images.dart';
import 'package:cannabis_calculator/utils/Strings.dart';

List<T2Favourite> getFavourites() {
  List<T2Favourite> list = List<T2Favourite>();
  T2Favourite model1 = T2Favourite();
  model1.name = "asaBest Jogging tips in the world";
  model1.duration = "5 min ago";
  model1.image = t2_ic_img1;

  T2Favourite model2 = T2Favourite();
  model2.name = "Best Yoga guide for better Health in the world";
  model2.duration = "15 min ago";
  model2.image = t2_ic_img2;

  T2Favourite model3 = T2Favourite();
  model3.name = "Best Exercise tips in the world";
  model3.duration = "an hour ago";
  model3.image = t2_img3;

  T2Favourite model4 = T2Favourite();
  model4.name = "Best Diet tips for the good Health";
  model4.duration = "5 hour ago";
  model4.image = t2_img4;

  T2Favourite model5 = T2Favourite();
  model5.name = "Healty food tips in the world";
  model5.duration = "7 hour ago";
  model5.image = t2_ic_img1;

  list.add(model1);
  list.add(model2);
  list.add(model3);
  list.add(model4);
  list.add(model5);
  list.add(model1);
  list.add(model2);
  list.add(model3);
  list.add(model4);
  list.add(model5);
  list.add(model1);
  list.add(model2);
  list.add(model3);
  list.add(model4);
  list.add(model5);
  list.add(model1);
  list.add(model2);
  list.add(model3);
  list.add(model4);
  list.add(model5);
  return list;
}

List<T2Slider> getSliders() {
  List<T2Slider> list = List<T2Slider>();

  T2Slider model1 = T2Slider();
  model1.title = "Jeff Recipe";
  model1.subTitle = "Light tasting cannabutter recipe";
  model1.image = "images/theme2/jeff_light_tasting.png";
  model1.url = "https://www.jeffthe420chef.com/post/jeff-s-ez-light-tasting-cannabutter";


  T2Slider model2 = T2Slider();
  model2.image = "images/theme2/canna_oil.png";
  model2.url = "https://www.jeffthe420chef.com/post/cannabis-olive-oil";


  T2Slider model3 = T2Slider();
  model3.title = "CLEAN YOUR HEMP BLOG";
  model3.image = "images/theme2/clean_hemp.png";
  model3.url = "https://www.jeffthe420chef.com/post/clean-your-cannabis-hemp";

  T2Slider model4 = T2Slider();
  model4.title = "Decarbing";
  model4.subTitle = "What is it and how you do it";
  model4.image = "images/theme2/what_decarbing.png";
  model4.url = "https://www.jeffthe420chef.com/post/what-is-decarbing-and-how-you-do-it";

  T2Slider model5 = T2Slider();
//  model5.title = t2_420chef;
//  model5.subTitle = t2_other2_text;
  model5.image = "images/theme2/infusion_times.png";
  model5.url = "https://www.jeffthe420chef.com/post/infusion-times-temps";

  list.add(model1);
  list.add(model2);
  list.add(model3);
  list.add(model4);
  list.add(model5);

  return list;
}

List<T2ListModel> getListData() {
  List<T2ListModel> mData = List<T2ListModel>();

  T2ListModel model1 = T2ListModel();
  model1.name = "Flower Tips";
  model1.duration = "12 min ago";
  model1.description = "Lorem Ipsum is simply dummy text of the printing and typesetting industry.Lorem Ipsum is simply dummy text.";
  model1.type = "New";
  model1.icon = t2_list_1;

  T2ListModel model2 = T2ListModel();
  model2.name = "Health Tips";
  model2.duration = "12 min ago";
  model2.description = "Lorem Ipsum is simply dummy text of the printing and typesetting industry.Lorem Ipsum is simply dummy text.";
  model2.type = "Popular";
  model2.icon = t2_list_2;

  T2ListModel model3 = T2ListModel();
  model3.name = "Food Tips";
  model3.duration = "12 min ago";
  model3.description = "Lorem Ipsum is simply dummy text of the printing and typesetting industry.Lorem Ipsum is simply dummy text.";
  model3.type = "New";
  model3.icon = t2_list_3;

  T2ListModel model4 = T2ListModel();
  model4.name = "Health Tips";
  model4.duration = "12 min ago";
  model4.description = "Lorem Ipsum is simply dummy text of the printing and typesetting industry.Lorem Ipsum is simply dummy text.";
  model4.type = "New";
  model4.icon = t2_list_1;

  mData.add(model1);
  mData.add(model2);
  mData.add(model3);
  mData.add(model4);
  mData.add(model1);
  mData.add(model2);
  mData.add(model3);
  mData.add(model4);
  mData.add(model1);
  mData.add(model2);
  mData.add(model3);
  mData.add(model4);
  mData.add(model1);
  mData.add(model2);
  mData.add(model3);
  mData.add(model4);
  mData.add(model1);
  mData.add(model2);
  mData.add(model3);
  mData.add(model4);
  mData.add(model1);
  mData.add(model2);
  mData.add(model3);
  mData.add(model4);
  return mData;
}
/*
List<T2DrawerItem> getDrawerItems() {
  List<T2DrawerItem> list = List<T2DrawerItem>();
  T2DrawerItem model1 = T2DrawerItem();
  model1.title = t2_lbl_profile;
  model1.image = Icons.person_outline;
  T2DrawerItem model2 = T2DrawerItem();
  model2.title = t2_lbl_message;
  model2.image = Icons.chat_bubble_outline;
  T2DrawerItem model3 = T2DrawerItem();
  model3.title = t2_lbl_profile;
  model3.image = Icons.char;
  T2DrawerItem model4 = T2DrawerItem();
  model4.title = t2_lbl_profile;
  model4.image = Icons.person_outline;
  T2DrawerItem model5 = T2DrawerItem();
  model5.title = t2_lbl_profile;
  model5.image = Icons.person_outline;

  list.add(model1);
  list.add(model2);
  list.add(model3);
  return list;
}
*/