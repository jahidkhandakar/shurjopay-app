import 'package:flutter/material.dart';

class CardPage extends StatefulWidget {
  const CardPage({super.key});

  @override
  State<CardPage> createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  // Sample card data - replace with your actual card data
  List<Map<String, dynamic>> savedCards = [
    {
      'cardType': 'Credit Card',
      'cardNumber': '**** **** **** 1234',
      'cardHolder': 'John Doe',
      'expiryDate': '12/25',
      'cardColor': Colors.blue[600],
      'cardLogo': 'assets/images/visa.png',
    },
    {
      'cardType': 'Debit Card',
      'cardNumber': '**** **** **** 5678',
      'cardHolder': 'John Doe',
      'expiryDate': '09/24',
      'cardColor': Colors.orange[600],
      'cardLogo': 'assets/images/master.png',
    },
  ];

  final _formKey = GlobalKey<FormState>();
  final _cardHolderController = TextEditingController();
  final _cardNumberController = TextEditingController();
  final _expiryDateController = TextEditingController();
  Color _selectedCardColor = Colors.blue[600]!;
  String _selectedCardLogo = 'assets/images/visa.png';

  void _showCardTypeSelection() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Card Type'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Image.asset(
                  'assets/images/visa.png',
                  height: 40,
                  width: 60,
                  fit: BoxFit.contain,
                ),
                title: const Text('Visa Card'),
                onTap: () {
                  Navigator.pop(context);
                  _selectedCardLogo = 'assets/images/visa.png';
                  _selectedCardColor = Colors.blue[600]!;
                  _showCardDetailsForm();
                },
              ),
              const Divider(),
              ListTile(
                leading: Image.asset(
                  'assets/images/master.png',
                  height: 40,
                  width: 60,
                  fit: BoxFit.contain,
                ),
                title: const Text('Mastercard'),
                onTap: () {
                  Navigator.pop(context);
                  _selectedCardLogo = 'assets/images/master.png';
                  _selectedCardColor = Colors.orange[600]!;
                  _showCardDetailsForm();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showCardDetailsForm() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add New Card'),
          content: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: _cardHolderController,
                    decoration: const InputDecoration(
                      labelText: 'Card Holder Name',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter card holder name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _cardNumberController,
                    decoration: const InputDecoration(
                      labelText: 'Card Number',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    maxLength: 16,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter card number';
                      }
                      if (value.length != 16) {
                        return 'Card number must be 16 digits';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _expiryDateController,
                    decoration: const InputDecoration(
                      labelText: 'Expiry Date (MM/YY)',
                      border: OutlineInputBorder(),
                    ),
                    maxLength: 5,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter expiry date';
                      }
                      if (!RegExp(r'^\d{2}/\d{2}$').hasMatch(value)) {
                        return 'Enter valid expiry date (MM/YY)';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // Add new card
                  setState(() {
                    savedCards.add({
                      'cardType':
                          _selectedCardLogo.contains('visa')
                              ? 'Visa Card'
                              : 'Mastercard',
                      'cardNumber':
                          '**** **** **** ${_cardNumberController.text.substring(12)}',
                      'cardHolder': _cardHolderController.text,
                      'expiryDate': _expiryDateController.text,
                      'cardColor': _selectedCardColor,
                      'cardLogo': _selectedCardLogo,
                    });
                  });

                  // Clear controllers
                  _cardHolderController.clear();
                  _cardNumberController.clear();
                  _expiryDateController.clear();

                  Navigator.of(context).pop();
                }
              },
              child: const Text('Add Card'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Saved Cards',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
            fontStyle: FontStyle.italic,
          ),
        ),
        elevation: 5,
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      backgroundColor: Colors.white,
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: savedCards.length,
        itemBuilder: (context, index) {
          final card = savedCards[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: LinearGradient(
                  colors: [
                    card['cardColor'],
                    card['cardColor'].withOpacity(0.8),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          card['cardType'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Image.asset(
                          card['cardLogo'],
                          height: 50,
                          width: 80,
                          fit: BoxFit.contain,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      card['cardNumber'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        letterSpacing: 2,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Card Holder',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              card['cardHolder'],
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Expires',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              card['expiryDate'],
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showCardTypeSelection,
        backgroundColor: Colors.green[300],
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  @override
  void dispose() {
    _cardHolderController.dispose();
    _cardNumberController.dispose();
    _expiryDateController.dispose();
    super.dispose();
  }
}
