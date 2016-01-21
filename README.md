# iOS MapKit Getting Started Part

Hi, I would like to tell how to work with <i>MapKit</i> in iOS using <i>Swift</i>. This post for beginners, I will try to tell as detailed as possible.

![alt tag](https://raw.github.com/maximbilan/iOS-MapKit-Tutorial/master/images/1.png)

Apple provides <i>MKMapView</i> class for working with map. This class displays maps and provides interface to navigate map content. Detailed documentation about this class you can found <a href="https://developer.apple.com/library/mac/documentation/MapKit/Reference/MKMapView_Class/">here</a>. Let's start.

First of all add the <i>map view</i> to your <i>storyboard</i> or <i>xib</i>, or create from code. In this sample I will create simple <i>storyboard</i> with one <i>UIViewController</i> which will contain <i>map view</i>.

![alt tag](https://raw.github.com/maximbilan/iOS-MapKit-Tutorial/master/images/2.png)

The second main part, you need to add <i>MapKit</i> framework to your project.

![alt tag](https://raw.github.com/maximbilan/iOS-MapKit-Tutorial/master/images/3.png)

If you see the map when you run the application, then you are on the right way.

![alt tag](https://raw.github.com/maximbilan/iOS-MapKit-Tutorial/master/images/4.png)

Please add outlet of map view object to your <i>UIViewController</i>. Also you need to import <i>MapKit</i> module in the <i>UIViewController</i>.

Apple provides <i>MKMapViewDelegate</i> and <i>CLLocationManagerDelegate</i> delegates for developers. The MKMapViewDelegate protocol defines a set of optional methods that you can use to receive map-related update messages. Because many map operations require the MKMapView class to load data asynchronously, the map view calls these methods to notify your application when specific operations complete. The map view also uses these methods to request annotation and overlay views and to manage interactions with those views. More details you can found here. The CLLocationManagerDelegate protocol defines the methods used to receive location and heading updates from a CLLocationManager object. More details here.

Don’t forget setup delegate in your code.

Or via Interface Builder.

![alt tag](https://raw.github.com/maximbilan/iOS-MapKit-Tutorial/master/images/5.png)

For CLLocationManagerDelegate the same:

Let’s try to add button for detecting current location.

Then implement currentLocationButtonAction method:

After that when you requested location, you need to implement didUpdateLocations from CLLocationManagerDelegate, and here you can add location to map view. Please see the next code:

Important note: The current authorization status for location data is available from the authorizationStatus class method of CLLocationManager. In requesting authorization in iOS 8 and later, you must use the requestWhenInUseAuthorization or requestAlwaysAuthorizationmethod and include the NSLocationWhenInUseUsageDescription or NSLocationAlwaysUsageDescription key in your Info.plist file to indicate the level of authorization you require.

Let’s continue…

![alt tag](https://raw.github.com/maximbilan/iOS-MapKit-Tutorial/master/images/6.png)

Now I will tell how to do simple search.

First of all you need to add UISearchBarDelegate to your UIViewController. The UISearchBarDelegate protocol defines the optional methods you implement to make a UISearchBar control functional. A UISearchBar object provides the user interface for a search field on a bar, but it’s the application’s responsibility to implement the actions when buttons are tapped. At a minimum, the delegate needs to perform the actual search when text is entered in the text field.

Please add the following variables to your class:

And then we add search navigation bar button:

![alt tag](https://raw.github.com/maximbilan/iOS-MapKit-Tutorial/master/images/7.png)

Implementation of search button action:

And the last point, we need to implement searchBarSearchButtonClicked method from UISearchBarDelegate:

The code is simple and I think you will figure out very easily. One small thing which I would like to share, it is map type. MapView object has mapType property with next values, which you can easily setup:

![alt tag](https://raw.github.com/maximbilan/iOS-MapKit-Tutorial/master/images/8.png)

That’s all, I hope these tutorials help you to start developing apps using MapKit.
