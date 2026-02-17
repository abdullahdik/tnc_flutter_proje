import 'dart:convert';
import 'package:flutter/material.dart';
import '../models/plant.dart';
import '../models/cart_item.dart';
import 'cart_screen.dart';
import 'detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Plant> allPlants = [];
  List<Plant> filteredPlants = [];
  List<CartItem> cartItems = [];

  @override
  void initState() {
    super.initState();
    _loadPlants();
  }

  void _loadPlants() {
    final List<dynamic> decodedData = json.decode(plantDataJson);
    setState(() {
      allPlants = decodedData.map((item) => Plant.fromJson(item)).toList();
      filteredPlants = allPlants;
    });
  }

  void _filterPlants(String query) {
    setState(() {
      filteredPlants = allPlants
          .where((p) => p.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _addToCart(Plant plant) {
    setState(() {
      final index = cartItems.indexWhere((item) => item.plant.id == plant.id);
      if (index >= 0) {
        cartItems[index].quantity++;
      } else {
        cartItems.add(CartItem(plant: plant));
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("${plant.name} sepete eklendi"),
        duration: const Duration(milliseconds: 800),
        behavior: SnackBarBehavior.floating,
        backgroundColor: const Color(0xFF2D6A4F),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text("GREENY", style: TextStyle(letterSpacing: 2, fontWeight: FontWeight.w900)),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart_outlined, size: 28),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CartScreen(cartItems: cartItems)),
                ),
              ),
              if (cartItems.isNotEmpty)
                Positioned(
                  right: 5,
                  top: 5,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                    child: Text("${cartItems.length}", style: const TextStyle(color: Colors.white, fontSize: 10)),
                  ),
                )
            ],
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(20),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.65,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
              ),
              itemCount: filteredPlants.length,
              itemBuilder: (context, index) => _buildPlantCard(filteredPlants[index]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10)],
        ),
        child: TextField(
          onChanged: _filterPlants,
          decoration: const InputDecoration(
            hintText: "En sevdiğin bitkiyi bul...",
            prefixIcon: Icon(Icons.search, color: Color(0xFF2D6A4F)),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(vertical: 15),
          ),
        ),
      ),
    );
  }

  Widget _buildPlantCard(Plant plant) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, 5))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                GestureDetector(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreen(product: plant, onAddToCart: _addToCart))),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
                    child: Image.network(
                      plant.image, 
                      width: double.infinity, 
                      fit: BoxFit.cover,
                      errorBuilder: (c, e, s) => const Center(child: Icon(Icons.broken_image)),
                    ),
                  ),
                ),
                Positioned(
                  right: 12,
                  bottom: 12,
                  child: GestureDetector(
                    onTap: () => _addToCart(plant),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(color: Color(0xFF2D6A4F), shape: BoxShape.circle),
                      child: const Icon(Icons.add, color: Colors.white, size: 20),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(plant.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16), maxLines: 1, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 5),
                Text("${plant.price} TL", style: const TextStyle(color: Color(0xFF2D6A4F), fontWeight: FontWeight.w900, fontSize: 18)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

const String plantDataJson = '''
[
  {
    "id": "1",
    "name": "Monstera Deliciosa",
    "description": "Dev deve tabanı, geniş ve delikli yapraklar.",
    "price": 540.0,
    "image": "https://images.unsplash.com/photo-1614594975525-e45190c55d0b?w=500",
    "category": "İç Mekan",
    "light": "Yarı Gölge",
    "water": "Haftada 1"
  },
  {
    "id": "2",
    "name": "Peygamber Kılıcı",
    "description": "Bakımı kolay, gece boyu oksijen üretir.",
    "price": 280.0,
    "image": "https://images.unsplash.com/photo-1596547609652-9cf5d8d76921?w=500",
    "category": "Ofis",
    "light": "Düşük Işık",
    "water": "2 Haftada 1"
  },
  {
    "id": "3",
    "name": "Aloe Vera",
    "description": "Şifalı jel yapraklar, güneşli ortamı sever.",
    "price": 150.0,
    "image": "https://cdn.myikas.com/images/0a0610ea-f6f2-4606-925e-36f4f292e2a5/01e8b64b-f3fe-4345-8e23-05651115687e/2560/img-1312.webp",
    "category": "Dış Mekan",
    "light": "Tam Güneş",
    "water": "10 Günde 1"
  },
  {
    "id": "4",
    "name": "Barış Çiçeği",
    "description": "Zarif beyaz çiçekler, havayı temizler.",
    "price": 320.0,
    "image": "https://cdn2.ikost.com/3117/urunler/902.jpg",
    "category": "İç Mekan",
    "light": "Dolaylı Işık",
    "water": "Haftada 2"
  }
]
''';