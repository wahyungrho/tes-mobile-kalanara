import 'package:flutter/material.dart';

/* Contoh Buggy Code
class BuggyCounterPage extends StatefulWidget {
  const BuggyCounterPage({super.key});

  @override
  State<BuggyCounterPage> createState() => _BuggyCounterPageState();
}

class _BuggyCounterPageState extends State<BuggyCounterPage> {
  int counter = 0;

  @override
  void initState() {
    super.initState();
    increaseCounter();
  }

  void increaseCounter() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Counter: $counter'),
    );
  }
}

Apa yang Salah?
- Context: setState() dipanggil setelah dispose() karena Future.delayed() nunggu 2 detik. Kalau user cepat pindah halaman, ini bisa error.
- Center dipakai langsung tanpa Scaffold → gak ada Material tree → gak bisa tambah fitur Material (AppBar, FloatingActionButton, dll).


Versi Sudah Diperbaiki:
class SafeCounterPage extends StatefulWidget {
  const SafeCounterPage({super.key});

  @override
  State<SafeCounterPage> createState() => _SafeCounterPageState();
}

class _SafeCounterPageState extends State<SafeCounterPage> {
  int counter = 0;
  bool _isMounted = true;

  @override
  void initState() {
    super.initState();
    increaseCounter();
  }

  @override
  void dispose() {
    _isMounted = false;
    super.dispose();
  }

  void increaseCounter() async {
    await Future.delayed(Duration(seconds: 2));
    if (_isMounted) {
      setState(() {
        counter++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Safe Counter')),
      body: Center(
        child: Text('Counter: $counter'),
      ),
    );
  }
}

Code Smell (code yang berpotensi jadi bug di masa depan)
- Delay logic dan setState() harus dicek state-nya dulu sebelum diubah.
- Bisa bikin reusable MountedStateMixin kalau pattern ini sering dipakai.
- Tambahkan tombol untuk uji manual (onPressed) biar bisa test lebih jelas. */

class HomeDebuggingReviewPage extends StatelessWidget {
  const HomeDebuggingReviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Debugging Review')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Text(
            'Contoh Buggy Code',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset('assets/code_buggy.png', fit: BoxFit.cover),
          ),
          SizedBox(height: 16),
          Text(
            'Apa yang Salah?',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          SizedBox(height: 16),
          Text(
            '- Context: setState() dipanggil setelah dispose() karena Future.delayed() nunggu 2 detik. Kalau user cepat pindah halaman, ini bisa error.\n'
            '- Center dipakai langsung tanpa Scaffold → gak ada Material tree → gak bisa tambah fitur Material (AppBar, FloatingActionButton, dll).',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          SizedBox(height: 16),
          Text(
            'Versi Sudah Diperbaiki',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset('assets/code_fix.png', fit: BoxFit.cover),
          ),
          SizedBox(height: 16),
          Text('Code Smell', style: Theme.of(context).textTheme.headlineMedium),
          SizedBox(height: 16),
          Text(
            '- Delay logic dan setState() harus dicek state-nya dulu sebelum diubah.\n'
            '- Bisa bikin reusable MountedStateMixin kalau pattern ini sering dipakai.\n'
            '- Tambahkan tombol untuk uji manual (onPressed) biar bisa test lebih jelas.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}
