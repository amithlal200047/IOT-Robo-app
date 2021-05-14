import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_fonts/google_fonts.dart';

class ScreenData extends StatefulWidget {
  @override
  _ScreenDataState createState() => _ScreenDataState();
}

class _ScreenDataState extends State<ScreenData> {
  void sentdata(bool _test) {
    setState(() {
      final dbreferance = FirebaseDatabase.instance.reference();
      _test == true
          ? dbreferance.set({'switch2': 'follow'})
          : dbreferance.set({'switch2': 'control'});
    });
  }

  void sentlockdata(bool _test) {
    setState(() {
      final dbref = FirebaseDatabase.instance.reference();
      _test == true
          ? dbref.set({'lock': 'closed'})
          : dbref.set({'lock': 'open'});
    });
  }

  bool switching = false;
  bool lock = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                  switching == true ? 'assets/robo1.jpg' : 'assets/robo2.jpg'),
              fit: BoxFit.fill),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 450),
                  child: IconButton(
                      icon: Icon(
                        lock == true ? Icons.lock_rounded : Icons.lock_open,
                        color: Colors.white60,
                      ),
                      iconSize: 50,
                      onPressed: () {
                        setState(() {
                          lock == true ? lock = false : lock = true;
                        });
                        sentlockdata(lock);
                      }),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: RaisedButton(
                      color: switching == true
                          ? Colors.blue[800]
                          : Colors.red[900],
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(15.0),
                      ),
                      onPressed: () {
                        switching == true
                            ? switching = false
                            : switching = true;
                        sentdata(switching);
                        switching == true
                            ? print('Following mode ON ')
                            : print('Control mode ON ');
                      },
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                        child: Text(
                          switching == true
                              ? 'Following Mode'
                              : 'Controlling Mode',
                          style: GoogleFonts.novaFlat(
                            fontSize: 20,
                          ),
                        ),
                      )),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
