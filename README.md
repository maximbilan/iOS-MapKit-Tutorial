# iOS MapKit Getting Started

Hi, I would like to tell how to work with <i>MapKit</i> in iOS using <i>Swift</i>. This post for beginners, I will try to tell as detailed as possible.

![alt tag](https://raw.github.com/maximbilan/iOS-MapKit-Tutorial/master/images/1.png)

Apple provides <i><a href="https://developer.apple.com/library/ios/documentation/MapKit/Reference/MKMapView_Class/index.html#//apple_ref/occ/cl/MKMapView">MKMapView</a></i> class for working with map. This class displays maps and provides interface to navigate map content. Detailed documentation about this class you can found <a href="https://developer.apple.com/library/mac/documentation/MapKit/Reference/MKMapView_Class/">here</a>. Let's start.

First of all add the <i>map view</i> to your <i>storyboard</i> or <i>xib</i>, or create from the code. In this sample I will create a simple <i>storyboard</i> with one <i>UIViewController</i> which will contain a <i>map view</i>.

![alt tag](https://raw.github.com/maximbilan/iOS-MapKit-Tutorial/master/images/2.png)

The second main part, you need to add <i>MapKit</i> framework to your project.

![alt tag](https://raw.github.com/maximbilan/iOS-MapKit-Tutorial/master/images/3.png)

If you see the map when you run the application, then you are on the right way.

![alt tag](https://raw.github.com/maximbilan/iOS-MapKit-Tutorial/master/images/4.png)

Please add an outlet of map view object to your <i>UIViewController</i>. Also you need to import <i>MapKit</i> module in the <i>UIViewController</i>.

<pre>
import MapKit
</pre>

Apple provides <i><a href="https://developer.apple.com/library/ios/documentation/MapKit/Reference/MKMapViewDelegate_Protocol/">MKMapViewDelegate</a></i> and <i><a href="https://developer.apple.com/library/ios/documentation/CoreLocation/Reference/CLLocationManagerDelegate_Protocol/">CLLocationManagerDelegate</a></i> delegates for developers. The <i><a href="https://developer.apple.com/library/ios/documentation/MapKit/Reference/MKMapViewDelegate_Protocol/">MKMapViewDelegate</a></i> protocol defines a set of optional methods that you can use to receive map-related update messages. Because many map operations require the <i><a href="https://developer.apple.com/library/ios/documentation/MapKit/Reference/MKMapView_Class/index.html#//apple_ref/occ/cl/MKMapView">MKMapView</a></i> class to load data asynchronously, the map view calls these methods to notify your application when specific operations complete. The map view also uses these methods to request annotation and overlay views and to manage interactions with those views. More details you can found <a href="https://developer.apple.com/library/ios/documentation/MapKit/Reference/MKMapViewDelegate_Protocol/">here</a>. The <i><a href="https://developer.apple.com/library/ios/documentation/CoreLocation/Reference/CLLocationManagerDelegate_Protocol/">CLLocationManagerDelegate</a></i> protocol defines the methods used to receive location and heading updates from a <i><a href="https://developer.apple.com/library/ios/documentation/CoreLocation/Reference/CLLocationManager_Class/index.html#//apple_ref/occ/cl/CLLocationManager">CLLocationManager</a></i> object. More details <a href="https://developer.apple.com/library/ios/documentation/CoreLocation/Reference/CLLocationManagerDelegate_Protocol/">here</a>.

Don’t forget set up a delegate in your code.

<pre>
import MapKit
class ViewController: UIViewController, MKMapViewDelegate {
  @IBOutlet weak var mapView: MKMapView!
  override func viewDidLoad() {
    super.viewDidLoad()
    mapView.delegate = self
  }
}
</pre>

Or via <i>Interface Builder</i>.

![alt tag](https://raw.github.com/maximbilan/iOS-MapKit-Tutorial/master/images/5.png)

For <i><a href="https://developer.apple.com/library/ios/documentation/CoreLocation/Reference/CLLocationManagerDelegate_Protocol/">CLLocationManagerDelegate</a></i> the same:

<pre>
locationManager.delegate = self
</pre>

Let’s try to add a button for detecting the current location:

<pre>
let currentLocationButton = UIBarButtonItem(title: "Current Location", style: UIBarButtonItemStyle.Plain, target: self, action: "currentLocationButtonAction:")
self.navigationItem.leftBarButtonItem = currentLocationButton
</pre>

Then implement <i>currentLocationButtonAction</i> method:

<pre>
func currentLocationButtonAction(sender: UIBarButtonItem) {
  if (CLLocationManager.locationServicesEnabled()) {
    if locationManager == nil {
      locationManager = CLLocationManager()
    }
    locationManager?.requestWhenInUseAuthorization()
    locationManager.delegate = self
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    locationManager.requestAlwaysAuthorization()
    locationManager.startUpdatingLocation()
  }
}
</pre>

After that when you requested the location, you need to implement <i>didUpdateLocations</i> from <i><a href="https://developer.apple.com/library/ios/documentation/CoreLocation/Reference/CLLocationManagerDelegate_Protocol/">CLLocationManagerDelegate</a></i>, and here you can add a location to <i>mapView</i>. Please see the next code:

<pre>
func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
  let location = locations.last
  let center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
  let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
  self.mapView.setRegion(region, animated: true)
  if self.mapView.annotations.count != 0 {
    annotation = self.mapView.annotations[0]
    self.mapView.removeAnnotation(annotation)
  }
  let pointAnnotation = MKPointAnnotation()
  pointAnnotation.coordinate = location!.coordinate
  pointAnnotation.title = ""
  mapView.addAnnotation(pointAnnotation)
}
</pre>

<b>Important note:</b> The current authorization status for location data is available from the <i><a href="https://developer.apple.com/library/ios/documentation/CoreLocation/Reference/CLLocationManager_Class/index.html#//apple_ref/occ/clm/CLLocationManager/authorizationStatus">authorizationStatus</a></i> class method of <i>CLLocationManager</i>. In requesting authorization in iOS 8 and later, you must use the <i><a href="https://developer.apple.com/library/ios/documentation/CoreLocation/Reference/CLLocationManager_Class/index.html#//apple_ref/occ/instm/CLLocationManager/requestWhenInUseAuthorization">requestWhenInUseAuthorization</a></i> or <i><a href="https://developer.apple.com/library/ios/documentation/CoreLocation/Reference/CLLocationManager_Class/index.html#//apple_ref/occ/instm/CLLocationManager/requestAlwaysAuthorization">requestAlwaysAuthorization</a></i> method and include the <i>NSLocationWhenInUseUsageDescription</i> or <i>NSLocationAlwaysUsageDescription</i> key in your <b>Info.plist</b> file to indicate the level of authorization you require.

Let’s continue…

![alt tag](https://raw.github.com/maximbilan/iOS-MapKit-Tutorial/master/images/6.png)

Now I will tell how to do a simple search.

First of all you need to add <i><a href="https://developer.apple.com/library/tvos/documentation/UIKit/Reference/UISearchBarDelegate_Protocol/index.html">UISearchBarDelegate</a></i> to your <i>UIViewController</i>. The <i><a href="https://developer.apple.com/library/tvos/documentation/UIKit/Reference/UISearchBarDelegate_Protocol/index.html">UISearchBarDelegate</a></i> protocol defines the optional methods you implement to make a <i><a href="https://developer.apple.com/library/tvos/documentation/UIKit/Reference/UISearchBar_Class/index.html#//apple_ref/occ/cl/UISearchBar">UISearchBar</a></i> control functional. A <i><a href="https://developer.apple.com/library/tvos/documentation/UIKit/Reference/UISearchBar_Class/index.html#//apple_ref/occ/cl/UISearchBar">UISearchBar</a></i> object provides the user interface for a search field on a bar, but it’s the application’s responsibility to implement the actions when buttons are tapped. At a minimum, the delegate needs to perform the actual search when text is entered in the text field.

Please add the following variables to your class:

<pre>
private var searchController: UISearchController!
private var localSearchRequest: MKLocalSearchRequest!
private var localSearch: MKLocalSearch!
private var localSearchResponse: MKLocalSearchResponse!
</pre>

And then we add a search navigation bar button:

<pre>
let searchButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Search, target: self, action: "searchButtonAction:")
self.navigationItem.rightBarButtonItem = searchButton
</pre>

![alt tag](https://raw.github.com/maximbilan/iOS-MapKit-Tutorial/master/images/7.png)

Implementation of the search button action:

<pre>
func searchButtonAction(button: UIBarButtonItem) {
  if searchController == nil {
    searchController = UISearchController(searchResultsController: nil)
  }
  searchController.hidesNavigationBarDuringPresentation = false
  self.searchController.searchBar.delegate = self
  presentViewController(searchController, animated: true, completion: nil)
}
</pre>

And the last point, we need to implement <i>searchBarSearchButtonClicked</i> method from <i>UISearchBarDelegate</i>:

<pre>
func searchBarSearchButtonClicked(searchBar: UISearchBar) {
  searchBar.resignFirstResponder()
  dismissViewControllerAnimated(true, completion: nil)
  
  if self.mapView.annotations.count != 0 {
    annotation = self.mapView.annotations[0]
    self.mapView.removeAnnotation(annotation)
  }
  localSearchRequest = MKLocalSearchRequest()
  localSearchRequest.naturalLanguageQuery = searchBar.text
  localSearch = MKLocalSearch(request: localSearchRequest)
  localSearch.startWithCompletionHandler { [weak self]  (localSearchResponse, error) -> Void in
    if localSearchResponse == nil {
      let alert = UIAlertView(title: nil, message: “Place not found”, delegate: self, cancelButtonTitle: “Try again”)
      alert.show()
      return
    }
    let pointAnnotation = MKPointAnnotation()
    pointAnnotation.title = searchBar.text
    pointAnnotation.coordinate = CLLocationCoordinate2D(latitude:     localSearchResponse!.boundingRegion.center.latitude, longitude: localSearchResponse!.boundingRegion.center.longitude)
    let pinAnnotationView = MKPinAnnotationView(annotation: pointAnnotation, reuseIdentifier: nil)
    self!.mapView.centerCoordinate = pointAnnotation.coordinate
    self!.mapView.addAnnotation(pinAnnotationView.annotation!)
  }
}
</pre>

The code is simple and I think you will figure out very easily. One small thing which I would like to share, it is a map type. <i>MapView</i> object has <i>mapType</i> property with next values, which you can easily set up:

<pre>
Standard
Satellite
Hybrid
</pre>

![alt tag](https://raw.github.com/maximbilan/iOS-MapKit-Tutorial/master/images/8.png)

That’s all, I hope these tutorials help you to start developing apps using <i>MapKit</i>.
