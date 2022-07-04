# places_app

A Flutter Place App

## Getting Started

This project used native apis plguins like camera, storage, location, google maps <br/>
Add your GOOGLE_API_KEY in three places <br />
1- lib/helpers/location_helper.dart ==> const GOOGLE_API_KEY = ""; <br />
2- android\app\src\main\AndroidManifest.xml ==> <meta-data android:name="com.google.android.geo.API_KEY" android:value=""/> <br/>
3- ios\Runner\AppDelegate.swift ==> GMSServices.provideAPIKey("")
