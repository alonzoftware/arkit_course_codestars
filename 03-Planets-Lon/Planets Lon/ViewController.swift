//
//  ViewController.swift
//  Planets Lon
//
//  Created by Rene Alonzo Choque Saire on 6/3/22.
//

import UIKit
import ARKit
class ViewController: UIViewController {
    
    @IBOutlet weak var sceneView: ARSCNView!
    let configuration = ARWorldTrackingConfiguration()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sceneView.debugOptions = [ARSCNDebugOptions.showWorldOrigin, ARSCNDebugOptions.showFeaturePoints]
        self.sceneView.session.run(configuration)
        self.sceneView.autoenablesDefaultLighting = true
        
        
        
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        //        Earth
        //        let earth = SCNNode()
        //        earth.geometry = SCNSphere(radius: 0.2)
        //        earth.geometry?.firstMaterial?.diffuse.contents = #imageLiteral(resourceName: "EarthDay")//#imageLiteral(resourceName: "EarthNormal")
        //        earth.geometry?.firstMaterial?.specular.contents = #imageLiteral(resourceName: "EarthSpecular")
        //        earth.geometry?.firstMaterial?.emission.contents = #imageLiteral(resourceName: "EarthClouds")
        //        earth.geometry?.firstMaterial?.normal.contents = #imageLiteral(resourceName: "EarthNormal")
        //        earth.position = SCNVector3(0,0, -1)
        //        self.sceneView.scene.rootNode.addChildNode(earth)
        //        let action = SCNAction.rotateBy(x: 0, y: CGFloat(360.degreesToRadians), z: 0, duration: 10)
        //        let forever = SCNAction.repeatForever(action)
        //        earth.runAction(forever)
        //        Earth + Sun + Venus
        let sun = SCNNode(geometry: SCNSphere(radius: 0.35))
        sun.geometry?.firstMaterial?.diffuse.contents = #imageLiteral(resourceName: "SunDiffuse")
        sun.position = SCNVector3(0,0,-1)
        self.sceneView.scene.rootNode.addChildNode(sun)
        let earth = planet(geometry: SCNSphere(radius: 0.2), diffuse: #imageLiteral(resourceName: "EarthDay"), specular: #imageLiteral(resourceName: "EarthSpecular"), emission: #imageLiteral(resourceName: "EarthClouds"), normal: #imageLiteral(resourceName: "EarthNormal"), position: SCNVector3(1.2 ,0 , 0))
        let venus = planet(geometry: SCNSphere(radius: 0.1), diffuse: #imageLiteral(resourceName: "VenusDiffuse"), specular: nil, emission: #imageLiteral(resourceName: "VenusAtmosphere"), normal: nil, position: SCNVector3(0.7, 0, 0))
        sun.addChildNode(earth)
        sun.addChildNode(venus)
        
    }
    func planet(geometry: SCNGeometry, diffuse: UIImage, specular: UIImage?, emission: UIImage?, normal: UIImage?, position: SCNVector3) -> SCNNode {
        let planet = SCNNode(geometry: geometry)
        planet.geometry?.firstMaterial?.diffuse.contents = diffuse
        planet.geometry?.firstMaterial?.specular.contents = specular
        planet.geometry?.firstMaterial?.emission.contents = emission
        planet.geometry?.firstMaterial?.normal.contents = normal
        planet.position = position
        return planet
        
    }
    
}

extension Int {
    
    var degreesToRadians: Double { return Double(self) * .pi/180}
}