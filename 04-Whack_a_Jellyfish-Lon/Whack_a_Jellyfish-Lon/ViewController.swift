//
//  ViewController.swift
//  Whack_a_Jellyfish-Lon
//
//  Created by Rene Alonzo Choque Saire on 20/3/22.
//

import UIKit
import ARKit

class ViewController: UIViewController {
    
    @IBOutlet weak var SceneView: ARSCNView!
    @IBOutlet weak var play: UIButton!
    let configuration = ARWorldTrackingConfiguration()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.SceneView.debugOptions = [ARSCNDebugOptions.showWorldOrigin, ARSCNDebugOptions.showFeaturePoints]
        self.SceneView.session.run(configuration)
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.SceneView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @IBAction func play(_ sender: Any) {
        self.addNode()
        self.play.isEnabled = false
    }
    
    @IBAction func reset(_ sender: Any) {
        
        
    }
    func addNode() {
        //        let node = SCNNode(geometry: SCNBox(width: 0.2, height: 0.2, length: 0.2, chamferRadius: 0))
        //        node.position = SCNVector3(0,0,-1)
        //        node.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
        //        self.SceneView.scene.rootNode.addChildNode(node)
        let jellyFishScene = SCNScene(named: "Art.scnassets/Jellyfish.scn")
        let jellyfishNode = jellyFishScene?.rootNode.childNode(withName: "Jellyfish", recursively: false)
        jellyfishNode?.position = SCNVector3(0,0,-1)
        self.SceneView.scene.rootNode.addChildNode(jellyfishNode!)
        
    }
    @objc func handleTap(sender: UITapGestureRecognizer) {
        let sceneViewTappedOn = sender.view as! SCNView
        let touchCoordinates = sender.location(in: sceneViewTappedOn)
        let hitTest = sceneViewTappedOn.hitTest(touchCoordinates)
        if hitTest.isEmpty {
            print("didn't touch anything")
        } else {
            let results = hitTest.first!
            //            let geometry = results.node.geometry
            //            print(geometry)
            
            let node = results.node
            if node.animationKeys.isEmpty {
                self.animateNode(node: node)
            }
        }
    }
    func animateNode(node: SCNNode) {
        let spin = CABasicAnimation(keyPath: "position")
        spin.fromValue = node.presentation.position
        spin.toValue = SCNVector3(node.presentation.position.x - 0.5 ,node.presentation.position.y - 0.5, node.presentation.position.z - 0.5)
        spin.duration = 3
        spin.repeatCount = 5
        spin.autoreverses = true
        node.addAnimation(spin, forKey: "postion")
    }
}
