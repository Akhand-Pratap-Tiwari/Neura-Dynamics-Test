import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/product_controller.dart';
import '../../data/models/product.dart';
import '../widgets/product_card.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProductController>(context, listen: false).fetchProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
      ),
      body: Consumer<ProductController>(
        builder: (context, productController, child) {
          if (productController.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (productController.error != null) {
            return Center(child: Text('Error: ${productController.error}'));
          } else {
            ValueNotifier<Map<String, bool>> activeCategories = ValueNotifier(
                {for (String item in productController.categories) item: true});
            return ValueListenableBuilder(
              valueListenable: activeCategories,
              builder: (context, ac, child) {
                List<Product> filteredItems = productController.products
                    .where((element) => ac[element.category.name] ?? false)
                    .toList();

                return Stack(
                  children: [
                    ListView.builder(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 56),
                      itemCount: filteredItems.length,
                      itemBuilder: (context, index) {
                        return ProductCard(product: filteredItems[index]);
                      },
                    ),
                    CategorySelector(
                        categoryList: productController.categories,
                        onSelectionChanged: (categoryChanged) {
                          activeCategories.value[categoryChanged] = !(activeCategories.value[categoryChanged] ?? true);
                          activeCategories.notifyListeners();
                        }),
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }
}

class CategorySelector extends StatefulWidget {
  final List<String> categoryList;
  final Function(String) onSelectionChanged;
  const CategorySelector({
    super.key,
    required this.onSelectionChanged,
    required this.categoryList,
  });

  @override
  State<CategorySelector> createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.loose(const Size.fromHeight(60)),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        color: Colors.deepPurple.shade50,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: ColorChangeButton(
                category: widget.categoryList[index],
                onPressed: () =>
                    widget.onSelectionChanged(widget.categoryList[index])),
          ),
          itemCount: widget.categoryList.length,
        ),
      ),
    );
  }
}

class ColorChangeButton extends StatefulWidget {
  const ColorChangeButton({
    super.key,
    required this.category,
    required this.onPressed,
  });
  final void Function() onPressed;
  final String category;

  @override
  State<ColorChangeButton> createState() => _ColorChangeButtonState();
}

class _ColorChangeButtonState extends State<ColorChangeButton> {
  Color bgColor = Colors.deepPurple.shade300;
  Color fgColor = Colors.white;
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        backgroundColor: bgColor,
        foregroundColor: fgColor,
        side: const BorderSide(width: 2.0),
      ),
      onPressed: () => setState(() {
        bgColor =
            bgColor == Colors.white ? Colors.deepPurple.shade300 : Colors.white;
        fgColor = fgColor == Colors.deepPurpleAccent
            ? Colors.white
            : Colors.deepPurpleAccent;
        widget.onPressed();
      }),
      child: Text(widget.category),
    );
  }
}
