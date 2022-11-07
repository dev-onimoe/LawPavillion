# LawPavillion

This project is a simple three page app with a few network calls and remote data manipulations, programmatic UIKit and a little bit of storyboards were used to implement the user interface and apple's URLSession was used to make network calls. The project's structure is based on the MVVM architecture so a little bit of reactive programming was used by taking advantage of the didSet object observer property. Memory leaks were kept in check as there were no unnecessary object initialiation or strong reference cycles.

The project launches with an intro page and navigates to the main page with the press of a button, to make a name search, input the keyword at the top of the main page and tap on the search icon to make the search, the app automatically makes a network call and returns a list of profiles in an alphabetical order per list, scrolling to the very bottom of the list triggers another batch of names to be added to the existing list.
