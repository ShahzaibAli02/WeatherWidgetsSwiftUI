import Foundation
import CoreLocation
import BackgroundTasks

class LocationManager: NSObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
//    private let userDefaults: UserDefaults
    private var backgroundTask: BGTask?
    let TAG = "LocationManager"
    
    override init() {
//        if let groupUserDefaults = UserDefaults(suiteName: "group.com.yourcompany.yourapp") {
//            self.userDefaults = groupUserDefaults
//        } else {
//            self.userDefaults = UserDefaults.standard
//        }
        
        super.init()
        locationManager.delegate = self
        if #available(iOS 9, *){
                   locationManager.allowsBackgroundLocationUpdates = true
               }
               locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
               locationManager.distanceFilter = kCLDistanceFilterNone
               locationManager.headingFilter = kCLHeadingFilterNone
               locationManager.pausesLocationUpdatesAutomatically = true
               locationManager.activityType = .otherNavigation
               if #available(iOS 11.0, *) {
                   locationManager.showsBackgroundLocationIndicator = true;
               }
               locationManager.delegate = self
               locationManager.startMonitoringSignificantLocationChanges()
        print("\(TAG) => INIT()")
        checkLocationAuthorization()
    }
    
    private func checkLocationAuthorization() {
        let status = locationManager.authorizationStatus
        print("\(TAG) => Authorization status: \(status)")
        
        switch status {
        case .notDetermined:
            print("\(TAG) => Requesting When In Use authorization")
            locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            print("\(TAG) => Location access denied or restricted")
        case .authorizedWhenInUse:
            print("\(TAG) => When in use authorization, requesting always")
            locationManager.requestAlwaysAuthorization()
        case .authorizedAlways:
            print("\(TAG) => Always authorization granted, starting updates")
            startLocationUpdates()
            scheduleLocationUpdates()
        @unknown default:
            print("\(TAG) => Unknown authorization status")
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print("\(self.TAG) => Authorization status changed")
        checkLocationAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("\(self.TAG) => Authorization status changed to: \(status.rawValue)")
        checkLocationAuthorization()
    }

       
       func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
           DispatchQueue.main.async {
               guard let location = locations.last else {
                   print("\(self.TAG) => No location data available")
                   return
               }
               self.saveLocationToUserDefaults(location)
               print("\(self.TAG) => Location updated: \(location.coordinate.latitude), \(location.coordinate.longitude)")
           }
       }
       
       func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
           print("\(TAG) => Error: \(error.localizedDescription)")
           if let clError = error as? CLError {
               switch clError.code {
               case .denied:
                   print("\(TAG) => Location access denied by user")
               case .network:
                   print("\(TAG) => Network error")
               default:
                   print("\(TAG) => Other Core Location error: \(clError.code)")
               }
           }
       }
       
       private func saveLocationToUserDefaults(_ location: CLLocation) {
           let lat = location.coordinate.latitude
           let lon = location.coordinate.longitude
           
//           userDefaults.set(lat, forKey: "userLatitude")
//           userDefaults.set(lon, forKey: "userLongitude")
           LocalStorage.shared.saveLocation(value:  String(format: "%.6f,%.6f", lat, lon))
           print("\(TAG) => Location saved: LAT: \(lat), LON: \(lon)")
       }
       

       
       func startLocationUpdates() {
           locationManager.startUpdatingLocation()
           print("\(TAG) => Started location updates")
       }
       
       func stopLocationUpdates() {
           locationManager.stopUpdatingLocation()
           print("\(TAG) => Stopped location updates")
       }
    
    
    func handleAppRefresh(task: BGAppRefreshTask) {
         print("\(TAG) => Handling app refresh task")
         
         // Schedule the next update
         scheduleLocationUpdates()
         
         // Store the background task
         backgroundTask = task
         
         // Set up an expiration handler
         task.expirationHandler = {
             print("\(self.TAG) => Background task is about to expire")
             self.backgroundTask = nil
             self.stopLocationUpdates()
         }
         
         // Start location updates
         startLocationUpdates()
         
         // Set up a timer to end the task after a certain duration
         DispatchQueue.main.asyncAfter(deadline: .now() + 25) { // 25 seconds
             print("\(self.TAG) => Finishing background task")
             self.stopLocationUpdates()
             task.setTaskCompleted(success: true)
             self.backgroundTask = nil
         }
     }
    
    
       private func scheduleLocationUpdates() {
           let request = BGAppRefreshTaskRequest(identifier: "io.ionic.starter.locationUpdate")
           request.earliestBeginDate = Date(timeIntervalSinceNow: 1 * 60) // 5 minutes from now
           
           do {
               try BGTaskScheduler.shared.submit(request)
               print("\(TAG) => Background task scheduled for location update")
           } catch {
               print("\(TAG) => Could not schedule app refresh: \(error)")
           }
       }
}
