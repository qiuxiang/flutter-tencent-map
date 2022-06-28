import QMapKit

class _TencentMapApi: NSObject, TencentMapApi {
    let mapView: QMapView

    init(_ mapView: QMapView) {
        self.mapView = mapView
    }

    func setMapTypeType(_ type: MapType, error _: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
        mapView.mapType = [
            MapType.dark: QMapType.dark,
            MapType.normal: QMapType.standard,
            MapType.satellite: QMapType.satellite,
        ][type] ?? QMapType.standard
    }

    func setCompassEnabledEnabled(_ enabled: NSNumber, error _: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
        mapView.showsCompass = enabled.boolValue
    }

    func setScaleControlsEnabledEnabled(_ enabled: NSNumber, error _: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
        mapView.showsScale = enabled.boolValue
    }

    func setRotateGesturesEnabledEnabled(_ enabled: NSNumber, error _: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
        mapView.isRotateEnabled = enabled.boolValue
    }

    func setScrollGesturesEnabledEnabled(_ enabled: NSNumber, error _: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
        mapView.isScrollEnabled = enabled.boolValue
    }

    func setZoomGesturesEnabledEnabled(_ enabled: NSNumber, error _: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
        mapView.isZoomEnabled = enabled.boolValue
    }

    func setTiltGesturesEnabledEnabled(_ enabled: NSNumber, error _: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
        mapView.isOverlookingEnabled = enabled.boolValue
    }

    func setIndoorViewEnabledEnabled(_ enabled: NSNumber, error _: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
        mapView.setIndoorEnabled(enabled.boolValue)
    }

    func setTrafficEnabledEnabled(_ enabled: NSNumber, error _: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
        mapView.showsTraffic = enabled.boolValue
    }

    func setBuildingsEnabledEnabled(_ enabled: NSNumber, error _: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
        mapView.showsBuildings = enabled.boolValue
    }

    func moveCameraPosition(_: [AnyHashable: Any], duration _: NSNumber, error _: AutoreleasingUnsafeMutablePointer<FlutterError?>) {}

    func pauseWithError(_: AutoreleasingUnsafeMutablePointer<FlutterError?>) {}

    func resumeWithError(_: AutoreleasingUnsafeMutablePointer<FlutterError?>) {}

    func startWithError(_: AutoreleasingUnsafeMutablePointer<FlutterError?>) {}

    func stopWithError(_: AutoreleasingUnsafeMutablePointer<FlutterError?>) {}

    func setMyLocationButtonEnabledEnabled(_: NSNumber, error _: AutoreleasingUnsafeMutablePointer<FlutterError?>) {}

    func setMyLocationEnabledEnabled(_ enabled: NSNumber, error _: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
        mapView.showsUserLocation = enabled.boolValue
    }

    func setMyLocationLocation(_: Location, error _: AutoreleasingUnsafeMutablePointer<FlutterError?>) {}

    func setMyLocationStyleStyle(_: MyLocationStyle, error _: AutoreleasingUnsafeMutablePointer<FlutterError?>) {}

    func move(_ position: CameraPosition, duration: NSNumber, error _: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
        let animated = duration.doubleValue > 0
        if let it = position.target?.latLng { mapView.setCenter(it, animated: animated) }
        if let it = position.zoom?.doubleValue { mapView.setZoomLevel(CGFloat(it), animated: animated) }
        if let it = position.tilt?.doubleValue { mapView.setOverlooking(CGFloat(it), animated: animated) }
        if let it = position.bearing?.doubleValue { mapView.setRotation(CGFloat(it), animated: animated) }
    }

    func add(_: PolylineOptions, error _: AutoreleasingUnsafeMutablePointer<FlutterError?>) -> String? {
        return ""
    }

    func add(_: MarkerOptions, error _: AutoreleasingUnsafeMutablePointer<FlutterError?>) -> String? {
        return ""
    }

    func destoryWithError(_: AutoreleasingUnsafeMutablePointer<FlutterError?>) {}
}
