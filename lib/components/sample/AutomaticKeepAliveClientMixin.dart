import 'package:flutter/material.dart';

class KeepAliveClient extends StatefulWidget {
  final Widget child;
  const KeepAliveClient({required this.child, super.key});

  @override
  State<KeepAliveClient> createState() => _KeepAliveClientState();
}

class _KeepAliveClientState extends State<KeepAliveClient> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }

  @override
  bool get wantKeepAlive => true;
}