import 'package:flutter/material.dart';

class ProductReviewsPage extends StatefulWidget {
  final Map<String, dynamic> product;

  const ProductReviewsPage({Key? key, required this.product}) : super(key: key);

  @override
  _ProductReviewsPageState createState() => _ProductReviewsPageState();
}

class _ProductReviewsPageState extends State<ProductReviewsPage> {
  final List<Map<String, dynamic>> _reviews = [
    {
      'user': 'John Doe',
      'rating': 4,
      'comment': 'Great product, very satisfied!'
    },
    {
      'user': 'Jane Smith',
      'rating': 5,
      'comment': 'Excellent quality and fast delivery.'
    },
    {
      'user': 'Bob Johnson',
      'rating': 3,
      'comment': 'Good product, but a bit pricey.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.product['name']} Ratings'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _reviews.length,
              itemBuilder: (context, index) {
                final review = _reviews[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                review['user'] as String,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Row(
                              children: [
                                const Icon(Icons.star,
                                    color: Colors.amber, size: 18),
                                Text('${review['rating']}/5'),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(review['comment'] as String),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: () {
                _showAddReviewDialog(context);
              },
              child: const Text('Add Your Rating'),
            ),
          ),
        ],
      ),
    );
  }

  void _showAddReviewDialog(BuildContext context) {
    int rating = 0;
    String comment = '';
    final commentController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              contentPadding: const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 0.0),
              title: const Text('Add Your Rating'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Rating:'),
                    Wrap(
                      alignment: WrapAlignment.center,
                      children: List.generate(5, (index) {
                        return IconButton(
                          constraints: BoxConstraints.tight(const Size(40, 40)),
                          icon: Icon(
                            index < rating ? Icons.star : Icons.star_border,
                            color: Colors.amber,
                          ),
                          onPressed: () {
                            setState(() {
                              rating = index + 1;
                            });
                          },
                        );
                      }),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: commentController,
                      decoration: const InputDecoration(
                        labelText: 'Comment',
                        hintText: 'Write your review here',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 3,
                      onChanged: (value) {
                        comment = value;
                      },
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                ElevatedButton(
                  child: const Text('Submit'),
                  onPressed: () {
                    if (rating > 0 && comment.isNotEmpty) {
                      setState(() {
                        _reviews.add({
                          'user': 'You',
                          'rating': rating,
                          'comment': comment,
                        });
                      });
                      Navigator.of(context).pop();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text(
                                'Please provide both a rating and a comment')),
                      );
                    }
                  },
                ),
              ],
            );
          },
        );
      },
    ).then((_) {
      commentController.dispose();
    });
  }
}
