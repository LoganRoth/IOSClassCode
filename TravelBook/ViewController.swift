//
//  ViewController.swift
//  TravelBook
//
//  Created by Logan Roth on 2020-12-28.
//

import UIKit
import MapKit
import CoreLocation
import CoreData

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    // Variables
    var locMgr = CLLocationManager()
    var newLat = Double()
    var newLong = Double()
    var selTitle = ""
    var selId : UUID?
    
    var annotationTitle = ""
    var annotationComment = ""
    var annotationLat = Double()
    var annotationLong = Double()
    
    // Views
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var commentField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Map Setup
        mapView.delegate = self
        locMgr.delegate = self
        locMgr.desiredAccuracy = kCLLocationAccuracyBest
        locMgr.requestWhenInUseAuthorization()
        locMgr.startUpdatingLocation()
        
        // Gesture Recognizer
        

        // Recognizers
        let keyboardRec = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(keyboardRec)
        
        let gestRec = UILongPressGestureRecognizer(target: self, action: #selector(chooseLoc(gestRec: )))
        gestRec.minimumPressDuration = 3
        mapView.addGestureRecognizer(gestRec)
        
        if selTitle != "" {
            // CoreData
            let idString = selId!.uuidString
            let appDel = UIApplication.shared.delegate as! AppDelegate
            let ctx = appDel.persistentContainer.viewContext
            
            let req = NSFetchRequest<NSFetchRequestResult>(entityName: "TaggedLocations")
            req.predicate = NSPredicate(format: "id = %@", idString)
            req.returnsObjectsAsFaults = false
            
            do {
                let results = try ctx.fetch(req)
                if results.count > 0 {
                    for result in results as! [NSManagedObject] {
                        if let title = result.value(forKey: "title") as? String {
                            annotationTitle = title
                            if let comment = result.value(forKey: "comment") as? String {
                                annotationComment = comment
                                if let lat = result.value(forKey: "latitude") as? Double {
                                    annotationLat = lat
                                    if let long = result.value(forKey: "longitude") as? Double {
                                        annotationLong = long
                                        
                                        let annotation = MKPointAnnotation()
                                        annotation.title = annotationTitle
                                        annotation.subtitle = annotationComment
                                        let coordinate = CLLocationCoordinate2D(latitude: annotationLat, longitude: annotationLong)
                                        annotation.coordinate = coordinate
                                        
                                        mapView.addAnnotation(annotation)
                                        nameField.text = annotationTitle
                                        commentField.text = annotationComment
                                        
                                        locMgr.stopUpdatingLocation()
                                        
                                        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                                        let region = MKCoordinateRegion(center: coordinate, span: span)
                                        mapView.setRegion(region, animated: true)
                                    }
                                }
                            }
                        }
                    }
                }
            } catch {
                // Show Alert
            }
        } else {
            // Add New Data
        }
        
    }
    
    @objc func chooseLoc(gestRec: UILongPressGestureRecognizer) {
        if gestRec.state == .began {
            let touchPt = gestRec.location(in: self.mapView)
            let touchCoor = self.mapView.convert(touchPt, toCoordinateFrom: self.mapView)
            newLat = touchCoor.latitude
            newLong = touchCoor.longitude
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = touchCoor
            annotation.title = nameField.text
            annotation.subtitle = commentField.text
            
            self.mapView.addAnnotation(annotation)
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if selTitle == "" {
            let currCLLoc = locations[0]
            let currLoc = CLLocationCoordinate2D(latitude: currCLLoc.coordinate.latitude, longitude: currCLLoc.coordinate.longitude)
            let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            let region = MKCoordinateRegion(center: currLoc, span: span)
            mapView.setRegion(region, animated: true)
        } else {
            // Do Nothing
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        
        let reuseId = "myAnnotation"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView?.canShowCallout = true
            pinView?.tintColor = UIColor.black
            
            let button = UIButton(type: UIButton.ButtonType.detailDisclosure)
            pinView?.rightCalloutAccessoryView = button
        } else {
            pinView?.annotation = annotation
        }
        
        return pinView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if selTitle != "" {
            let reqLoc = CLLocation(latitude: annotationLat, longitude: annotationLong)
            CLGeocoder().reverseGeocodeLocation(reqLoc) { (placemarksOut, error) in
                if let placemarks = placemarksOut {
                    if placemarks.count > 0 {
                        let newPlacemark = MKPlacemark(placemark: placemarks[0])
                        let item = MKMapItem(placemark: newPlacemark)
                        item.name = self.annotationTitle
                        let launchOpts = [MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving]
                        item.openInMaps(launchOptions: launchOpts)
                    }
                    
                }
            }
        }
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func savebuttonClicked(_ sender: Any) {
        let appDel = UIApplication.shared.delegate as! AppDelegate
        let ctx = appDel.persistentContainer.viewContext
        
        let newLoc = NSEntityDescription.insertNewObject(forEntityName: "TaggedLocations", into: ctx)
        newLoc.setValue(nameField.text, forKey: "title")
        newLoc.setValue(commentField.text, forKey: "comment")
        newLoc.setValue(newLat, forKey: "latitude")
        newLoc.setValue(newLong, forKey: "longitude")
        newLoc.setValue(UUID(), forKey: "id")
        do {
            try ctx.save()
            
        } catch {
            // Show Alert
        }
        
        NotificationCenter.default.post(name: NSNotification.Name("newPlace"), object: nil)
        navigationController?.popViewController(animated: true)
        
    }
    
    
    
}

