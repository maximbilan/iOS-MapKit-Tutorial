# iOS MapKit Getting Started Part

Hi, I would like to tell how to work with <i>MapKit</i> in iOS using <i>Swift</i>. This post for beginners, I will try to tell as detailed as possible.

Apple provides <i>MKMapView</i> class for working with map. This class displays maps and provides interface to navigate map content. Detailed documentation about this class you can found here. Let's start.
First of all add the map view to your storyboard or xib, or create from code. In this sample I will create simple storyboard with one UIViewController which will contain map view.

The second main part, you need to add MapKit framework to your project.

If you see the map when you run the application, then you are on the right way.

Please add outlet of map view object to your UIViewController. Also you need to import MapKit module in the UIViewController.

Apple provides MKMapViewDelegate and CLLocationManagerDelegate delegates for developers. The MKMapViewDelegate protocol defines a set of optional methods that you can use to receive map-related update messages. Because many map operations require the MKMapView class to load data asynchronously, the map view calls these methods to notify your application when specific operations complete. The map view also uses these methods to request annotation and overlay views and to manage interactions with those views. More details you can found here. The CLLocationManagerDelegate protocol defines the methods used to receive location and heading updates from a CLLocationManager object. More details here.

Don’t forget setup delegate in your code.

Or via Interface Builder.

For CLLocationManagerDelegate the same:

Let’s try to add button for detecting current location.

Then implement currentLocationButtonAction method:

After that when you requested location, you need to implement didUpdateLocations from CLLocationManagerDelegate, and here you can add location to map view. Please see the next code:

Important note: The current authorization status for location data is available from the authorizationStatus class method of CLLocationManager. In requesting authorization in iOS 8 and later, you must use the requestWhenInUseAuthorization or requestAlwaysAuthorizationmethod and include the NSLocationWhenInUseUsageDescription or NSLocationAlwaysUsageDescription key in your Info.plist file to indicate the level of authorization you require.

Let’s continue…

Now I will tell how to do simple search.

First of all you need to add UISearchBarDelegate to your UIViewController. The UISearchBarDelegate protocol defines the optional methods you implement to make a UISearchBar control functional. A UISearchBar object provides the user interface for a search field on a bar, but it’s the application’s responsibility to implement the actions when buttons are tapped. At a minimum, the delegate needs to perform the actual search when text is entered in the text field.

Please add the following variables to your class:

And then we add search navigation bar button:

Implementation of search button action:

And the last point, we need to implement searchBarSearchButtonClicked method from UISearchBarDelegate:

The code is simple and I think you will figure out very easily. One small thing which I would like to share, it is map type. MapView object has mapType property with next values, which you can easily setup:

That’s all, I hope these tutorials help you to start developing apps using MapKit.
