//
//  RandomScene.swift
//  Projekt
//
//  Created by Magdaléna Klimešová on 04.01.2024.
//

import SpriteKit
import GameplayKit
import SwiftUI
import CoreMotion

class GameScene: SKScene {
    var gameState: GKStateMachine
    private var character: CharacterNode!
    //private var woods: [WoodNode]!
    private var woods = [SKSpriteNode]()
    private var bat: BatNode!
    private var bottom: SKShapeNode!
    private var motionManager: CMMotionManager!
    private var score: ScoreNode!
    private var first: Bool = false
    init(
        size: CGSize,
        gameState: GKStateMachine
    ) {
        self.gameState = gameState
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func didMove(to view: SKView) {
        self.backgroundColor = UIColor.white
        motionManager = CMMotionManager()
        motionManager.startAccelerometerUpdates()
        
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVector(dx: 0, dy: -9.8)
        layoutScene()
       
    }
    
    func layoutScene(){
        addBottom()
        makeWoods()
        spawnCharacter()
        addScoreCounter()
        createBat()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       
    }
    
    // BOTTOM
    func addBottom() {
           bottom = SKShapeNode(rectOf: CGSize(width: frame.width*2, height: 20))
           bottom.position = CGPoint(x: frame.midX, y: 10)
            bottom.fillColor = UIColor.black
           bottom.strokeColor = bottom.fillColor
           bottom.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: frame.width, height: 17))
           bottom.physicsBody?.affectedByGravity = false
           bottom.physicsBody?.isDynamic = false
        bottom.physicsBody?.categoryBitMask = Physics.CategoryBitMask.wood
      //  bottom.physicsBody?.collisionBitMask = Physics.CollisionBitMask.bottom
           addChild(bottom)
       }
    
    // WOODS
    
    func makeWoods(){
        var wood = SKSpriteNode(imageNamed: Assets.Textures.wood)
        wood.scale(to: CGSize(width: size.width/3, height: size.height/3))
        var platformsY: [CGFloat] = []
//        var min = 80
//        var max = 80
        let firstPlatformY = Level.spaceBetween.hard - 5
        platformsY.append(firstPlatformY)
        
        for i in 0...8{
            var spaceBetween = Level.spaceBetween.easy  //CGFloat.random(in: CGFloat(min)...CGFloat(max))
            var nextY = platformsY[i] + spaceBetween
            platformsY.append(nextY)
        }
        
        for y in platformsY {
            let x = CGFloat.random(in: wood.size.width/2...frame.size.width-wood.size.width/2)
            spawnWood(at: CGPoint(x: x, y: y))
        }
        
    }
    
    func spawnWood(at position: CGPoint){
        var wood = SKSpriteNode()
        wood = SKSpriteNode(imageNamed: Assets.Textures.wood)
        wood.scale(to: CGSize(width: wood.size.width/3, height: wood.size.height/3))
        wood.position = position
        wood.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: wood.size.width, height: wood.size.height))
        wood.physicsBody?.isDynamic = false
        wood.physicsBody?.affectedByGravity = false
        
        wood.physicsBody?.categoryBitMask = Physics.CategoryBitMask.wood
        woods.append(wood)
        addChild(wood)
    }
    
    // CHARACTER
    func spawnCharacter(){
        character = initCharacter() as? CharacterNode
        character.position = CGPoint(x: frame.midX, y:size.height/2)
        character.accessibilityIdentifier = "characterNode"
        addChild(character)
        
    }
    
    func initCharacter() -> SKSpriteNode{
        if(isCustomSet()){
            return CharacterNode(isCustom: true)
        } else {
            return CharacterNode(isCustom: false)
        }
    }
    
    func isCustomSet() -> Bool {
        return UserDefaults.standard.bool(forKey: "customCharacter")
    }
    
    //SCORE COUNTER
    func addScoreCounter(){
        score = ScoreNode()
        score.position = CGPoint(x: frame.width - 20, y: frame.height-20)
        addChild(score)
    }
    
    func setScore(){
        let oldScore = Int(score.text ?? "0")!
        var currentScore = (Int(character.position.y) - Int(character.size.height/2)) - (Int(bottom.position.y) - Int(bottom.frame.size.height)/2)
        if currentScore > oldScore {
            score.text = "\(currentScore)"
        }
        
    }
    
    func saveScoreToUserDefaults(currentScore: Int){
        var allSavedScores: [Int] = []
        for i in UserDefaultsKeys.ScoreKeys.allValues {
            allSavedScores.append(UserDefaults.standard.integer(forKey: i))
        }
        allSavedScores.append(currentScore)
        
        allSavedScores = allSavedScores.sorted{
            $0 > $1
        }
        
        for (index, scoreKey) in UserDefaultsKeys.ScoreKeys.allValues.enumerated() {
            UserDefaults.standard.set(allSavedScores[index], forKey: scoreKey)
        }
        
        UserDefaults.standard.set(currentScore, forKey: UserDefaultsKeys.ScoreKeys.currentScore)
        print("\(allSavedScores)")
    }
    
    
    
    // UPDATE
    override func update(_ currentTime: TimeInterval) {
        checkTabletTilt()
        checkCharacterPosition()
        updateWoodsPositions()
        if let currentScore = Int(score.text!){
            if currentScore > Level.score.hard {
                updateBat()
            }
        }
    }
    
    func checkCharacterPosition(){
        // GAME OVER
        if (character.position.y+character.size.width) < 0 {
            var bestScore = UserDefaults.standard.integer(forKey: UserDefaultsKeys.ScoreKeys.firstPlace)
            if let scoreInt = Int(score.text!){
                if scoreInt > bestScore {
                    // NEW RECORD. GAME STATE NEW RECORD
                    saveScoreToUserDefaults(currentScore: scoreInt)
                    gameState.enter(GameNewRecordState.self)
                } else {
                    // GAME STATE FINISED
                    saveScoreToUserDefaults(currentScore: scoreInt)
                    gameState.enter(GameStateFinished.self)
                    
                }
            }
            
        }
        //SCORE
        setScore()
        
        // BEHIND SCENE LEFT OR RIGHT
        if (character.position.x-character.size.width) >= frame.size.width || (character.position.x+character.size.width) <= 0 {
            fixCharacterPosition()
        }
    }
    
    func fixCharacterPosition(){
        let characterWidth = character.size.width
        if character.position.x >= frame.size.width {
            character.position.x = 0 - characterWidth/2+1
        } else {
            character.position.x = frame.size.width + characterWidth/2-1
        }
    }
    
    //PLATFORM POSITIONING
    func updateWoodsPositions() {
        let minimumHeight: CGFloat = frame.size.height/2
        guard let characterVelocity = character.physicsBody?.velocity.dy else {
            return
        }
        let distance = characterVelocity/70 //50
        if character.position.y > minimumHeight && characterVelocity > 0 {
            for (index, wood) in woods.enumerated() {
                wood.position.y -= distance
                if wood.position.y < 0-wood.frame.size.height/2 {
                    if (index == 0){
                        update(currentPlatform: wood, previousPlatform: woods.last!)
                    } else {
                        update(currentPlatform: wood, previousPlatform: woods[index-1])
                    }
                }
            }
            bottom.position.y -= distance
        }
    }
    
    func update(currentPlatform: SKSpriteNode, previousPlatform: SKSpriteNode){
        var newY = previousPlatform.position.y
        var newX = CGFloat.random(in: currentPlatform.size.width/2...frame.size.width-currentPlatform.size.width/2)
        if let scoreInt = Int(score.text!){
            switch scoreInt {
            case 0...Level.score.easy:
                
                makeUpdatePlatform(currentPlatform: currentPlatform, newY: newY + Level.spaceBetween.easy,
                                   imageNamed: Assets.Textures.wood, categoryBitMask: Physics.CategoryBitMask.wood,
                                   name: NodeNames.wood, newX: newX)
             
            case Level.score.easy ... Level.score.medium:
                makeUpdatePlatform(currentPlatform: currentPlatform, newY: newY + Level.spaceBetween.medium,
                                   imageNamed: Assets.Textures.wood, categoryBitMask: Physics.CategoryBitMask.wood,
                                   name: NodeNames.wood, newX: newX)
          
            case Level.score.medium ... Level.score.hard:
                makeUpdatePlatform(currentPlatform: currentPlatform, newY: newY + Level.spaceBetween.hard,
                                   imageNamed: Assets.Textures.wood, categoryBitMask: Physics.CategoryBitMask.wood,
                                   name: NodeNames.wood, newX: newX)
               
            case Level.score.hard ... Level.score.movingPlatforms:
                makeUpdatePlatform(currentPlatform: currentPlatform, newY: newY + Level.spaceBetween.medium,
                                   imageNamed: Assets.Textures.cloud, categoryBitMask: Physics.CategoryBitMask.wood,
                                   name: NodeNames.cloud, newX: newX)
            case Level.score.movingPlatforms ... Level.score.disappearingPlatforms:
                makeUpdatePlatform(currentPlatform: currentPlatform, newY: newY + Level.spaceBetween.medium,
                                   imageNamed: Assets.Textures.rocketLeft, categoryBitMask: Physics.CategoryBitMask.wood,
                                   name: NodeNames.rocket, newX: newX)
            default:
                makeUpdatePlatform(currentPlatform: currentPlatform, newY: newY + Level.spaceBetween.medium,
                                   imageNamed: Assets.Textures.rocketRight, categoryBitMask: Physics.CategoryBitMask.wood,
                                   name: NodeNames.rocket, newX: newX)
            }
        }
        //var newY = previousPlatform.position.y + CGFloat(80)
        
    }
    
    func makeUpdatePlatform(currentPlatform: SKSpriteNode, newY: CGFloat, imageNamed: String, categoryBitMask: UInt32, name: String, newX: CGFloat){
        currentPlatform.position.x = newX
        currentPlatform.removeAllActions()
        currentPlatform.alpha = 1.0
        currentPlatform.texture = SKTexture(imageNamed: imageNamed)
        currentPlatform.physicsBody?.categoryBitMask = categoryBitMask
        currentPlatform.physicsBody?.isDynamic = false
        currentPlatform.physicsBody?.affectedByGravity = false
        currentPlatform.position.y = newY
        
        if (name == NodeNames.cloud){
            if currentPlatform.position.x > frame.midX {
                currentPlatform.position.x = frame.size.width
                movingAnimationCloud(platform: currentPlatform, isLeft: false, duration: 3.5)
            } else {
                currentPlatform.position.x = 0
                movingAnimationCloud(platform: currentPlatform, isLeft: true, duration: 3.5)
            }
        }
        
        if (name == NodeNames.rocket){
            if currentPlatform.position.x > frame.midX {
                currentPlatform.position.x = frame.size.width
                movingAnimationRocket(platform: currentPlatform, isLeft: false, duration: 2)
            } else {
                currentPlatform.position.x = 0
                movingAnimationRocket(platform: currentPlatform, isLeft: true, duration: 2)
            }
        }
        
    }
    
    //ANIMATIONS
    
    func movingAnimationRocket(platform: SKSpriteNode, isLeft: Bool, duration: Double){
        let distanceX = isLeft ? frame.size.width: -frame.size.width
        if (isLeft){
            platform.run(.repeatForever(.sequence([
                .setTexture(SKTexture(imageNamed: Assets.Textures.rocketRight)),
                .moveBy(x: distanceX, y: 0, duration: duration),
                .setTexture(SKTexture(imageNamed: Assets.Textures.rocketLeft)),
                .moveBy(x: -distanceX, y: 0, duration: duration),
            ])))
        } else {
            platform.run(.repeatForever(.sequence([
                .setTexture(SKTexture(imageNamed: Assets.Textures.rocketLeft)),
                .moveBy(x: distanceX, y: 0, duration: duration),
                .setTexture(SKTexture(imageNamed: Assets.Textures.rocketRight)),
                .moveBy(x: -distanceX, y: 0, duration: duration),
            ])))
        }

    }
    
    
    func movingAnimationCloud(platform: SKSpriteNode, isLeft: Bool, duration: Double){
        let distanceX = isLeft ? frame.size.width: -frame.size.width
        platform.run(.repeatForever(.sequence([
            .moveBy(x: distanceX, y: 0, duration: duration),
            .moveBy(x: -distanceX, y: 0, duration: duration),
        ])))
    }
    
    // CREATURE
    
    func createBat(){
        bat = BatNode()
        bat.position = CGPoint(x:0 - bat.size.width, y: 0-bat.size.height)
        addChild(bat)
    }
    func spawnBat(){
        bat.removeAllActions()
        var randomX = CGFloat.random(in: CGFloat(0)...CGFloat(frame.width))
        bat.position = CGPoint(x: randomX, y: frame.height)
        //zmenit rotaci kdyz bude cas
        bat.zRotation = .pi
        bat.run(.moveBy(x: (character.position.x - randomX)*10, y: -character.position.y*10, duration: 7))
        first = true
    }
    
    func checkBatPosition(){
        if (bat.position.y < 0){
            spawnBat()
        }
    }
    
    func updateBat(){
        var random = GKRandomSource.sharedRandom().nextInt(upperBound:800)
        if (random == 1){
            if(first == false){
                spawnBat()
            } else {
                checkBatPosition()
            }
        }
    }
    
    //CHECKING TABLET TILT
    func checkTabletTilt(){
        if motionManager.isDeviceMotionAvailable {
            motionManager.showsDeviceMovementDisplay = true
            motionManager.startDeviceMotionUpdates(using: .xMagneticNorthZVertical)
            if let data = self.motionManager.deviceMotion {
                                let y = data.attitude.roll
                self.character.physicsBody?.velocity.dx = 2000 * y
                                
                            }
        }
    }
    
}

extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        guard gameState.currentState is GameStateRunning else {
                    return
                }
        
        let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        if let characterVelocity = character.physicsBody?.velocity.dy{
            if characterVelocity < 0 { // CHARACTER IS FALLING
                if contactMask == Physics.CategoryBitMask.character | Physics.CategoryBitMask.wood{
                    var newVelocity = frame.size.height*1.3 - character.position.y
                    character.physicsBody?.velocity.dy = newVelocity
                    
                }
            }
        }
        
        if contactMask == Physics.CategoryBitMask.character | Physics.CategoryBitMask.bat {
            character.run(.rotate(byAngle: 3, duration: 3))
            character.physicsBody?.categoryBitMask = Physics.CategoryBitMask.hitByBat
        }
        
    }
}
