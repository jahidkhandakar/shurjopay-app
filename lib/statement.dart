import 'package:flutter/material.dart';

class StatementPage extends StatefulWidget {
  const StatementPage({super.key});

  @override
  State<StatementPage> createState() => _StatementPageState();
}

class _StatementPageState extends State<StatementPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Statement', 
          style: TextStyle(
            color: Colors.white,
            fontSize: 35,
            ),
          ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 44, 228, 139),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: const [Tab(text: 'Success'), Tab(text: 'Unsuccessful')],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Success Tab
          ListView.builder(
            itemCount: 10, // Example count
            itemBuilder: (context, index) {
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Color.fromARGB(255, 44, 228, 139),
                    child: Icon(Icons.check, color: Colors.white),
                  ),
                  title: Text('Transaction #${index + 1}'),
                  subtitle: Text('Amount: \$${(index + 1) * 100}'),
                  trailing: Text(
                    'Success',
                    style: TextStyle(
                      color: Colors.green[700],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            },
          ),
          // Unsuccessful Tab
          ListView.builder(
            itemCount: 5, // Example count
            itemBuilder: (context, index) {
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Colors.red,
                    child: Icon(Icons.close, color: Colors.white),
                  ),
                  title: Text('Failed Transaction #${index + 1}'),
                  subtitle: Text('Amount: \$${(index + 1) * 50}'),
                  trailing: Text(
                    'Failed',
                    style: TextStyle(
                      color: Colors.red[700],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
