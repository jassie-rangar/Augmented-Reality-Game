//
//  SpaceShip.swift
//  AR Game
//
//  Created by Jaskirat Singh on 09/05/18.
//  Copyright © 2018 jassie. All rights reserved.
//

import ARKit

class SpaceShip: SCNNode {

    func loadModal() {
        guard let virtualObjectScene = SCNScene(named: "art.scnassets/ship.scn") else {
            return
        }
        
        let wrapperNode = SCNNode()
        
        for child in virtualObjectScene.rootNode.childNodes {
            wrapperNode.addChildNode(child)
        }
        self.addChildNode(wrapperNode)
    }
}
