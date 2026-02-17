import 'package:flutter/material.dart';
import '../models/cart_item.dart';

class CartScreen extends StatefulWidget {
  final List<CartItem> cartItems;

  const CartScreen({super.key, required this.cartItems});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  double get total => widget.cartItems.fold(0, (sum, item) => sum + (item.plant.price * item.quantity));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("SEPETİM")),
      body: widget.cartItems.isEmpty 
        ? const Center(child: Text("Sepetiniz boş 🌵"))
        : Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: widget.cartItems.length,
                  itemBuilder: (context, index) {
                    final item = widget.cartItems[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: ListTile(
                        leading: Image.network(item.plant.image, width: 50),
                        title: Text(item.plant.name),
                        subtitle: Text("${item.plant.price} TL"),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove),
                              onPressed: () => setState(() {
                                if (item.quantity > 1) item.quantity--;
                              }),
                            ),
                            Text("${item.quantity}"),
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () => setState(() => item.quantity++),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              _buildCheckoutSection(),
            ],
          ),
    );
  }

  Widget _buildCheckoutSection() {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Toplam:", style: TextStyle(fontSize: 18)),
              Text("${total.toStringAsFixed(2)} TL", style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF2D6A4F))),
            ],
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 55),
              backgroundColor: const Color(0xFF2D6A4F),
            ),
            onPressed: () {}, 
            child: const Text("ÖDEMEYE GEÇ", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}