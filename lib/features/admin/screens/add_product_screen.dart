import 'dart:io';

import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/common/widgets/custom_text_field.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/features/admin/services/admin_services.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class AddProductScreen extends StatefulWidget {
  static const routeName = '/add-product';
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final AdminServices _adminServices = AdminServices();
  final _productFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _productNameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _quantityController.dispose();
  }

  String category = 'Mobiles';

  List<String> productCategories = [
    'Mobiles',
    'Essentials',
    'Appliances',
    'Books',
    'Fashion'
  ];

  List<File> images = [];
  void selectImages() async {
    var res = await pickImages();
    setState(() {
      images = res;
    });
  }

  void addProduct(){
    if(_productFormKey.currentState!.validate() && images.isNotEmpty){
      _adminServices.addProduct(context: context, name: _productNameController.text, description: _descriptionController.text, price: int.parse(_priceController.text), quantity: int.parse(_quantityController.text), category: category, images: images);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppBar(
              flexibleSpace: Container(
                decoration: const BoxDecoration(
                    gradient: GlobalVariables.appBarGradient),
              ),
              title: const Text(
                'Add Product',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ))),
      body: SingleChildScrollView(
        child: Form(
          key: _productFormKey,
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10).copyWith(top: 20),
          child: Column(
            children: [
              GestureDetector(
                onTap: selectImages,
                child: images.isNotEmpty
                    ? CarouselSlider(
                        items: images.map(
                          (i) {
                            return Image.file(
                              i,
                              fit: BoxFit.cover,
                            );
                          },
                        ).toList(),
                        options: CarouselOptions(
                          viewportFraction: 1,
                          height: 250,
                          autoPlay: true,
                        ),
                      )
                    : DottedBorder(
                        borderType: BorderType.RRect,
                        radius: const Radius.circular(10),
                        dashPattern: const [10, 4],
                        strokeCap: StrokeCap.round,
                        child: Container(
                          width: double.infinity,
                          height: 150,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.folder_open,
                                size: 40,
                              ),
                              const SizedBox(height: 15),
                              Text(
                                'Select Product Images',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey.shade400,
                                ),
                              )
                            ],
                          ),
                        )),
              ),
              const SizedBox(height: 30),
              CustomTextField(
                  controller: _productNameController, hintText: 'Product Name'),
              const SizedBox(height: 10),
              CustomTextField(
                controller: _descriptionController,
                hintText: 'Description',
                maxLines: 7,
              ),
              const SizedBox(height: 10),
              CustomTextField(
                controller: _priceController,
                hintText: 'Price',
              ),
              const SizedBox(height: 10),
              CustomTextField(
                controller: _quantityController,
                hintText: 'Quantity',
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: DropdownButton(
                  items: productCategories.map((String item) {
                    return DropdownMenuItem(
                      value: item,
                      child: Text(item),
                    );
                  }).toList(),
                  value: category,
                  onChanged: (newValue) {
                    setState(() {
                      category = newValue!;
                    });
                  },
                ),
              ),
              CustomButton(buttonText: 'Add Product', onPressed: (){
                addProduct();
              })
            ],
          ),
        )),
      ),
    );
  }
}
