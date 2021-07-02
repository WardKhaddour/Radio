import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../constatnts.dart';
import '../services/player.dart';
import '../widgets/appbar_flexible_space.dart';

class OpenURLScreen extends StatefulWidget {
  static const routeName = '/open-url';

  @override
  _OpenURLScreenState createState() => _OpenURLScreenState();
}

class _OpenURLScreenState extends State<OpenURLScreen> {
  bool _isLoading = false;
  bool _isPlaying = false;

  String _url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        flexibleSpace: AppBarFlexibleSpace(),
        title: Text('Open URL'),
        // actions: [
        //   prov.isPlaying()
        //       ? IconButton(
        //           icon: Icon(Icons.pause),
        //           onPressed: () async {
        //             await Provider.of<PlayerProvider>(context, listen: false)
        //                 .pause();
        //           })
        //       : IconButton(
        //           icon: Icon(Icons.play_arrow),
        //           onPressed: () async {
        //             await Provider.of<PlayerProvider>(context, listen: false)
        //                 .play();
        //           }),
        // ],
      ),
      // drawer: AppDrawer(),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(background),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: _isPlaying
              ? SpinKitChasingDots(color: Colors.red)
              : _isLoading
                  ? CircularProgressIndicator(
                      backgroundColor: Theme.of(context).primaryColor,
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
                                  focusColor: Theme.of(context).primaryColor,
                                  hintText: 'type URL here',
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    _url = value;
                                  });
                                },
                                onFieldSubmitted: (value) async {
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  await Player.play(_url);
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
                                  color: Theme.of(context).primaryColor,
                                ),
                                onPressed: () async {
                                  await Player.play(_url);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
        ),
      ),
    );
  }
}
