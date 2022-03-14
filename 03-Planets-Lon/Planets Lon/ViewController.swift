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
        //        earth.geometry?.firstMaterial?.normal.contents = #imageLiteral(resourceName: "MoonDiffuse")
        //        earth.position = SCNVector3(0,0, -1)
        //        self.sceneView.scene.rootNode.addChildNode(earth)
        //        let action = SCNAction.rotateBy(x: 0, y: CGFloat(360.degreesToRadians), z: 0, duration: 10)
        //        let forever = SCNAction.repeatForever(action)
        //        earth.runAction(forever)
        //        Earth + Sun + Venus
        let sun = SCNNode(geometry: SCNSphere(radius: 0.35))
        let earthParent = SCNNode()
        let venusParent = SCNNode()
        let moonEarthParent = SCNNode()
        let moonVenusParent = SCNNode()
        
        sun.geometry?.firstMaterial?.diffuse.contents = #imageLiteral(resourceName: "SunDiffuse")
        sun.position = SCNVector3(0,0,-1)
        earthParent.position = SCNVector3(0,0,-1)
        venusParent.position = SCNVector3(0,0,-1)
        moonEarthParent.position = SCNVector3(1.2 ,0 , 0)
        moonVenusParent.position = SCNVector3(1.2 ,0 , 0)
        
        
        self.sceneView.scene.rootNode.addChildNode(sun)
        self.sceneView.scene.rootNode.addChildNode(earthParent)
        self.sceneView.scene.rootNode.addChildNode(venusParent)
        
        let earth = planet(geometry: SCNSphere(radius: 0.2), diffuse: #imageLiteral(resourceName: "EarthDay"), specular: #imageLiteral(resourceName: "EarthSpecular"), emission: #imageLiteral(resourceName: "EarthClouds"), normal: #imageLiteral(resourceName: "EarthNormal"), position: SCNVector3(1.2 ,0 , 0))
        let venus = planet(geometry: SCNSphere(radius: 0.1), diffuse: #imageLiteral(resourceName: "VenusDiffuse"), specular: nil, emission: #imageLiteral(resourceName: "VenusAtmosphere"), normal: nil, position: SCNVector3(0.7, 0, 0))
        let moonEarth = planet(geometry: SCNSphere(radius: 0.05), diffuse: #imageLiteral(resourceName: "MoonDiffuse"), specular: nil, emission: nil, normal: nil, position: SCNVector3(0,0,-0.3))
        let moonVenus = planet(geometry: SCNSphere(radius: 0.05), diffuse: #imageLiteral(resourceName: "MoonDiffuse"), specular: nil, emission: nil, normal: nil, position: SCNVector3(0,0,-0.3))
        
        //        Simple Animation
        //        let action = SCNAction.rotateBy(x: 0, y: CGFloat(360.degreesToRadians), z: 0, duration: 8)
        //        let forever = SCNAction.repeatForever(action)
        //        sun.runAction(forever)
        
        earthParent.addChildNode(earth)
        venusParent.addChildNode(venus)
        
        
        let sunAction = Rotation(time: 8)
        let earthParentRotation = Rotation(time: 14)
        let venusParentRotation = Rotation(time: 10)
        let earthRotation = Rotation(time: 8)
        let moonRotation = Rotation(time: 5)
        let venusRotation = Rotation(time: 8)
        
        
        earth.runAction(earthRotation)
        venus.runAction(venusRotation)
        earthParent.runAction(earthParentRotation)
        venusParent.runAction(venusParentRotation)
        moonEarthParent.runAction(moonRotation)
        moonVenusParent.runAction(moonRotation)
        
        
        sun.runAction(sunAction)
        earthParent.addChildNode(earth)
        earthParent.addChildNode(moonEarthParent)
        venusParent.addChildNode(venus)
        venusParent.addChildNode(moonVenusParent)
        
        earth.addChildNode(moonEarth)
        venus.addChildNode(moonVenus)
        
        
        moonEarthParent.addChildNode(moonEarth)
        moonVenusParent.addChildNode(moonVenus)
        
        
        
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
    func Rotation(time: TimeInterval) -> SCNAction {
        let Rotation = SCNAction.rotateBy(x: 0, y: CGFloat(360.degreesToRadians), z: 0, duration: time)
        let foreverRotation = SCNAction.repeatForever(Rotation)
        return foreverRotation
    }
}

extension Int {
    
    var degreesToRadians: Double { return Double(self) * .pi/180}
}
