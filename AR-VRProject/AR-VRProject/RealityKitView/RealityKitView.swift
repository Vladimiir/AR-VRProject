//
//  RealityKitView.swift
//  AR-VRProject
//
//  Created by Vladimir Stasenko on 06.10.2023.
//

import SwiftUI
import RealityKit
import ARKit
import FocusEntity

struct RealityKitView: UIViewRepresentable {
    
    @StateObject var vm = RealityKitViewModel()
    
    func makeUIView(context: Context) -> ARView {
        context.coordinator.view = vm.arView
        vm.arView.session.delegate = context.coordinator
        
        // Handle taps
        vm.arView.addGestureRecognizer(
            UITapGestureRecognizer(
                target: context.coordinator,
                action: #selector(Coordinator.handleTap)
            )
        )
        
        return vm.arView
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    func updateUIView(_ view: ARView, context: Context) {}
    
    class Coordinator: NSObject, ARSessionDelegate {
        weak var view: ARView?
        var focusEntity: FocusEntity?
        
        func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
            guard let view = self.view else { return }
            debugPrint("Anchors added to the scene: ", anchors)
            self.focusEntity = FocusEntity(on: view, style: .classic(color: .yellow))
        }
        
        @objc func handleTap() {
            guard let view = self.view, let focusEntity = self.focusEntity else { return }

            // Create a new anchor to add content to
            let anchor = AnchorEntity()
            view.scene.anchors.append(anchor)

            /*
            // Add a Box entity with a blue material
            let box = MeshResource.generateBox(size: 0.5, cornerRadius: 0.05)
            let material = SimpleMaterial(color: .blue, isMetallic: true)
            let diceEntity = ModelEntity(mesh: box, materials: [material])
            diceEntity.position = focusEntity.position
             */
            
            // Add a dice entity
            let diceEntity = try! ModelEntity.loadModel(named: "Dice")
            diceEntity.scale = [0.1, 0.1, 0.1]
            diceEntity.position = focusEntity.position
            
            let size = diceEntity.visualBounds(relativeTo: diceEntity).extents
            let boxShape = ShapeResource.generateBox(size: size)
            diceEntity.collision = CollisionComponent(shapes: [boxShape])
            
            diceEntity.physicsBody = PhysicsBodyComponent(massProperties: .init(shape: boxShape, mass: 50),
                                                          material: nil,
                                                          mode: .dynamic)
            
            diceEntity.addForce([0, 2, 0], relativeTo: nil)
            diceEntity.addTorque([Float.random(in: 0 ... 0.4),
                                  Float.random(in: 0 ... 0.4),
                                  Float.random(in: 0 ... 0.4)],
                                 relativeTo: nil)
            
            view.debugOptions = [.showAnchorOrigins, .showPhysics]
            
            anchor.addChild(diceEntity)
            
            // Create a plane below the dice
            let planeMesh = MeshResource.generatePlane(width: 2, depth: 2)
            let material = SimpleMaterial(color: .init(white: 1.0, alpha: 0.1), isMetallic: false)
            let planeEntity = ModelEntity(mesh: planeMesh, materials: [material])
            planeEntity.position = focusEntity.position
            planeEntity.physicsBody = PhysicsBodyComponent(massProperties: .default, material: nil, mode: .static)
            planeEntity.collision = CollisionComponent(shapes: [.generateBox(width: 2, height: 0.001, depth: 2)])
            planeEntity.position = focusEntity.position
            anchor.addChild(planeEntity)
        }
    }
}
