# Ejemplo

Aquí te muestro un ejemplo de uso de **waiting_dialog** plugin.

### Botón que ejecuta la acción
~~~dart
Future _doLongProcess() async {
	// demoramos 5 segundos
	await Future.delayed(Duration(seconds: 5));
}

void _onPressed() {
	showWaitingDialog(
		context: _key.currentState.overlay.context,
		onWaiting: () async => await _doLongProcess(),
		strokeWidth: 12.0,
		onDone: () {
			// luego de terminada la espera
			// aquí va su código
			print('proceso terminado!');
		});
}

Widget button([String caption]) {
	ThemeData theme = Theme.of(context);
	return RaisedButton(
		onPressed: _onPressed,
		shape: RoundedRectangleBorder(
			borderRadius: BorderRadius.circular(8.0),
		),
		color: theme.primaryColor,
		textColor: theme.dialogBackgroundColor,
		child: Container(
				padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
				child: Text('${caption ?? ""}'),
			),
		);
	}
~~~
![alt image](https://raw.githubusercontent.com/johnmoscoso911/waiting_dialog/master/images/Screenshot_1548853779.png)
### Contenido del widget
~~~dart
var _key = GlobalKey<NavigatorState>();
...
@override
Widget build(BuildContext context) {
	return MaterialApp(
		navigatorKey: _key,
		debugShowCheckedModeBanner: false,
		home: Scaffold(
			appBar: AppBar(
				title: const Text('Waiting dialog example app'),
			),
			body: Center(
				child: Row(
					mainAxisAlignment: MainAxisAlignment.spaceEvenly,
					children: <Widget>[
						button('Button with caption'),
						button('Another button')
					],
				),
			),
		),
	);
}
~~~
### Resultado
[Dialog](https://docs.flutter.io/flutter/material/Dialog-class.html) mostrando un [CircularProgressIndicator](https://docs.flutter.io/flutter/material/CircularProgressIndicator-class.html) mientras procesas una petición.
![alt image](https://raw.githubusercontent.com/johnmoscoso911/waiting_dialog/master/images/Screenshot_1548853785.png)