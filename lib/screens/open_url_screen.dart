import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import '../widgets/app_drawer.dart';
import '../providers/player_provider.dart';

class OpenURLScreen extends StatefulWidget {
  static const routeName = '/open-url';

  @override
  _OpenURLScreenState createState() => _OpenURLScreenState();
}

class _OpenURLScreenState extends State<OpenURLScreen> {
  PlayerProvider prov;
  bool _isLoading = false;
  bool _isPlaying = false;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    prov = Provider.of<PlayerProvider>(context);
  }

  String url;
  Future<void> openURL() async {
    await prov.setURL(url);
    await prov.play();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Open URL'),
        actions: [
          prov.isPlaying()
              ? IconButton(
                  icon: Icon(Icons.pause),
                  onPressed: () async {
                    await Provider.of<PlayerProvider>(context, listen: false)
                        .pause();
                  })
              : IconButton(
                  icon: Icon(Icons.play_arrow),
                  onPressed: () async {
                    await Provider.of<PlayerProvider>(context, listen: false)
                        .play();
                  }),
        ],
      ),
      drawer: AppDrawer(),
      body: Center(
        child: _isPlaying
            ? SpinKitChasingDots(color: Colors.red)
            : _isLoading
                ? CircularProgressIndicator(
                    backgroundColor: Colors.teal,
                  )
                : Padding(
                    padding: EdgeInsets.all(8),
                    child: Form(
                      child: Row(
                        children: [
                          Expanded(
                            flex: 4,
                            child: TextFormField(
                              // maxLines: 3,
                              // minLines: 1,
                              autofocus: true,

                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(),
                                ),
                                focusColor: Colors.teal,
                                hintText: 'type URL here',
                              ),
                              onChanged: (value) {
                                setState(() {
                                  url = value;
                                });
                              },
                              onFieldSubmitted: (value) async {
                                setState(() {
                                  _isLoading = true;
                                });
                                await openURL();
                                setState(() {
                                  _isLoading = false;
                                  _isPlaying = true;
                                });
                              },
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: IconButton(
                              icon: Icon(
                                Icons.search,
                                color: Colors.teal,
                              ),
                              onPressed: () {
                                openURL();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
      ),
    );
  }
}
