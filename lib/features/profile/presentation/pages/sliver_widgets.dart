import 'package:flutter/material.dart';

class SliverExamples extends StatelessWidget {
  const SliverExamples({super.key});

  @override
  Widget build(BuildContext context) {
    final sliverExamples = [
      // ✅ Example 1: Basic Sliver (Header + List)
      CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(16),
              color: Colors.blue,
              child: const Text(
                "This is a normal widget",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return ListTile(title: Text("Item $index"));
            }, childCount: 20),
          ),
        ],
      ),
      // ✅ Example 2: SliverAppBar (Collapsing Header)
      CustomScrollView(
        slivers: [
          SliverAppBar(
            title: const Text("Sliver AppBar"),
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(color: Colors.orange),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (_, i) => ListTile(title: Text("Item $i")),
              childCount: 30,
            ),
          ),
        ],
      ),
      //✅ Example 3: Sticky Header (SliverPersistentHeader)
      CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: GlassHeaderDelegate(), // SimpleHeaderDelegate(),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (_, i) => ListTile(title: Text("Chat $i")),
              childCount: 25,
            ),
          ),
        ],
      ),
      //✅ Example 4: SliverGrid (Instagram-style grid)
      CustomScrollView(
        slivers: [
          SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (_, i) => Container(
                margin: const EdgeInsets.all(2),
                color: Colors.grey[300],
              ),
              childCount: 30,
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
          ),
        ],
      ),
      // ✅ Example 5: SliverFillRemaining (Empty / Error state)
      CustomScrollView(
        slivers: [
          SliverAppBar(title: const Text("Empty State"), pinned: true),

          SliverFillRemaining(
            child: Center(
              child: Text(
                "No data available",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
          ),
        ],
      ),
      // ✅ Example 6: SliverAnimatedList (Dynamic List)
      SliverAnimatedListExample(),
      //🌟 1️⃣ SliverAppBar (Stretch + Parallax) – VERY BEAUTIFUL
      CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            stretch: true,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text("Beautiful Header"),
              stretchModes: const [
                StretchMode.zoomBackground,
                StretchMode.blurBackground,
              ],
              background: Image.network(
                "https://picsum.photos/600/400",
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverList.builder(
            itemCount: 20,
            itemBuilder: (_, i) => ListTile(title: Text("Item $i")),
          ),
        ],
      ),
      OverlayDropdownExample(),
      //🌟 2️⃣ Sliver with NestedScrollView
      NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Container(
                    height: 200,
                    color: Colors.blue,
                    child: Text("Profile Info"),
                  ),
                ],
              ),
            ),
          ];
        },
        body: Column(
          children: [
            Container(height: 50, color: Colors.red, child: Text("Header")),
            Expanded(
              child: ListView.builder(
                itemBuilder: (c, i) => ListTile(title: Text("Item $i")),
                itemCount: 50,
              ),
            ),
          ],
        ),
      ),
    ];
    return sliverExamples[7];
  }
}

class SimpleHeaderDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(context, shrinkOffset, overlapsContent) {
    return Container(
      color: Colors.green,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.all(16),
      child: const Text(
        "Sticky Header",
        style: TextStyle(color: Colors.white, fontSize: 18),
      ),
    );
  }

  @override
  double get maxExtent => 60;

  @override
  double get minExtent => 60;

  @override
  bool shouldRebuild(_) => false;
}

class GlassHeaderDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(context, shrinkOffset, overlapsContent) {
    final opacity = shrinkOffset / maxExtent;

    return Container(
      color: Colors.white.withOpacity(0.9 - opacity),
      alignment: Alignment.center,
      child: const Text("Sticky Section", style: TextStyle(fontSize: 18)),
    );
  }

  @override
  double get maxExtent => 80;
  @override
  double get minExtent => 60;
  @override
  bool shouldRebuild(_) => true;
}

class SliverAnimatedListExample extends StatefulWidget {
  const SliverAnimatedListExample({super.key});

  @override
  State<SliverAnimatedListExample> createState() =>
      _SliverAnimatedListExampleState();
}

class _SliverAnimatedListExampleState extends State<SliverAnimatedListExample> {
  final GlobalKey<SliverAnimatedListState> _listKey =
      GlobalKey<SliverAnimatedListState>();

  final List<int> _items = [];
  int _counter = 0;

  void _addItem() {
    _items.insert(0, _counter++);
    _listKey.currentState?.insertItem(
      0,
      duration: const Duration(milliseconds: 300),
    );
  }

  void _removeItem(int index) {
    final removedItem = _items.removeAt(index);

    _listKey.currentState?.removeItem(index, (context, animation) {
      return SizeTransition(
        sizeFactor: animation,
        child: ListTile(
          tileColor: Colors.red[100],
          title: Text("Item $removedItem"),
        ),
      );
    }, duration: const Duration(milliseconds: 300));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SliverAnimatedList"),
        actions: [IconButton(icon: const Icon(Icons.add), onPressed: _addItem)],
      ),
      body: CustomScrollView(
        slivers: [
          SliverAnimatedList(
            key: _listKey,
            initialItemCount: _items.length,
            itemBuilder: (context, index, animation) {
              return SizeTransition(
                sizeFactor: animation,
                child: ListTile(
                  title: Text("Item ${_items[index]}"),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => _removeItem(index),
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

class OverlayDropdownExample extends StatefulWidget {
  const OverlayDropdownExample({super.key});

  @override
  State<OverlayDropdownExample> createState() => _OverlayDropdownExampleState();
}

class _OverlayDropdownExampleState extends State<OverlayDropdownExample> {
  final LayerLink _link = LayerLink();
  OverlayEntry? _entry;

  void _showDropdown() {
    _entry = OverlayEntry(
      builder: (_) => Positioned(
        width: 200,
        child: CompositedTransformFollower(
          link: _link,
          offset: const Offset(0, 50),
          showWhenUnlinked: false,
          child: Material(
            elevation: 4,
            child: ListView(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              children: const [
                ListTile(title: Text('Option 1')),
                ListTile(title: Text('Option 2')),
                ListTile(title: Text('Option 3')),
              ],
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_entry!);
  }

  void _hideDropdown() {
    _entry?.remove();
    _entry = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Overlay Dropdown')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: CompositedTransformTarget(
                link: _link,
                child: ElevatedButton(
                  onPressed: () {
                    _entry == null ? _showDropdown() : _hideDropdown();
                  },
                  child: const Text('Open Dropdown'),
                ),
              ),
            ),
            ...List.generate(60, (i) => ListTile(title: Text("Item $i"))),
          ],
        ),
      ),
    );
  }
}
