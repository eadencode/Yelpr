# Project 2 - *Yelpr*

**Yelpr ** is a Yelp search app using the [Yelp API](http://www.yelp.com/developers/documentation/v2/search_api).

Time spent: ** ~18** hours spent in total

## User Stories

The following **required** functionality is completed:

- [x] Search results page
   - [x] Table rows should be dynamic height according to the content height.
   - [x] Custom cells should have the proper Auto Layout constraints.
   - [x] Search bar should be in the navigation bar (doesn't have to expand to show location like the real Yelp app does).
   - [x] Filter page. Unfortunately, not all the filters are supported in the Yelp API.
   - [x] The filters you should actually have are: category, sort (best match, distance, highest rated), distance, deals (on/off).
   - [x] The filters table should be organized into sections as in the mock.
   - [x] You can use the default UISwitch for on/off states.
   - [x] Clicking on the "Search" button should dismiss the filters page and trigger the search w/ the new filter settings.
   - [x] Display some of the available Yelp categories (choose any 3-4 that you want).

The following **optional** features are implemented:

- [x] Search results page
   - [x] Infinite scroll for restaurant results.
   - [x] Implement map view of restaurant results.
- [x] Filter page
   - [x] Implement a custom switch instead of the default UISwitch.
   - [x] Distance filter should expand as in the real Yelp app
   - [x] Categories should show a subset of the full list with a "See All" row to expand. Category list is [here](http://www.yelp.com/developers/documentation/category_list).
- [x] Implement the restaurant detail page.

The following **additional** features are implemented:
- [x] Added launch icon
- [x] Tracking user location and showing in mapview.
- [x] Detail page : Has - ** checkin **  and ** favorites **  buttons to add businesses of interest or check in. Currently stored in memory.
	  [x] Has a mini map which shows the address of the business.
- [x] Added tabbed bar - where second bar "Activity " list - showing checked in /favorited businesses.
- [x] MapKit : Added Custom Marker for MKAnnotation , Custom view for MKAnnotationView
- [x] Autolayout implemented througout all screens
- [x] Animations 
	- [x] Tried to mimic flip horizontal from list to map and flip vertical from map to list.
	- [x] Sections expansion on filters page for Sort by / Distance and Categories.

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1. What is the best way to manage navigation if you have a very large number of view controllers and navigation patterns (Tab bar , Nav bar , etc) ?.
2. When is the time you would go for creating a custom xib file ?. I see when i was using MapKit markers , it felt a necessity for the view to be a xib. Is it that whenever you try to custom display a view , then would it be a right fit?. 
3. Code Reusability patterns - while in View Controllers. (Like i saw code sharing in BaseViewControllers , but this not necessary require passing of view elements , but results in lot of delegates). Is there any better way of reusing view code ? , this means technically view should be shared as well. 

## Video Walkthrough

Here's a walkthrough of implemented user stories:

<img src='http://i.imgur.com/link/to/your/gif/file.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

Describe any challenges encountered while building the app.

## License

    Copyright [yyyy] [name of copyright owner]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.