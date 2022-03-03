//
//  ViewController.swift
//  World Tracking Lon
//
//  Created by Rene Alonzo Choque Saire on 17/2/22.
//

import UIKit
import ARKit

class ViewController: UIViewController {

    @IBOutlet weak var sceneView: ARSCNView!
    let configuration = ARWorldTrackingConfiguration()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
        self.sceneView.session.run(configuration)
        self.sceneView.autoenablesDefaultLighting = true
        // Do any additional setup after loading the view.
    }

    @IBAction func add(_ sender: Any) {
        let node = SCNNode()
        
//        Cube
//        node.geometry = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0)
//        Rounded Cube
//        node.geometry = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0.03)
//        Sphere from Cube
//        node.geometry = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 1/0.5)
//        Capsule
//        node.geometry = SCNCapsule(capRadius: 0.1, height: 0.3)
//        Cone
//        node.geometry = SCNCone(topRadius: 0.1, bottomRadius: 0.2, height: 0.3)
//        Cylinder
//        node.geometry = SCNCylinder(radius: 0.2, height: 03)
//        Sphere
//        node.geometry = SCNSphere(radius: 0.2)
//        Tube
//        node.geometry = SCNTube(innerRadius: 0.1, outerRadius: 0.2, height: 0.3)
//        Torus
//        node.geometry = SCNTorus(ringRadius: 0.3, pipeRadius: 0.1)
//        Plane
//        node.geometry = SCNPlane(width: 0.1, height: 0.1)
//        Pyramid
//        node.geometry = SCNPyramid(width: 0.1, height: 0.2, length: 0.1)
//        Bezier Path
//        let path = UIBezierPath()
//        path.move(to: CGPoint(x: 0, y: 0))
//        path.addLine(to: CGPoint(x:0, y: 0.2))
//        path.addLine(to: CGPoint(x: 0.2, y:0.3))
//        path.addLine(to: CGPoint(x: 0.4, y: 0.2))
//        path.addLine(to: CGPoint(x: 0.4, y: 0))
//        let shape = SCNShape(path: path, extrusionDepth: 0.2)
//        node.geometry = shape
        
        let cylinderNode = SCNNode(geometry: SCNCylinder(radius: 0.05, height: 0.05))
        cylinderNode.geometry?.firstMaterial?.diffuse.contents = UIColor.red
        let doorNode = SCNNode(geometry: SCNPlane(width: 0.03, height: 0.06))
        doorNode.geometry?.firstMaterial?.diffuse.contents = UIColor.brown
        let boxNode = SCNNode(geometry: SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0))
        boxNode.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
        
        
        node.geometry = SCNPyramid(width: 0.1, height: 0.1, length: 0.1)
        node.geometry?.firstMaterial?.specular.contents = UIColor.orange
        node.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
        
//        let x = randomNumbers(firstNum: -0.3, secondNum: 0.3)
//        let y = randomNumbers(firstNum: -0.3, secondNum: 0.3)
//        let z = randomNumbers(firstNum: -0.6, secondNum: -0.4)
//        node.position = SCNVector3(x,y,z)
        node.position = SCNVector3(0.2,0.3,-0.2)
        cylinderNode.position = SCNVector3(0,0,-0.1)
        boxNode.position = SCNVector3(0, -0.05, 0)
                doorNode.position = SCNVector3(0,-0.02,0.053)
        
//        Relative Position
        node.addChildNode(cylinderNode)
        node.addChildNode(boxNode)
        boxNode.addChildNode(doorNode)
//      Rotation
        node.eulerAngles = SCNVector3(90.degreesToRadians,0,0)
        self.sceneView.scene.rootNode.addChildNode(node)

//        self.sceneView.scene.rootNode.addChildNode(cylinderNode)
    }
    
    @IBAction func reset(_ sender: Any) {
        self.restartSession()
    }
    func restartSession() {
            self.sceneView.session.pause()
            self.sceneView.scene.rootNode.enumerateChildNodes { (node, _) in
                node.removeFromParentNode()
            }
            self.sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
        
            
        }
    func randomNumbers(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat {
            return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
        }
    
}
extension Int{
    var degreesToRadians: Double{return Double(self) * .pi/180}
}
