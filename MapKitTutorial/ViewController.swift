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
	
	private var annotation: MKAnnotation!
	private var locationManager: CLLocationManager!
	
	override func viewDidLoad() {
		super.viewDidLoad()

		mapView.delegate = self
	}

	// MARK: - MKMapViewDelegate
	
	// MARK: - CLLocationManagerDelegate
	
}

