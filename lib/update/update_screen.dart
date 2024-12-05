import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platzi_store/home/screen/homeScreen.dart';

import 'bloc/update_bloc.dart';

class ProductUpdateScreen extends StatefulWidget {
  final int id;
  const ProductUpdateScreen({super.key, required this.id});

  @override
  State<ProductUpdateScreen> createState() => _ProductUpdateScreenState();
}

class _ProductUpdateScreenState extends State<ProductUpdateScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  final _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Products'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _key,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text(
              'Enter Title',
              style: TextStyle(fontSize: 16, color: Colors.green),
            ),
            const SizedBox(height: 5),
            TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter Title';
                  }
                  return null;
                },
                controller: titleController,
                decoration: InputDecoration(
                    label: const Text('Title'),
                    prefixIcon: const Icon(Icons.title),
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.all(10),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)))),
            const SizedBox(height: 10),
            const Text(
              'Enter Price',
              style: TextStyle(fontSize: 16, color: Colors.green),
            ),
            const SizedBox(height: 5),
            TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Price is empty';
                  }
                  return null;
                },
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    label: const Text('Price'),
                    prefixIcon: const Icon(Icons.price_change_outlined),
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.all(10),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)))),
            const SizedBox(height: 50),
            BlocConsumer<UpdateBloc, UpdateState>(
              listener: (context, state) {
                if (state.status == updatestatus.success) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const HomeScreen()));
                }
              },
              builder: (context, state) {
                return InkWell(
                  onTap: () {
                    if (_key.currentState!.validate()) {
                      context.read<UpdateBloc>().add(UpdateProductEvent(
                          id: widget.id,
                          title: titleController.text,
                          price: priceController.text));
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    child: const Center(child: Text('Update Product')),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.amber),
                  ),
                );
              },
            )

            // const Text(
            //   'Enter Image',
            //   style: TextStyle(fontSize: 16, color: Colors.red),
            // ),
            // const SizedBox(height: 5),
            // SizedBox(
            //     height: 50,
            //     child: TextFormField(
            //         validator: (value) {
            //           if (value!.isEmpty) {
            //             return 'Enter Image';
            //           }
            //           return null;
            //         },
            //         controller: titleController,
            //         decoration: InputDecoration(
            //             label: const Text('Image'),
            //             prefixIcon: const Icon(Icons.picture_in_picture),
            //             fillColor: Colors.white,
            //             border: OutlineInputBorder(
            //                 borderRadius: BorderRadius.circular(20))))),
          ]),
        ),
      ),
    );
  }
}
