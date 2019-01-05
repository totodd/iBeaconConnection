//
//  BeaconTableViewController.swift
//  iBeaconConnection
//
//  Created by TOTO on 5/1/19.
//  Copyright © 2019 TOTO. All rights reserved.
//

import UIKit
import CoreLocation
import UserNotifications


class BeaconTableViewController: UITableViewController, CLLocationManagerDelegate, UNUserNotificationCenterDelegate {
    let locationMgr = CLLocationManager()
    
    func rangeBeacons(){
        let id = "BeaconRegiontest"
//        let region = CLBeaconRegion(proximityUUID: uuid, major: major, identifier: id)
        let region = CLBeaconRegion(proximityUUID: Constant.uuid, major: Constant.major, minor: Constant.minor, identifier: id)
        locationMgr.startRangingBeacons(in: region)
        
//        locationMgr.startMonitoring(for: region)
        
    }

    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        rangeBeacons()
    }
    
    var beaconsFound = [CLBeacon](){
        didSet{
            tableView.reloadData()
        }
    }
    
    var region: CLBeaconRegion{
        return CLBeaconRegion(proximityUUID: UUID(uuidString: "FDA50693-A4E2-4FB1-AFCF-C6EB07647825")!, major: 10, identifier: "test id")
    }
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        print("did range beacons in \(region.identifier)")
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
        if discoveredBeacon.proximity == .immediate{
            pushNotification(str: "too close foreground")
        }

        beaconsFound = beacons
        print(beacons.count)
    
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationMgr.delegate = self

        locationMgr.requestAlwaysAuthorization()

        

        
        UNUserNotificationCenter.current().delegate = self


        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return beaconsFound.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "beaconCell", for: indexPath)

        let beacon = beaconsFound[indexPath.row]
        cell.textLabel?.text = beaconsFound[indexPath.row].minor.description(withLocale: nil)
        cell.detailTextLabel?.text = String(beacon.rssi) + "  " + String(beacon.accuracy)
        

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension BeaconTableViewController{
    func pushNotification(str: String){
        let content = UNMutableNotificationContent()
        content.title = str
        content.launchImageName = "faceless"
        content.body = " I am body"
        content.sound = UNNotificationSound.default
        
            let request3 = UNNotificationRequest(identifier: "notId2", content: content, trigger: nil)
            UNUserNotificationCenter.current().add(request3, withCompletionHandler: nil)

    }
    

}
