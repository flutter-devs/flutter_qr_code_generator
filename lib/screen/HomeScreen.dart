import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  String _content = null;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  TextEditingController _controller = new TextEditingController();

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xFFF6F8FA),
      appBar: AppBar(
        elevation: 0.1, // Check Platform if android
        backgroundColor: const Color(0xFFF6F8FA),
        title: new Center(
          child: new Text(
            'QR GENERATOR',
            style: TextStyle(
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      body: Container(
        color: const Color(0xFFF6F8FA),
        margin: EdgeInsets.only(top: 20.0, left: 30.0, right: 30.0),
        child: ListView(
          children: <Widget>[
            Center(
              child: Container(
                height: 220.0,
                decoration: new BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.white,
                  borderRadius: new BorderRadius.all(
                    new Radius.circular(16.0),
                  ),
                ),
                child: Center(
                  child: _content != null ? _getGeneratedQR() : _getDummyQR(),
                ),
              ),
            ),
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 10.0),
                width: double.infinity,
                child: new TextField(
                  controller: _controller,
                  decoration: new InputDecoration(
                      border: new OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(35.0),
                        ),
                      ),
                      filled: true,
                      hintText: "Enter text to generate",
                      fillColor: Colors.white70),
                ),
              ),
            ),
            InkWell(
              onTap: () => _generateQR(),
              child: new Center(
                child: Container(
                  margin: EdgeInsets.only(top: 30.0),
                  width: 180.0,
                  height: 48.0,
                  decoration: new BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.red,
                    borderRadius: new BorderRadius.all(
                      new Radius.circular(24.0),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'GENERATE',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getGeneratedQR() {
    return new QrImage(
      data: _content,
      size: 200.0,
      onError: (ex) {
        print("QR ERROR - $ex");
        setState(() {
           showSnackBar('Error: May be your input value is too long');
        });
      },
    );
  }

  Widget _getDummyQR() {
    return new Opacity(
      opacity: 0.5,
      child: Image.asset(
        'assets/images/ic_scan.png',
        width: 140.0,
        height: 140.0,
        fit: BoxFit.cover,
      ),
    );
  }

  void showSnackBar(String message) {
    final snackBar = SnackBar(
      content: Text(message),
      action: SnackBarAction(
        label: 'OK',
        onPressed: () {},
      ),
    );

    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  void _generateQR() {
    //print(_controller.text);
    _content = _controller.text;
    if (_content == '') {
      _content = null;
      showSnackBar('Please enter text to generate QR');
    }
    setState(() {});
  }
}
