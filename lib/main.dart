import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tunisia Travel Wishlist',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        fontFamily: 'Roboto',
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 2; // Wishlist is the active tab

  final Map<String, String> imageDescriptions = {
    'android/app/src/images/image 2.jpg':
        'Perched high above the Mediterranean, this iconic café in Sidi Bou Said offers spectacular sea views, blue umbrellas, and a peaceful vibe. A perfect spot to enjoy mint tea or Turkish coffee while watching the sunset over the marina.',
    'android/app/src/images/image 3.jpg':
        'A postcard-perfect town known for its white-washed walls and blue shutters, Sidi Bou Said is a favorite for artists, musicians, and travelers. Lose yourself in its narrow alleys, boutique shops, and hilltop cafes with sweeping views of the Gulf of Tunis.',
    'android/app/src/images/image 4.jpg':
        'Modern luxury meets the Mediterranean breeze at Gammarth Yacht Club. Located just outside Tunis, this marina is home to upscale restaurants, seaside lounges, and a vibrant nightlife. Ideal for yachting enthusiasts or those seeking a stylish escape.',
    'android/app/src/images/image 5.jpg':
        'Step into history at the El Jem Amphitheater, one of the best-preserved Roman colosseums in the world. Once hosting 35,000 spectators, it\'s a UNESCO World Heritage Site and a breathtaking glimpse into Tunisia’s ancient past.',
    'android/app/src/images/image 6.jpg':
        'Bab Diwan is the historic gate to the medina of Sfax — a living reminder of Tunisia’s fortified cities. Stroll through the old souk, taste authentic street food, and experience the vibrant culture that thrives behind these ancient walls.',
    'android/app/src/images/image 7.jpg':
        'Once the largest Roman baths in Africa, the Baths of Antoninus are a stunning archaeological site along the Carthage coast. Marvel at the ruins, columns, and sea-facing arcades that reflect the grandeur of the Roman Empire.',
    'android/app/src/images/image 8.jpg':
        'Located in Carthage, these ancient ruins tell the story of Roman luxury and engineering. Surrounded by palm trees and sea views, it\'s a must-visit site for history lovers and anyone curious about Tunisia’s Roman heritage.',
  };

  final List<String> imagePaths = [
    'android/app/src/images/image 2.jpg',
    'android/app/src/images/image 3.jpg',
    'android/app/src/images/image 4.jpg',
    'android/app/src/images/image 5.jpg',
    'android/app/src/images/image 6.jpg',
    'android/app/src/images/image 7.jpg',
    'android/app/src/images/image 8.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            // TODO: Implement drawer
          },
        ),
        title: const Text('Wishlist'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: Colors.grey.shade300,
              child: const Icon(Icons.person), // Replace with user profile image
            ),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: imagePaths.length,
        itemBuilder: (context, index) {
          final imagePath = imagePaths[index];
          return WishlistItemCard(
            imagePath: imagePath,
            description: imageDescriptions[imagePath] ?? 'No description',
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Explore'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Wishlist'),
          BottomNavigationBarItem(icon: Icon(Icons.card_travel), label: 'Trip'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

class WishlistItemCard extends StatefulWidget {
  final String imagePath;
  final String description;

  const WishlistItemCard({super.key, required this.imagePath, required this.description});

  @override
  State<WishlistItemCard> createState() => _WishlistItemCardState();
}

class _WishlistItemCardState extends State<WishlistItemCard> {
  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailPage(
                imagePath: widget.imagePath,
                description: widget.description,
              ),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  widget.imagePath,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.imagePath.split('/').last.split('.').first,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            _isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: Colors.teal,
                          ),
                          onPressed: () {
                            setState(() {
                              _isFavorite = !_isFavorite;
                            });
                          },
                        ),
                      ],
                    ),
                    Text(
                      widget.description,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    const Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 16),
                        Text('5.0'),
                      ],
                    ),
                    const Text('9.8 Kms'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  final String imagePath;
  final String description;

  const DetailPage({super.key, required this.imagePath, required this.description});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Details'),
      ),
      body: Column(
        children: [
          Image.asset(imagePath),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              description,
              style: const TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
