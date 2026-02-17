import 'package:flutter/material.dart';
import '../models/plant.dart';

class DetailScreen extends StatelessWidget {
  final Plant product;
  final Function(Plant) onAddToCart;

  const DetailScreen({super.key, required this.product, required this.onAddToCart});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // Bitki Görseli (Hero Animasyonu ile)
          Expanded(
            flex: 4,
            child: Hero(
              tag: product.id,
              child: Image.network(product.image, fit: BoxFit.contain),
            ),
          ),
          
          // Detay Paneli
          Expanded(
            flex: 5,
            child: Container(
              padding: const EdgeInsets.fromLTRB(30, 40, 30, 20),
              decoration: const BoxDecoration(
                color: Color(0xFFF1F4F2), // Hafif yeşilimsi gri
                borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(product.name, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                      Text("${product.price} TL", style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: Color(0xFF2D6A4F))),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(product.category, style: TextStyle(color: Colors.grey.shade600, fontSize: 16)),
                  const SizedBox(height: 25),
                  
                  // Bakım Bilgileri Kartları
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildCareCard(Icons.wb_sunny_outlined, "IŞIK", product.light),
                      _buildCareCard(Icons.water_drop_outlined, "SU", product.water),
                      _buildCareCard(Icons.thermostat, "ISI", "18-24°C"),
                    ],
                  ),
                  
                  const SizedBox(height: 30),
                  const Text("Hakkında", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Text(product.description, style: TextStyle(color: Colors.grey.shade700, height: 1.5)),
                  
                  const Spacer(),
                  
                  // Satın Alma Butonu
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2D6A4F),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      ),
                      onPressed: () {
                        onAddToCart(product);
                      },
                      child: const Text("SEPETE EKLE", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Bakım bilgisi için yardımcı widget
  Widget _buildCareCard(IconData icon, String title, String value) {
    return Container(
      width: 100,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Icon(icon, color: const Color(0xFF2D6A4F)),
          const SizedBox(height: 8),
          Text(title, style: const TextStyle(fontSize: 10, color: Colors.grey, fontWeight: FontWeight.bold)),
          Text(value, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}