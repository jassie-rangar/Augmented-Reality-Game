//
//  ViewController.swift
//  AR Game
//
//  Created by Jaskirat Singh on 09/05/18.
//  Copyright © 2018 jassie. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    // MARK: IBOutlets.
    @IBOutlet var sceneView: ARSCNView!
    @IBOutlet weak var label: UILabel!
    
    var counter:Int = 0 {
        didSet {
            label.text = "\(counter)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: Assigning scene to the view.
        let scene = SCNScene()
        sceneView.scene = scene
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // MARK: Create a session configuration.
        let configuration = ARWorldTrackingConfiguration()

        // MARK: Run the view's session.
        sceneView.session.run(configuration)
        
        addObject()
    }
    
    func addObject() {
        let ship = SpaceShip()
        ship.loadModal()
        
        let xPos = randomPosition(lowerBound: -1.5, upperBound: 1.5)
        let yPos = randomPosition(lowerBound: -1.5, upperBound: 1.5)
        
        ship.position = SCNVector3(xPos, yPos, -1)
        
        sceneView.scene.rootNode.addChildNode(ship)
    }
    
    func randomPosition(lowerBound lower: Float, upperBound upper: Float)-> Float {
        return Float(arc4random()) / Float(UInt32.max) * (lower - upper) + upper
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: sceneView)
            let hitList = sceneView.hitTest(location, options: nil)
            
            if let hitObject = hitList.first {
                let node = hitObject.node
                
                if node.name == "shipMesh" {
                    counter += 1
                    node.removeFromParentNode()
                    addObject()
                }
            }
        }
    }
     
}
