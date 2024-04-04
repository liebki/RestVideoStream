# RestVideoStream - Swift App

## Description

This swift app interacts with a self-hosted rest api to fetch and display data for various video content, like a cheap/easy diy VoD-service.

**Note:** I originally wanted to create this for apple tv to not use airplay or something but iOS, iPadOs and macOs also work :)


## Structure/Dependencies [mandatory]

1. RestVideoStream - This swift app which uses a REST API to get data to display
2. [liebki/StreamingUrlFetcherRestServer](https://github.com/liebki/StreamingUrlFetcherRestServer) - The REST API which the swift app calls, it interacts with the cli-tool of AnimDL
3. [justfoolingaround/AnimDL](https://github.com/justfoolingaround/animdl) - This projects allows to get direct links to stream video source from, 


## Features

Simple UI and simple usage, the load times vary and depend on the video source and internet connection etc.


## Installation/Usage
1. Get the projects code, build it for the platform you want, that's it.
2. Change the IP and PORT for the API in the "baseRestServerAddress" variable in ContentView.swift and EpisodeListView.swift


## Screenshots/Video
![GIF](/RestVideoStream/Screenshots/usage-appletv.gif)


## Disclaimer

This project may utilize components allowing access to copyrighted materials (AnimDL). We do not endorse or condone any illegal activities, this project only uses them for testing purposes. Users are responsible for compliance with applicable laws. We disclaim liability for misuse of the project. Please respect copyright laws and the copyright of creators/authors!


## License

This addon is licensed under the [MIT License](https://choosealicense.com/licenses/mit/).

## To-Do
- Add more sources for video material, this counts for the API and the swift app
