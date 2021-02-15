//
//  ViewController.swift
//  mapProtocol
//
//  Created by 神山駿 on 2021/02/15.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController,CLLocationManagerDelegate,UIGestureRecognizerDelegate,searchLocationDelegate {
    

    @IBOutlet var longPress: UILongPressGestureRecognizer!
    var address = ""
    
    @IBOutlet weak var mapView: MKMapView!
    
    var locManager:CLLocationManager!
    
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var setButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setButton.backgroundColor = .white
        setButton.layer.cornerRadius = 20.0
    }

    @IBAction func longPressTap(_ sender: UILongPressGestureRecognizer) {
        if sender.state == .began{
            
        }else if sender.state == .ended{
            let tapPoint = sender.location(in: view)
            let center = mapView.convert(tapPoint, toCoordinateFrom: mapView)
            let lat = center.latitude
            let log = center.longitude
            
            convert(lat: lat, log: log)
            
            
        }
    }
    func convert(lat: CLLocationDegrees, log: CLLocationDegrees){
        
        let geocoder = CLGeocoder()
        let location = CLLocation(latitude: lat, longitude: log)
        
        geocoder.reverseGeocodeLocation(location){
            (placeMark,error) in
            if let placeMark = placeMark{
                if let pm = placeMark.first{
                    if pm.administrativeArea != nil || pm.locality != nil{
                        self.address = pm.name! + pm.administrativeArea! + pm.locality!
                    }else{
                        self.address = pm.name!
                    }
                    self.label.text = self.address
                }
            }
        }
    }
    
    @IBAction func setting(_ sender: Any) {
        performSegue(withIdentifier: "next", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "next"{
        let NextVC = segue.destination as! NextViewController
            NextVC.delegate = self
        }
        
    }
    
    func searchLocation(latValue: String, logValue: String) {
        if latValue.isEmpty != true && logValue.isEmpty != true{
            let latString = latValue
            let logString = logValue
            
            let cordinate = CLLocationCoordinate2DMake(Double(latString)!, Double(logString)!)
            
            let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            
            let region = MKCoordinateRegion(center: cordinate, span: span)
            
            mapView.setRegion(region, animated: true)
            
            convert(lat: Double(latString)!, log: Double(logString)!)
            
            label.text = address
        }else{
            label.text = "表示できません"
        }
    }
}

