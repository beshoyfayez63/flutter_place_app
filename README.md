# places_app

A Flutter Place App

## Getting Started

This project used native apis plguins like camera, storage, location, google maps
Add your GOOGLE_API_KEY in three places
1- lib/helpers/location_helper.dart ==> const GOOGLE_API_KEY = "";
2- android\app\src\main\AndroidManifest.xml ==> <meta-data android:name="com.google.android.geo.API_KEY" android:value=""/>
3- ios\Runner\AppDelegate.swift ==> GMSServices.provideAPIKey("")
