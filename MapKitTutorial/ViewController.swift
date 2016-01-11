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
	
	private var annotation: MKAnnotation!
	private var locationManager: CLLocationManager!
	
	override func viewDidLoad() {
		super.viewDidLoad()

		mapView.delegate = self
	}

}

