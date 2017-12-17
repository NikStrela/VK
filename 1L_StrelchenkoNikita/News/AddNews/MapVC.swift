//
//  MapVC.swift
//  1L_StrelchenkoNikita
//
//  Created by Никита on 16.11.17.
//  Copyright © 2017 Никита. All rights reserved.
//

import UIKit
import MapKit
import  CoreLocation

class MapVC: UIViewController,CLLocationManagerDelegate {

    var coordinateMapVC: (Double,Double) = (0,0)
    @IBOutlet weak var map: MKMapView!
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        
        if let currentLocation = locations.last?.coordinate {
            let currentRadius: CLLocationDistance = 1000
            let currentRegion = MKCoordinateRegionMakeWithDistance((currentLocation), currentRadius * 2.0, currentRadius * 2.0)
            self.map.setRegion(currentRegion, animated: true)
            self.map.showsUserLocation = true
            coordinateMapVC = (currentLocation.latitude,currentLocation.longitude)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Map" {
            let temp = segue.destination as! AddNewsVC
            temp.coordinateNews = coordinateMapVC
        }
    }

        

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
