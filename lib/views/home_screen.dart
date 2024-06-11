import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}
class HomePageState extends State<HomePage> {
  late int _selectedIndex;
  static const List<String> _apiUrls = [
    'https://fakestoreapi.com/products',
    'https://fakestoreapi.com/products',
    'https://fakestoreapi.com/products'
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex = 0;
    Provider.of<ProductController>(context, listen: false).fetchProducts(_apiUrls[_selectedIndex]);
  }
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Provider.of<ProductController>(context, listen: false).fetchProducts(_apiUrls[_selectedIndex]);
  }
  @override
  Widget build(BuildContext context) {
    print('building');
    return Scaffold(
      appBar: AppBar(title: Text('Home'),),
      body: Consumer<ProductController>(
        builder: (context, productController, _) {
          print('length is  ${productController.products.length}');
          if (productController.products.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return GridView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: productController.products.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, mainAxisSpacing: 5,crossAxisSpacing: 5,
                    childAspectRatio: .8
                ), itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      color: Colors.grey,
                      child: Column(
                        children: [
                          Expanded(child: Image.network(productController.products[index].image!, fit: BoxFit.cover,)),
                          Text(productController.products[index].price!.toString(), style: TextStyle(fontSize: 18),),
                        ],
                      ),
                    ),
                  );
                },);
          }
        },
      ),
      // Image(image: NetworkImage(productController.products[index].image!)),
      // Text(productController.products[index].description!),
      // Text(productController.products[index].category!),
      // Text(productController.products[index].price!.toString()),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.electric_bolt),
            label: 'Electric Products',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Business',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'School',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}