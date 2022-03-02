//
//  ViewController.swift
//  ARkitPositions
//
//  Created by Alonzo Choque on 1/3/22.
//

import UIKit
import ARKit

class ViewController: UIViewController {

    @IBOutlet weak var sceneView: ARSCNView!
    let configuration = ARWorldTrackingConfiguration()
    let boxNode = SCNNode(geometry: SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0))
    let pyramidNode = SCNNode(geometry: SCNPyramid(width: 0.1, height: 0.1, length: 0.1))
    let planeNode = SCNNode(geometry: SCNPlane(width: 0.05, height: 0.06))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // Create Scene
        self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
        self.sceneView.session.run(configuration)
        self.sceneView.autoenablesDefaultLighting = true
        
        
    }

    @IBAction func addBox(_ sender: Any) {
        self.boxNode.geometry?.firstMaterial?.diffuse.contents = UIColor.orange
        self.boxNode.position = SCNVector3(0, 0, -0.2)
        self.sceneView.scene.rootNode.addChildNode(self.boxNode)
    }
    @IBAction func addPyramid(_ sender: Any) {
        self.pyramidNode.geometry?.firstMaterial?.diffuse.contents = UIColor.systemIndigo
        self.pyramidNode.position = SCNVector3(0, 0.05, -0.2)
        self.sceneView.scene.rootNode.addChildNode(self.pyramidNode)
    }
    
    @IBAction func addPlane(_ sender: Any) {
        self.planeNode.geometry?.firstMaterial?.diffuse.contents = UIColor.systemBlue
        self.planeNode.position = SCNVector3(0, -0.02, -0.149)
        self.sceneView.scene.rootNode.addChildNode(self.planeNode)
    }
    @IBAction func addAll(_ sender: Any) {
        self.boxNode.geometry?.firstMaterial?.diffuse.contents = UIColor.orange
        self.boxNode.position = SCNVector3(0, 0.1, -0.2)
        self.pyramidNode.geometry?.firstMaterial?.diffuse.contents = UIColor.systemIndigo
        self.pyramidNode.position = SCNVector3(0, 0.05, 0)
        self.planeNode.geometry?.firstMaterial?.diffuse.contents = UIColor.systemBlue
        self.planeNode.position = SCNVector3(0, -0.02, 0.052)
        
        self.boxNode.addChildNode(self.pyramidNode)
        self.boxNode.addChildNode(self.planeNode)
        self.sceneView.scene.rootNode.addChildNode(self.boxNode)
        
        
    }
}

