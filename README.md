# iOS MapKit Getting Started Part

Hi, I would like to tell how to work with MapKit in iOS using Swift. This post for beginners, I will try to tell as detailed as possible.

Apple provides MKMapView class for working with map. This class displays maps and provides interface to navigate map content. Detailed documentation about this class you can found here. Let's start.
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

