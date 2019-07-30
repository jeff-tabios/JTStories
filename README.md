# JTStories


Author: Jeffrey Tabios


What is this?
This is a Swift example that displays different articles from NYTimes API.
I have focused on clean, clear and descriptive code and intentionally left the UI simple as those are easy and subject to UI designs. Activity indicators or animations are left out for the purpose of this demo. No 3rd party libraries were used. 
This follows the functionality requirements in the assignment given.


Main Parts:
ListViewController:
- This handles the display of articles in a list and search functionalties.
- Extensions for Table and Search delegates comes with this code and are neatly grouped.
- Search displays last 10 terms
- A simple array storage was used in this example


Image caching:
- Images are cached using an extension functionality


StoriesViewModel:
- This mainly handles transformation of model for presentation


Networking:
- This uses URLSession and identifies errors
- Easy to use and build an api for any endpoint


Mock:
- Features mock data for testing


Unit Testing:
- Sample Unit tests for networking with actual API to check connectivity
- Sample Unit tests for Stories View Model to test for data transformation


This sample combines the following: POP, MVVM, Generics, Decorator, Facade, Mocking, Data binding using closure, Dependency Injection
