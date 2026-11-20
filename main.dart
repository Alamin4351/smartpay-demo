import 'package:flutter/material.dart';

void main() => runApp(const SmartPayApp());

class SmartPayApp extends StatelessWidget {
  const SmartPayApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'SmartPay',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(colorSchemeSeed: const Color(0xFF087F68), useMaterial3: true),
        home: const HomePage(),
      );
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double balance = 1250.00;
  final List<String> history = ['Welcome bonus (demo)  +৳1,000', 'Demo cash in  +৳250'];

  void showDemoAction(String action) {
    final controller = TextEditingController();
    showDialog<void>(context: context, builder: (context) => AlertDialog(
      title: Text(action),
      content: TextField(controller: controller, keyboardType: TextInputType.number,
        decoration: const InputDecoration(labelText: 'Amount (৳)', border: OutlineInputBorder())),
      actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
        FilledButton(onPressed: () {
          final amount = double.tryParse(controller.text);
          if (amount == null || amount <= 0) return;
          setState(() {
            if (action == 'Cash In') balance += amount;
            if (action == 'Cash Out' || action == 'Send Money') balance = (balance - amount).clamp(0, double.infinity);
            history.insert(0, '$action (demo)  ৳${amount.toStringAsFixed(2)}');
          });
          Navigator.pop(context);
          ScaffoldMessenger.of(this.context).showSnackBar(const SnackBar(content: Text('Demo only — no real money moved.')));
        }, child: const Text('Continue'))],
    ));
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('SmartPay'), actions: [IconButton(onPressed: () => showAboutDialog(context: context, applicationName: 'SmartPay Demo', children: const [Text('Prototype only. No real payments or money transfers.')]), icon: const Icon(Icons.info_outline))]),
    body: ListView(padding: const EdgeInsets.all(18), children: [
      Container(padding: const EdgeInsets.all(22), decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary, borderRadius: BorderRadius.circular(20)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text('Available balance', style: TextStyle(color: Colors.white70)), const SizedBox(height: 8), Text('৳${balance.toStringAsFixed(2)}', style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)), const SizedBox(height: 8), const Text('Demo balance only', style: TextStyle(color: Colors.white70))])),
      const SizedBox(height: 20),
      GridView.count(shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), crossAxisCount: 2, crossAxisSpacing: 12, mainAxisSpacing: 12, childAspectRatio: 1.7,
        children: [ _action(Icons.send, 'Send Money'), _action(Icons.add_circle_outline, 'Cash In'), _action(Icons.account_balance_wallet_outlined, 'Cash Out'), _action(Icons.receipt_long, 'History', historyOnly: true)]),
      const SizedBox(height: 22), const Text('Recent transactions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)), const SizedBox(height: 8),
      ...history.map((item) => Card(child: ListTile(leading: const CircleAvatar(child: Icon(Icons.receipt)), title: Text(item), subtitle: const Text('Demo transaction')))),
      const SizedBox(height: 14), const Text('Important: This is a demonstration app. It does not connect to bKash, Nagad, banks, or any payment network. Do not use it to store or transfer real money.', style: TextStyle(color: Colors.red, fontSize: 12)),
    ]),
  );

  Widget _action(IconData icon, String label, {bool historyOnly = false}) => Card(child: InkWell(borderRadius: BorderRadius.circular(12), onTap: () => historyOnly ? showDialog<void>(context: context, builder: (context) => AlertDialog(title: const Text('Transaction history'), content: Text(history.join('\n\n')), actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close'))])) : showDemoAction(label), child: Padding(padding: const EdgeInsets.all(12), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(icon, size: 28), const SizedBox(height: 7), Text(label, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.w600))]))));
}
