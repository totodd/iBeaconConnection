//
//  ViewController.swift
//  iBeaconConnection
//
//  Created by TOTO on 5/1/19.
//  Copyright © 2019 TOTO. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    let locationMgr = CLLocationManager()

    func rangeBeacons(){
        let uuid = UUID(uuidString: "FDA50693-A4E2-4FB1-AFCF-C6EB07647825")!
        //    let uuid = UUID("FDA50693A4E24FB1AFCFC6EB07647825")
        let major : CLBeaconMajorValue = 10
        let minor : CLBeaconMinorValue = 7
        let id = "test"
        let region = CLBeaconRegion(proximityUUID: uuid, major: major, identifier: id)
//        let region = CLBeaconRegion(proximityUUID: uuid, major: major, minor: minor, identifier: "test Beacon")
        locationMgr.startRangingBeacons(in: region)
    }

    @IBOutlet weak var test: UILabel! {
        didSet{
            test.sizeToFit()
        }
    }
    @IBOutlet weak var BeaconNumber: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationMgr.delegate = self
        
        if (CLLocationManager.authorizationStatus() != ){
//        locationMgr.requestState(for: <#T##CLRegion#>)
            locationMgr.requestWhenInUseAuthorization()
        }
    }
//    @IBOutlet weak var tableV: UITableView!
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        rangeBeacons()
    }
    @IBOutlet weak var beaconNames: UILabel!
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        
        guard let discoveredBeacon = beacons.first else { return }
        
        let beaconRange = discoveredBeacon.proximity
        
        let bgColor: UIColor = {
            switch beaconRange{
            case .far :return #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
            case.immediate: return #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
            case .unknown: return #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
            case .near: return #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
            }
        }()
        
        view.backgroundColor = bgColor
        
        beacons.forEach{
            print($0.minor.description(withLocale: nil))
        }
        test.text = "distance: " + String(discoveredBeacon.rssi)
        BeaconNumber.text = String(beacons.count)
        

    }

}

