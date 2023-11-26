# Reddit-Viewer
Subreddit viewer application made with Flutter for Android devices.
=======

## Description
Reddit-Viewer is an Android application made with Flutter designed to provide the user with a easy to use interface to search and visualize subreddits posts.
It does that by making a http request to the reddit server and translating the json that it responds. 

Android permissions required: INTERNET (for the http requests) and RECORD_AUDIO (for the speech to text plugin).
Min SDK version: 21.

Libraries / Plugins used:
- [http 1.1.0](https://pub.dev/packages/http) - A composable, Future-based library for making HTTP requests.
- [url_launcher 6.1.11](https://pub.dev/packages/url_launcher) - A Flutter plugin for launching a URL.
- [speech_to_text 6.4.1](https://pub.dev/packages/speech_to_text) - A library that exposes device specific speech recognition capability.

## Getting Started

### Instalation

1. Download and open project on Visual Studio Code.
2. Use the terminal to enter command "flutter build apk --release". 
3. Install generated apk on android device.
4. Run the application.

### Using the app

1. Type in the search bar the name of a subreddit using the keyboard, or click on the mic button to speak the subreddit's name.
2. Click on the "Search for subreddit" button, it will load the subreddit's feed page with the Hot posts.
3. To open a post just tap on it.