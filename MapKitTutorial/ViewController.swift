//
//  ViewController.swift
//  MapKitTutorial
//
//  Created by Maxim on 1/8/16.
//  Copyright © 2016 Maxim Bilan. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

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
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		let currentLocationButton = UIBarButtonItem(title: "Current Location", style: UIBarButtonItemStyle.Plain, target: self, action: "currentLocationButtonAction:")
		self.navigationItem.leftBarButtonItem = currentLocationButton
		
		mapView.delegate = self
	}
	
	func currentLocationButtonAction(barButton: UIBarButtonItem) {
		
	}

}

