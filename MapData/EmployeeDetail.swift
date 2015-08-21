//
//  EmployeeDetail.swift
//  MapData
//
//  Created by Kristian Secor on 2/11/15.
//  Copyright (c) 2015 Kristian Secor. All rights reserved.
//


import UIKit
import CoreData
import MapKit
import CoreLocation


class EmployeeDetail: UIViewController, CLLocationManagerDelegate,MKMapViewDelegate
{
    
    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager: CLLocationManager = CLLocationManager()

    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var positionField: UITextField!
    
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext
    
    
    var employee: Employees? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if employee != nil {
           nameField.text = employee?.fullName
           positionField.text = employee?.position
           

        }
        
        if (CLLocationManager.locationServicesEnabled()) {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        } else {
            println("Location services are not enabled");
        }
    }
    
    

    
    @IBAction func done(sender: AnyObject) {
        if employee != nil {
            editEmployee()
        } else {
            createEmployee()
        }
        dismissViewController()
    }

    
    func dismissViewController() {
        navigationController?.popViewControllerAnimated(true)
    }
    
    
 
    
    func createEmployee() {
        let entityDescription = NSEntityDescription.entityForName("Employees", inManagedObjectContext: managedObjectContext!)
        let employee = Employees(entity: entityDescription!, insertIntoManagedObjectContext: managedObjectContext)
        
        
        
        employee.fullName = nameField.text
        
        employee.position = positionField.text
        employee.latitude = 32.117
        employee.longitude = -117.34
        
        
        
        managedObjectContext?.save(nil)
        
        
        
        
        
        
    }
    
    
    func editEmployee() {
        employee?.fullName = nameField.text
        employee?.position = positionField.text

        managedObjectContext?.save(nil)
    }
    
    
    // MARK: - CoreLocation Delegate Methods
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        if ((error) != nil) {
            print(error)
        }
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        var locationArray = locations as NSArray
        var locationObj = locationArray.lastObject as CLLocation
        var coord = locationObj.coordinate
        locationManager.stopUpdatingLocation()
        
        let location = CLLocationCoordinate2D(latitude: coord.latitude,longitude: coord.longitude)
        let span = MKCoordinateSpanMake(0.01, 0.01)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
        let annotation = MKPointAnnotation()
        annotation.setCoordinate(location)
        annotation.title = "La Vela Paz"
        annotation.subtitle = "San Diego"
        mapView.addAnnotation(annotation)
        employee?.latitude = coord.latitude
        employee?.longitude = coord.longitude
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
