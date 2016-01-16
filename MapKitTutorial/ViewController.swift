//
//  ViewController.swift
//  MapKitTutorial
//
//  Created by Maxim on 1/8/16.
//  Copyright © 2016 Maxim Bilan. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, UISearchBarDelegate {

	// MARK: - Outlets
	
	@IBOutlet weak var mapView: MKMapView!
	
	// MARK: - Search
	
	private var searchController: UISearchController!
	private var localSearchRequest: MKLocalSearchRequest!
	private var localSearch: MKLocalSearch!
	private var localSearchResponse: MKLocalSearchResponse!
	
	// MARK: - Map variables
	
	private var annotation: MKAnnotation!
	private var locationManager: CLLocationManager!
	private var isCurrentLocation: Bool = false
	
	// MARK: - Activity Indicator
	
	private var activityIndicator: UIActivityIndicatorView!
	
	// MARK: - UIViewController's methods
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		let currentLocationButton = UIBarButtonItem(title: "Current Location", style: UIBarButtonItemStyle.Plain, target: self, action: "currentLocationButtonAction:")
		self.navigationItem.leftBarButtonItem = currentLocationButton
		
		let searchButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Search, target: self, action: "searchButtonAction:")
		self.navigationItem.rightBarButtonItem = searchButton
		
		mapView.delegate = self
		
		activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
		activityIndicator.hidesWhenStopped = true
		self.view.addSubview(activityIndicator)
	}
	
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		
		activityIndicator.center = self.view.center
	}
	
	// MARK: - Actions
	
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
			isCurrentLocation = true
		}
	}
	
	// MARK: - Search
	
	func searchButtonAction(button: UIBarButtonItem) {
		if searchController == nil {
			searchController = UISearchController(searchResultsController: nil)
		}
		searchController.hidesNavigationBarDuringPresentation = false
		self.searchController.searchBar.delegate = self
		presentViewController(searchController, animated: true, completion: nil)
	}
	
	// MARK: - UISearchBarDelegate
	
	func searchBarSearchButtonClicked(searchBar: UISearchBar){
		searchBar.resignFirstResponder()
		dismissViewControllerAnimated(true, completion: nil)
		
		if self.mapView.annotations.count != 0 {
			annotation = self.mapView.annotations[0]
			self.mapView.removeAnnotation(annotation)
		}
		
		localSearchRequest = MKLocalSearchRequest()
		localSearchRequest.naturalLanguageQuery = searchBar.text
		localSearch = MKLocalSearch(request: localSearchRequest)
		localSearch.startWithCompletionHandler { [weak self] (localSearchResponse, error) -> Void in
			
			if localSearchResponse == nil {
				let alert = UIAlertView(title: nil, message: "Place not found", delegate: self, cancelButtonTitle: "Try again")
				alert.show()
				return
			}
			
			let pointAnnotation = MKPointAnnotation()
			pointAnnotation.title = searchBar.text
			pointAnnotation.coordinate = CLLocationCoordinate2D(latitude: localSearchResponse!.boundingRegion.center.latitude, longitude: localSearchResponse!.boundingRegion.center.longitude)
			
			let pinAnnotationView = MKPinAnnotationView(annotation: pointAnnotation, reuseIdentifier: nil)
			self!.mapView.centerCoordinate = pointAnnotation.coordinate
			self!.mapView.addAnnotation(pinAnnotationView.annotation!)
		}
	}
	
	// MARK: - CLLocationManagerDelegate
	
	func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		
		if !isCurrentLocation {
			return
		}
		
		isCurrentLocation = false
		
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

}

