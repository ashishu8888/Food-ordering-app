import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:food_ordering_app/admin/services/admin_services.dart';
import 'package:food_ordering_app/constants/utils.dart';
import 'package:food_ordering_app/providers/user_provider.dart';
import 'package:food_ordering_app/widgets/custom_button.dart';
import 'package:food_ordering_app/widgets/custom_textfield.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import 'package:textfield_tags/textfield_tags.dart';

class AddShopScreen extends StatefulWidget {
  static const String routeName = "/add-shop-screen";
  const AddShopScreen({Key? key}) : super(key: key);

  @override
  State<AddShopScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddShopScreen> {
  final AdminServices adminServices = AdminServices();
  final TextEditingController ownerNameController = TextEditingController();
  final TextEditingController shopNameController = TextEditingController();
  final TextEditingController avgpriceController = TextEditingController();

  final _addProductFormKey = GlobalKey<FormState>();

  List<String> tags = ["Fastfood", "pepsi"]; //initial tags
  List<File> images = [];
  @override
  void dispose() {
    super.dispose();
    ownerNameController.dispose();
    shopNameController.dispose();
    avgpriceController.dispose();
  }

  void selectImages() async {
    var res = await pickImages();
    setState(() {
      images = res;
    });
  }

  void createShop() {
    if (_addProductFormKey.currentState!.validate() && images.isNotEmpty) {
      adminServices.createShop(
        context: context,
        ownerName: ownerNameController.text,
        shopName: shopNameController.text,
        avgPrice: double.parse(avgpriceController.text),
        images: images,
        tags: tags,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register your Shop'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _addProductFormKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  height: 20,
                ),
                images.isNotEmpty
                    ? CarouselSlider(
                        items: images.map(
                          (i) {
                            return Builder(
                              builder: (BuildContext context) => Image.file(
                                i,
                                fit: BoxFit.cover,
                                height: 200,
                              ),
                            );
                          },
                        ).toList(),
                        options: CarouselOptions(
                          viewportFraction: 1,
                          height: 200,
                        ),
                      )
                    : GestureDetector(
                        onTap: selectImages,
                        child: DottedBorder(
                          borderType: BorderType.Rect,
                          radius: const Radius.circular(10),
                          dashPattern: const [10, 4],
                          strokeCap: StrokeCap.round,
                          child: Container(
                            width: double.infinity,
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(children: const [
                              Icon(
                                Icons.folder_open,
                                size: 40,
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                'Select Shop Images',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey,
                                ),
                              ),
                            ]),
                          ),
                        ),
                      ),
                const SizedBox(
                  height: 30,
                ),
                CustomTextField(
                  controller: ownerNameController,
                  hintText: 'Owner Name',
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: shopNameController,
                  hintText: 'Shop Name',
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: avgpriceController,
                  hintText: 'Average price of Your shop',
                ),
                const SizedBox(height: 10),
                TextFieldTags(
                  textSeparators: const [
                    " ", //seperate with space
                    ',' //sepearate with comma as well
                  ],
                  initialTags: tags,
                  onTag: (tag) {
                    tags.add(tag);
                  },
                  onDelete: (tag) {
                    //this will give single tag on delete
                    tags.remove(tag);
                  },
                  validator: (tag) {
                    //add validation for tags
                    if (tag.length < 3) {
                      return "Enter tag up to 3 characters.";
                    }
                    return null;
                  },
                  tagsStyler: TagsStyler(
                      //styling tag style
                      tagTextStyle:
                          const TextStyle(fontWeight: FontWeight.normal),
                      tagDecoration: BoxDecoration(
                        color: Colors.blue[100],
                        borderRadius: BorderRadius.circular(7),
                      ),
                      tagCancelIcon: Icon(Icons.cancel,
                          size: 18.0, color: Colors.blue[900]),
                      tagPadding: const EdgeInsets.all(6.0)),
                  textFieldStyler: TextFieldStyler(
                      //styling tag text field
                      textFieldBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blue, width: 2))),
                ),
                CustomButton(
                  text: 'Add',
                  onTap: () {
                    //user.whichShop = shopNameController.text;
                    createShop();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
