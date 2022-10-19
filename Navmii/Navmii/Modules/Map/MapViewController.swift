//
//  MapViewController.swift
//  Navmii
//
//  Created by Sergiy Kostrykin on 19/10/2022.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
        
    // MARK: - Properties?
    private let bottomPanelMinHeight: CGFloat = 60
    private let bottomPanelMaxTopOffset: CGFloat = 120
    private let bottomPanelMiddleFactor: CGFloat = 0.5
    private var mapView: MKMapView?
    private var bottomPanelOffset: CGFloat = 0
    private var filesViewController: FilesViewController?
    private var parserService: GPXParserService?
    private var selectedFile: String?
    
    // MARK: - Outlets
    @IBOutlet weak var mapContainerView: UIView!
    @IBOutlet weak var bottomPanelTapView: UIView!
    @IBOutlet weak var bottomPanelView: UIView!
    @IBOutlet weak var bottomPanelTopBar: UIView!
    @IBOutlet weak var bottomPanelHeightConstraint: NSLayoutConstraint!

    // MARK: - Actions
    @IBAction func bottomPanelSwipedDown(_ sender: Any) {
        hideBottomPanel(sender: sender)
    }
    
    @IBAction func bottomPanelSwipedUp(_ sender: Any) {
        showBottomPanel(sender: sender)
    }
    
    @IBAction func bottomPanelTapped(_ sender: Any) {
        showBottomPanel()
    }
    
    @IBAction func bottomPanelRightButtonClicked(_ sender: Any) {
    }
        
    @IBAction func bottonPanlePanGestureTriggered(_ sender: UIPanGestureRecognizer) {
        dragBottomPanel(sender: sender)
    }
    
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        bottomPanelView?.layer.cornerRadius = 20
        bottomPanelTopBar?.layer.cornerRadius = 2.5
        setupMap()
        showFilesList()
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            self?.resizeBottomPanel()
        }
    }
}

private extension MapViewController {

    func setupMap() {
        mapView = MKMapView(frame: .zero)
        mapView?.mapType = .hybrid
        mapView?.delegate = self
        mapView?.showsUserLocation = true
        mapView?.showsCompass = false
        mapView?.embed(in: mapContainerView)
        let button = MKUserTrackingButton(mapView: mapView)
        mapContainerView.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.trailingAnchor.constraint(equalTo: mapContainerView.trailingAnchor, constant: -20),
            button.topAnchor.constraint(equalTo: mapContainerView.topAnchor, constant: 20),
            button.widthAnchor.constraint(equalToConstant: 35),
            button.heightAnchor.constraint(equalToConstant: 35)
        ])
        button.backgroundColor = .white
        button.layer.cornerRadius = 4
        button.tintColor = .colorLightBlue
    }
    
    func focusCamera(coordinate: CLLocationCoordinate2D, distance: CLLocationDistance = 2000) {
        guard let mapView = mapView else { return }
        let camera = MKMapCamera(lookingAtCenter: coordinate, fromDistance: min(distance, mapView.camera.altitude), pitch: 0, heading: 0)
        mapView.setCamera(camera, animated: true)
    }

    func drawTrack(file: String) {
        mapView?.removeOverlays(mapView?.overlays ?? [])
        mapView?.removeAnnotations(mapView?.annotations ?? [])
        
        parserService = GPXParserService()
        parserService?.parse(file) { [weak self] coordinates, error in
            if let error = error {
                let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self?.present(alert, animated: true)
            } else if let coordinates = coordinates {
                let polyline = MKPolyline(coordinates: coordinates, count: coordinates.count)
                let polygon = MKPolygon(coordinates: coordinates, count: coordinates.count)
                self?.mapView?.addOverlay(polyline)
                self?.mapView?.addOverlay(polygon)
                
                self?.mapView?.setCameraPosition(coordinate: polygon.coordinate, zoomLevel: 10, animated: true)
                self?.setVisibleMapArea(polyline: polygon, edgeInsets: UIEdgeInsets(top: 50, left: 50, bottom: 50, right: 50))
                
                if let first = coordinates.first {
                    let mapPoint = MKPointAnnotation()
                    mapPoint.coordinate = first
                    self?.mapView?.addAnnotation(mapPoint)
                }
                
                if let last = coordinates.last {
                    let mapPoint = MKPointAnnotation()
                    mapPoint.coordinate = last
                    self?.mapView?.addAnnotation(mapPoint)
                }
                self?.parserService = nil
            }
        }
    }
    
    func setVisibleMapArea(polyline: MKPolygon, edgeInsets: UIEdgeInsets, animated: Bool = true) {
        mapView?.setVisibleMapRect(polyline.boundingMapRect, edgePadding: edgeInsets, animated: animated)
    }
    
    func setCameraPosition(coordinate: CLLocationCoordinate2D, distance: CLLocationDistance = 2) {
        let camera = MKMapCamera(lookingAtCenter: coordinate, fromDistance: distance, pitch: 0, heading: 0)
        mapView?.setCamera(camera, animated: true)
    }
    
    // MARK: - Navigation
    func showBottomPanel(sender: Any? = nil) {

        let middleValue = view.bounds.height * 0.5
        if bottomPanelHeightConstraint.constant == middleValue, sender is UISwipeGestureRecognizer {
            bottomPanelHeightConstraint.constant = view.bounds.height - 120
        } else {
            bottomPanelHeightConstraint.constant = middleValue
        }
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.view.layoutIfNeeded()
        }
        bottomPanelTapView?.isHidden = true
    }
    
    func hideBottomPanel(sender: Any? = nil) {
        let middleValue = view.bounds.height * bottomPanelMiddleFactor
        if sender is UISwipeGestureRecognizer, bottomPanelHeightConstraint.constant != middleValue {
            bottomPanelHeightConstraint.constant = middleValue
        } else {
            bottomPanelHeightConstraint.constant = bottomPanelMinHeight
        }

        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.view.layoutIfNeeded()
        }
        bottomPanelTapView?.isHidden = false
    }
    
    func resizeBottomPanel() {
        if bottomPanelHeightConstraint.constant == view.bounds.width - bottomPanelMaxTopOffset {
            bottomPanelHeightConstraint.constant = view.bounds.height - bottomPanelMaxTopOffset
        } else if bottomPanelHeightConstraint.constant == view.bounds.width * bottomPanelMiddleFactor {
            bottomPanelHeightConstraint.constant = view.bounds.height * bottomPanelMiddleFactor
        }
        view.layoutIfNeeded()
    }
    
    func dragBottomPanel(sender: UIPanGestureRecognizer) {
        let maxValue = view.bounds.height - bottomPanelMaxTopOffset
        let translation = sender.translation(in: sender.view)
        switch sender.state {
        case .began:
            bottomPanelOffset = bottomPanelHeightConstraint.constant
        case .changed:
            var newValue = bottomPanelHeightConstraint.constant - translation.y
            newValue = min(maxValue, newValue)
            newValue = max(bottomPanelMinHeight, newValue)
            bottomPanelHeightConstraint.constant = newValue
            sender.setTranslation(.zero, in: sender.view)
            view.layoutIfNeeded()
        case .ended:
            let middleValue = view.bounds.height * bottomPanelMiddleFactor
            if bottomPanelHeightConstraint.constant > middleValue {
                bottomPanelHeightConstraint.constant = bottomPanelHeightConstraint.constant > bottomPanelOffset ? maxValue : middleValue
            } else {
                bottomPanelHeightConstraint.constant = bottomPanelHeightConstraint.constant > bottomPanelOffset ? middleValue : bottomPanelMinHeight
            }
            UIView.animate(withDuration: 0.3) { [weak self] in
                self?.view.layoutIfNeeded()
            }
        default:
            break
        }
    }

    func showFilesList() {
        guard let bottomPanelView = bottomPanelView else { return }
        let controller = FilesViewController() { [weak self] file in
            self?.drawTrack(file: file)
            self?.hideBottomPanel()
        }
        addChild(controller)
        controller.view?.embed(in: bottomPanelView)
        controller.didMove(toParent: self)
        filesViewController = controller
        bottomPanelView.sendSubviewToBack(controller.view)
    }
    
}

// MARK: - MKMapViewDelegate
extension MapViewController: MKMapViewDelegate {
            
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let color = UIColor.colorRandom
        if let polyline = overlay as? MKPolyline {
            let polylineRenderer = MKPolylineRenderer(overlay: polyline)
            polylineRenderer.strokeColor = color
            polylineRenderer.lineWidth = 1
            return polylineRenderer
        } else if let polygon = overlay as? MKPolygon {
            let polygonView = MKPolygonRenderer(overlay: polygon)
            polygonView.strokeColor = color
            polygonView.fillColor = polygonView.strokeColor!.withAlphaComponent(0.3)
            polygonView.lineWidth = 1
            return polygonView
        }
        return MKPolylineRenderer(overlay: overlay)
    }
    
}


// MARK: - Instantiation
extension MapViewController {
    class func instantiate() -> MapViewController {
        let controller = MapViewController.instantiate(storyboard: "Map") as! MapViewController
        return controller
    }
}
