//
//  ViewController.swift
//  DungeonRaidClone
//
//  Created by bumface on 1/6/20.
//  Copyright © 2020 bumface. All rights reserved.
//

import UIKit
import UIKit.UIGestureRecognizerSubclass
import AVFoundation
//import SpriteKit
//
//class GameScene: SKScene
//{
//    var myScene = SKScene()
//    var myTiles = SKTileSet()
//    var myTileMapNode = SKTileMapNode!
//    myScene = SKScene(size: CGSize(width: screenWidth, height: screenHeight))
//
//            guard let myTileMapNode = childNode(withName: "myTiles")
//                                           as? SKTileMapNode else {
//              fatalError("Background node not loaded")
//            }
//            self.myTileMapNode = myTileMapNode
//    //        self.myTileMapNode = myScene.childNode(withName: "myTiles") as? SKTileMapNode
//
//    //        myTileMapNode?.tileSet = SKTileSet(named: "myTiles")!
//            myTileMapNode?.tileSize = CGSize(width: screenWidth/6, height: screenWidth/6)
//            myTileMapNode?.numberOfRows = 6
//            myTileMapNode?.numberOfColumns = 6
//            myScene.addChild(myTileMapNode!)
//}

class ViewController: UIViewController
{
    var toggleSound = UIButton(), toggleMenu = UIButton()
    var soundEnabled = false, menuEnabled = false, skillJustUsed = false, usingSkill = false
    var goldPlayer  = [AVAudioPlayer](), armorPlayer = [AVAudioPlayer](), swordPlayer = [AVAudioPlayer](), HPPlayer = [AVAudioPlayer](), skullPlayer = [AVAudioPlayer](), myPlayers = [[AVAudioPlayer]]()
    var soundCount = 0
    var soundArray = [["Gold1", "Gold2", "Gold3"], ["Armor1", "Armor2", "Armor3", "Armor4"], ["Sword1", "Sword2", "Sword3"], ["HP1", "HP2", "HP3", "HP4"], ["Skull1", "Skull2"]]    // Array of all sounds
    var pathWidth = CGFloat(3.0), moveDuration = 0.05, consumeDuration = 0.4//5
    var upgradeMenuArray = [CAShapeLayer](), upgradeMenuDimRect = CAShapeLayer(), upgradeMenu = CAShapeLayer(), upgradeMenuLayer2 = CAShapeLayer(), upgradeMenuLayer3 = CAShapeLayer(), upgradeConfirm = CAShapeLayer(), upgradeConfirm2 = CAShapeLayer(), upgradeConfirm3 = CAShapeLayer()
    var upgradeIcons = [[CAShapeLayer]](), upgradeButtons = [UIButton](), confirmUpgrade = UIButton(), gameBoard = [[CAShapeLayer]](), imageBoard = [[UIImageView]](), animateConsumables = [UIImageView](), consumeOrder = [Int](), consumePoints = [CGPoint]()
    var skillUsed = -1, buttonWidth = CGFloat(0), buttonHeight = CGFloat(0), buttonRatio = CGFloat(0.890625), boardPercent = CGFloat(1), pieceFillRatio = CGFloat(0.95), pieceShrinkRatio = CGFloat(0.9), goldFillRatio = CGFloat(0.9)
    var lowestYs = [-1, -1, -1, -1, -1, -1], yCount = [0, 0, 0, 0, 0, 0]
    var mySkills = [UIButton](), skillFill = [CAShapeLayer]()
    var skillLevels = [0, 0, 0, 0], maxTurns = [9, 9, 9, 9], turnsLeft = [9, 9, 9, 9]
    var levelLabels = [UILabel](), enemyLabel = UILabel(), damageLabel = UILabel()
    var backBoard = CAShapeLayer()
    let topBlack = CAShapeLayer(), topBorder = CAShapeLayer(), topLight = CAShapeLayer(), topMed = CAShapeLayer(), botBlack = CAShapeLayer(), botBorder = CAShapeLayer(), botLight = CAShapeLayer(), botMed = CAShapeLayer()
    var path = [CAShapeLayer](), points = [CGPoint]()
    var prevColor = UIColor.white.cgColor
    var tileColors = [UIColor.yellow.cgColor, UIColor.blue.cgColor, UIColor.gray.cgColor, UIColor.red.cgColor, UIColor.black.cgColor]
//    var icons = [UIImage(named: "Gold"), UIImage(named: "Armor"), UIImage(named: "Sword"), UIImage(named: "Health"), UIImage(named: "Skull")]
    var icons = [UIImage(named: "LDGold"), UIImage(named: "LDArmor"), UIImage(named: "LDSword"), UIImage(named: "LDHealth"), UIImage(named: "LDSkull")]
    
    var skillIcons = [UIImage(named: "Repair"), UIImage(named: "Skill Elixir"), UIImage(named: "Masochism"), UIImage(named: "Big Game Hunter")]
    let screenSize = UIScreen.main.bounds
    var screenWidth = CGFloat(0), screenHeight = CGFloat(0), radius = CGFloat(0)
    var goldPool = [[CAShapeLayer]](), armorPool = [CAShapeLayer](), expPool = [CAShapeLayer](), hpPool = [CAShapeLayer]()
    var hpText = UILabel(), armorText = UILabel()
    var maxHP = 50, currentHP = 25
    var maxArmor = 5, currentArmor = 0
    var currentDamage = 1
    var skullHPLevel = 3, skullArmLevel = 1, skullDmgLevel = 1
    var goldLevel = 20, hpLevel = 1, armorLevel = 1, expLevel = 1
    var darkBlue = UIColor(red: 28/255, green: 35/255, blue: 79/255, alpha: 1), medBlue = UIColor(red: 80/255, green: 67/255, blue: 146/255, alpha: 1), lightBlue = UIColor(red: 142/255, green: 150/255, blue: 190/255, alpha: 1), lightRed = UIColor(red: 247/255, green: 130/255, blue: 121/255, alpha: 1), goldBlue = UIColor(red: 80/255, green: 70/255, blue: 150/255, alpha: 1), armorBlue = UIColor(red: 89/255, green: 63/255, blue: 196/255, alpha: 1), expGreen = UIColor(red: 85/255, green: 152/255, blue: 75/255, alpha: 1), hpTextColor = UIColor(red: 235/255, green: 154/255, blue: 96/255, alpha: 1), armorTextColor = UIColor(red: 147/255, green: 152/255, blue: 208/255, alpha: 1)
    var borderHeight = CGFloat(0), shiftAmount = CGFloat(0)
    override var prefersStatusBarHidden: Bool   // Hides status bar
    {
        return true
    }
    override func viewDidLoad()
    {
        super.viewDidLoad()
        screenWidth = screenSize.width
        screenHeight = screenSize.height
        radius = screenWidth*CGFloat(0.015625)
        buttonWidth = screenWidth*CGFloat(0.1875)
        buttonHeight = buttonWidth
        view.backgroundColor = UIColor.black
        CATransaction.setDisableActions(true)
        beginReal()
    }
    func drawMainMenu()
    {
        // Continue
        // New Game
        // Challenge
        // Tutorial
        // Scores
        // OpenFeint
        // Sound On
        // More Games!
    }
    func newGame()
    {
        // Name - Random
        // Difficulty Buttons
        // Character Class - Help
        // Class Properties - Edit
        // Begin
        // Back
    }
    func begin()
    {
        // Load Screen Text
        // Begin
    }
    func beginReal()
    {
        // Menu
        // Stats
        
        // Board
        drawBorders()
        drawSkills()
        drawSkillLevels()
        // Skills
        mySkills[0].setTitle("Repair", for: .normal)
        mySkills[0].setImage(skillIcons[0], for: .normal)
        mySkills[0].imageView?.layer.cornerRadius = (mySkills[0].imageView?.layer.frame.height)!*CGFloat(0.0625)
        mySkills[1].setTitle("Heal", for: .normal)
        mySkills[1].setImage(skillIcons[1], for: .normal)
        mySkills[1].imageView?.layer.cornerRadius = (mySkills[1].imageView?.layer.frame.height)!*CGFloat(0.0625)
        mySkills[2].setTitle("Masochism", for: .normal)
        mySkills[2].setImage(skillIcons[2], for: .normal)
        mySkills[2].imageView?.layer.cornerRadius = (mySkills[2].imageView?.layer.frame.height)!*CGFloat(0.0625)
        mySkills[3].setTitle("AttackAll", for: .normal)
        mySkills[3].setImage(skillIcons[3], for: .normal)
        mySkills[3].imageView?.layer.cornerRadius = (mySkills[3].imageView?.layer.frame.height)!*CGFloat(0.0625)
        initBoard()
        initGold()
        initArmor()
        initExp()
        initHP()
        for _ in 0...10
        {
            levelSkill(skill: 0)
            levelSkill(skill: 1)
            levelSkill(skill: 2)
            levelSkill(skill: 3)
        }
        updateSkillFill()
        initEnemyLabel()
        initDamageLabel()
        initSoundButton()
        initMenuButton()
        initUpgradeScreen()
        updateBoardShift()
        myPlayers = [goldPlayer, armorPlayer, swordPlayer, HPPlayer, skullPlayer]
        for i in 0...myPlayers.count - 1
        {
            for _ in 0...35
            {
                myPlayers[i].append(AVAudioPlayer())
            }
        }
    }
    func checkCollision(location: CGPoint) -> CGPoint
    {
        for i in 0...(gameBoard.count - 1)
        {
            for j in 0...(gameBoard[i].count - 1)
            {
                if((gameBoard[i][j].path?.contains(location))!)
                {
                    return CGPoint(x: (gameBoard[i][j].path?.boundingBox.midX)! - radius, y: (gameBoard[i][j].path?.boundingBox.midY)! - radius)
                }
            }
        }
        return CGPoint(x: -1, y: -1)
    }
    func checkCoords(location: CGPoint) -> CGPoint
    {
        for i in 0...(gameBoard.count - 1)
        {
            for j in 0...(gameBoard[i].count - 1)
            {
                if((gameBoard[i][j].path?.contains(location))!)
                {
                    return CGPoint(x: i, y: j)
                }
            }
        }
        return CGPoint(x: -1, y: -1)
    }
    func checkColors(location: CGPoint) -> CGColor
    {
        for i in 0...(gameBoard.count - 1)
        {
            for j in 0...(gameBoard[i].count - 1)
            {
                if((gameBoard[i][j].path?.contains(location))!)
                {
                    return gameBoard[i][j].fillColor!
                }
            }
        }
        return UIColor.white.cgColor
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        let touch = touches.first!
        let location = touch.location(in: self.view)
        let myPoint = checkCollision(location: location)
        
        if(!(myPoint.x == -1 && myPoint.y == -1))
        {
            darkenScreen(myPoint: myPoint)
            let circle = CAShapeLayer() // Draw initial dot, add to array
            circle.zPosition = 2
            circle.path = UIBezierPath(ovalIn: CGRect(x: myPoint.x, y: myPoint.y, width: radius*2, height: radius*2)).cgPath
            circle.strokeColor = UIColor.black.cgColor
            circle.lineWidth = pathWidth
            circle.fillColor = UIColor.green.cgColor
            circle.opacity = 0.75
            view.layer.addSublayer(circle)
            path.append(circle)
            points.append(myPoint)
            shrinkCoords(i: Int(checkCoords(location: myPoint).x), j: Int(checkCoords(location: myPoint).y))
            for i in 0...tileColors.count - 1
            {
                if(checkColors(location: myPoint) == tileColors[i])
                {
                    let rand = Int(arc4random_uniform(UInt32(soundArray[i].count)))
                    DispatchQueue.global().async
                    {
                        self.playSound(soundName: self.soundArray[i][rand])
                    }
                }
            }
        }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        lightenScreen()
        if(animateConsumables.count > 0)
        {
            for i in 0...animateConsumables.count - 1
            {
                animateConsumables[i].removeFromSuperview()
            }
            animateConsumables.removeAll()
        }
        consumeOrder.removeAll()
        consumePoints.removeAll()
        var counter = path.count
        var swordCount = 0
        var tempCounter = counter
        var lastPoint = CGPoint(x: -1, y: -1)
        var firstPoint = CGPoint(x: 6, y: 6)
        // Bubble sort of sort with white missing pieces
        for i in 0...lowestYs.count - 1
        {
            lowestYs[i] = -1
        }
        for i in 0...yCount.count - 1
        {
            yCount[i] = 0
        }
        if(path.count > 0 && skillUsed != -1)
        {
            for i in 0...turnsLeft.count - 1
            {
                if(turnsLeft[i] > 0)
                {
                    turnsLeft[i] -= 1
                    if(turnsLeft[i] == 0)
                    {
                        mySkills[i].layer.borderColor = UIColor.white.cgColor
                    }
                }
            }
        }
        if(path.count >= 3 || skillJustUsed)
        {
            if(!skillJustUsed)
            {
                enemyTurn()
            }
            for i in 0...turnsLeft.count - 1
            {
                if(turnsLeft[i] > 0)
                {
                    turnsLeft[i] -= 1

                    if(turnsLeft[i] == 0)
                    {
                        mySkills[i].layer.borderColor = UIColor.white.cgColor
                    }
                }
            }
            let myCount = points.count - 1
            for i in 0...myCount
            {
                if(checkCollision(location: points[i]) != CGPoint(x: -1, y: -1))
                {
                    prevColor = checkColors(location: points[i])
                    if(prevColor == UIColor.white.cgColor)
                    {
                        prevColor = checkColors(location: points[0])
                    }
                    if(i < 3)
                    {
                        for b in 0...tileColors.count - 1
                        {
                            if(prevColor == tileColors[b])
                            {
                                let rand = Int(arc4random_uniform(UInt32(soundArray[b].count)))
                                let deadlineTime = DispatchTime.now() + .milliseconds(200*i)
                                DispatchQueue.global().asyncAfter(deadline: deadlineTime)
                                {
                                    self.playSound(soundName: self.soundArray[b][rand])
                                }
                            }
                        }
                    }
                    if(prevColor == tileColors[2])
                    {
                        counter -= 1    // If it's a sword, subtract from counter. Remaining count = skull count
                        swordCount += 1
                    }
                    for z in 0...tileColors.count - 1
                    {
                        if(gameBoard[Int(checkCoords(location: points[i]).x)][Int(checkCoords(location: points[i]).y)].fillColor == tileColors[z])
                        {
                            consumeOrder.append(z)
                        }
                    }
                    consumePoints.append(CGPoint(x: Int(checkCoords(location: points[i]).x), y: Int(checkCoords(location: points[i]).y)))
                    if(prevColor == tileColors[4])   // If it's a skull, subtract currentDamage from skullHP. If <= 0, then remove skull
                    {
                        attackSkull(tile: gameBoard[Int(checkCoords(location: points[i]).x)][Int(checkCoords(location: points[i]).y)])
                    }
                    if(Int(gameBoard[Int(checkCoords(location: points[i]).x)][Int(checkCoords(location: points[i]).y)].name!)! <= 0)
                    {
                        gameBoard[Int(checkCoords(location: points[i]).x)][Int(checkCoords(location: points[i]).y)].fillColor = UIColor.white.cgColor
                    }
                    if(lowestYs[Int(checkCoords(location: points[i]).y)] < Int(checkCoords(location: points[i]).x))
                    {
                        lowestYs[Int(checkCoords(location: points[i]).y)] = Int(checkCoords(location: points[i]).x)
                    }
                    yCount[Int(checkCoords(location: points[i]).y)] += 1
                    if(Int(lastPoint.x) < Int(checkCoords(location: points[i]).x))
                    {
                        lastPoint.x = checkCoords(location: points[i]).x
                    }
                    if(Int(lastPoint.y) < Int(checkCoords(location: points[i]).y))
                    {
                        lastPoint.y = checkCoords(location: points[i]).y
                    }
                    if(Int(firstPoint.x) > Int(checkCoords(location: points[i]).x))
                    {
                        firstPoint.x = checkCoords(location: points[i]).x
                    }
                    if(Int(firstPoint.y) > Int(checkCoords(location: points[i]).y))
                    {
                        firstPoint.y = checkCoords(location: points[i]).y
                    }
                }
            }
            // Allocate points
            var doneFilling = false
            for j in 0...tileColors.count - 1
            {
                if(tileColors[j] == prevColor)
                {
                    if(j == 0)  // Gold
                    {
                        counter*=goldLevel
                        while(!doneFilling)
                        {
                            for m in 0...goldPool.count - 1
                            {
                                for k in 0...goldPool[m].count - 1
                                {
                                    let n = goldPool[m].count - 1 - k
                                    
                                    if(goldPool[m][n].fillColor == prevColor)
                                    {
                                        if(m == goldPool.count - 1 && k == goldPool[m].count - 1)    // Done filling gold bar
                                        {
                                            clearGold()
                                        }
                                    }
                                    else if(counter > 0)    // Fill
                                    {
                                        goldPool[m][n].fillColor = prevColor
                                        counter -= 1
                                        if(m == goldPool.count - 1 && k == goldPool[m].count - 1 && counter > 0)
                                        {
                                            clearGold()
                                        }
                                    }
                                    else    // Done filling if no more gold tiles
                                    {
                                        doneFilling = true
                                        break
                                    }
                                }
                            }
                        }
                    }
                    else if(j == 1) // Armor
                    {
                        counter*=armorLevel
                        while(!doneFilling)
                        {
                            for i in 0...armorPool.count - 1
                            {
                                if(armorPool[i].fillColor == prevColor)
                                {
                                    if(i == armorPool.count - 1)
                                    {
                                        clearArmor()
                                    }
                                }
                                else if(counter > 0)
                                {
                                    if(armorPool[i].fillColor == prevColor)
                                    {
                                        if(i == armorPool.count - 1)    // Done filling armor bar
                                        {
                                            clearArmor()
                                        }
                                    }
                                    else    // Fill
                                    {
                                        armorPool[i].fillColor = prevColor
                                        counter -= 1
                                        if(currentArmor < maxArmor)
                                        {
                                            currentArmor += 1
                                        }
                                    }
                                }
                                else    // Done filling if no more armor tiles
                                {
                                    doneFilling = true
                                }
                            }
                        }
                    }
                    else if(j == 2 || j == 4)   // Skulls and Swords
                    {
                        counter*=expLevel   // Got accurate value by subtracting swords earlier
                        while(!doneFilling)
                        {
                            for i in 0...expPool.count - 1
                            {
                                if(expPool[i].fillColor == UIColor.green.cgColor)
                                {
                                    if(i == expPool.count - 1)    // Done filling exp bar
                                    {
                                        clearExp()
                                    }
                                }
                                else if(counter > 0)
                                {
                                    if(expPool[i].fillColor == UIColor.green.cgColor)
                                    {
                                        if(i == expPool.count - 1)  // Done filling exp bar
                                        {
                                            clearExp()
                                        }
                                    }
                                    else    // Fill
                                    {
                                        expPool[i].fillColor = UIColor.green.cgColor
                                        counter -= 1
                                    }
                                }
                                else    // Done filling if no more skulls or swords
                                {
                                    doneFilling = true
                                }
                            }
                        }
                    }
                    else if(j == 3) // HP
                    {
                        counter*=hpLevel    // counter is how many hp points get added
                        currentHP += counter
                        counter*=hpPool.count
                        var temp = CGFloat(counter)
                        counter/=maxHP
                        temp/=CGFloat(maxHP)
                        while(temp - CGFloat(counter) > 0)
                        {
                            counter += 1 + hpPool.count/maxHP
                        }
                        if(currentHP > maxHP)
                        {
                            currentHP = maxHP
                        }
                        while(!doneFilling)
                        {
                            for i in 0...hpPool.count - 1
                            {
                                if(counter > 0)
                                {
                                    if(hpPool[i].fillColor == prevColor)
                                    {
                                        if(i == hpPool.count - 1)    // Done filling hp bar
                                        {
                                            doneFilling = true
                                        }
                                    }
                                    else    // Fill
                                    {
                                        hpPool[i].fillColor = prevColor
                                        counter -= 1
                                    }
                                }
                                else    // Done filling if no more health pots
                                {
                                    doneFilling = true
                                }
                            }
                        }
                    }
                }
            }
            // Bubble sort of sort with white missing pieces
            var boundWidth = 0
            for i in 0...yCount.count - 1
            {
                if(yCount[i] > 0)
                {
                    boundWidth += 1
                }
            }
//            print(Int(lastPoint.x) + 1)
            var count = Int(lastPoint.x) + 1
            count = (count + 1)*count/2
            for _ in 0...5//(count+1)*count/2
            {
                for j in Int(firstPoint.y)...Int(lastPoint.y)   // 5 columns
                {
                    for f in 0...Int(lastPoint.x) + 1   // 5 layers/rows
                    {
                        count -= 1
                        let i = Int(lastPoint.x) + 1 - f

                        if(i - 1 == lowestYs[j] && i - 1 >= 0)
                        {
                            if(Int(gameBoard[i - 1][j].name!)! <= 0)
                            {
                                UIView.animate(withDuration: moveDuration*Double(1 + yCount[j]))
                                {
                                    self.imageBoard[i - 1][j].transform = CGAffineTransform(translationX: 0, y: self.screenWidth*CGFloat(0.0416666666667))
                                }
                                UIView.animate(withDuration: 0)
                                {
                                    self.imageBoard[i - 1][j].transform = CGAffineTransform(translationX: 0, y: 0)
                                }
                            }
                        }
                        if(i != 0 && i < gameBoard.count)
                        {
                            if(gameBoard[i][j].fillColor == UIColor.white.cgColor)
                            {
                                gameBoard[i][j].fillColor = gameBoard[i - 1][j].fillColor
                                gameBoard[i - 1][j].fillColor = UIColor.white.cgColor
                                
                                imageBoard[i][j].isHidden = true
                                UIView.animate(withDuration: moveDuration*Double(1 + yCount[j]))
                                {
                                    self.imageBoard[i - 1][j].transform = CGAffineTransform(translationX: 0, y: self.screenWidth*CGFloat(0.333333333333))
                                }
                                imageBoard[i][j].image = imageBoard[i - 1][j].image
                                if(imageBoard[i][j].subviews.count > 0)
                                {
                                    for k in 0...imageBoard[i][j].subviews.count - 1
                                    {
                                        imageBoard[i][j].subviews[k].removeFromSuperview()
                                    }
                                }
                                if(imageBoard[i - 1][j].subviews.count > 0)
                                {
                                    for k in 0...imageBoard[i - 1][j].subviews.count - 1
                                    {
                                        imageBoard[i][j].addSubview(imageBoard[i - 1][j].subviews[k])
                                    }
                                }
                                imageBoard[i][j].isHidden = false
                                UIView.animate(withDuration: 0)
                                {
                                    self.imageBoard[i - 1][j].transform = CGAffineTransform(translationX: 0, y: 0)
                                }
                                gameBoard[i][j].name = gameBoard[i - 1][j].name
                            }
                        }
                    }
                }
            }
            var tempCount = 0
            for i in 0...5  // 5 layers/rows
            {
                for j in 0...5  // 5 columns
                {
                    if((gameBoard[i][j].fillColor == UIColor.white.cgColor) && tempCounter > 0)
                    {
                        let rand = Int(arc4random_uniform(5))
                        gameBoard[i][j].fillColor = tileColors[rand]
                        if(rand == 4)   // If it's a skull, give it hp
                        {
                            gameBoard[i][j].name = String(skullHPLevel)
                            let skullHPText = UILabel(frame: CGRect(x: imageBoard[i][j].layer.bounds.maxX - imageBoard[i][j].layer.bounds.width/5, y: imageBoard[i][j].layer.bounds.minY, width: imageBoard[i][j].layer.bounds.width/5, height: imageBoard[i][j].layer.bounds.height))
                            skullHPText.adjustsFontSizeToFitWidth = true
                            skullHPText.numberOfLines = 3
                            skullHPText.lineBreakMode = .byWordWrapping
                            skullHPText.font = UIFont(name: skullHPText.font.fontName, size: skullHPText.frame.width)
                            let tempText = NSMutableAttributedString(string: String(skullDmgLevel) + "\n" + String(skullArmLevel) + "\n" + gameBoard[i][j].name!)
                            tempText.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.white, range: NSRange(location:0,length:2))
                            tempText.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.blue, range: NSRange(location:2,length:2))
                            tempText.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red, range: NSRange(location:4,length:1))
                            skullHPText.attributedText = tempText
                            skullHPText.layer.zPosition = imageBoard[i][j].layer.zPosition + 1
                            skullHPText.textAlignment = .center
                            view.addSubview(skullHPText)
                            imageBoard[i][j].addSubview(skullHPText)
                            imageBoard[i][j].bringSubviewToFront(skullHPText)
                        }
                        else
                        {
                            gameBoard[i][j].name = "0"
                        }
                        gameBoard[i][j].zPosition = -1
                        let tilt = Int(arc4random_uniform(2))
                        var tiltedImage = icons[rand]!.rotate(radians: .pi/180)
                        if(tilt == 0)
                        {
                            tiltedImage = icons[rand]!.rotate(radians: .pi/180*3)
                        }
                        if(tilt == 1)
                        {
                            tiltedImage = icons[rand]!.rotate(radians: .pi/180*(-3))
                        }
                        imageBoard[i][j].image = tiltedImage
                        if(rand == 0)   // Gold
                        {
                            let imageWidth = (gameBoard[i][j].path?.boundingBox.height)!*goldFillRatio
                            let imageHeight = (gameBoard[i][j].path?.boundingBox.height)!*goldFillRatio
                            imageBoard[i][j].frame = CGRect(x: (gameBoard[i][j].path?.boundingBox.minX)! + imageWidth*CGFloat(1 - goldFillRatio)*CGFloat(0.5), y: (gameBoard[i][j].path?.boundingBox.minY)! + imageHeight*CGFloat(1 - goldFillRatio)*CGFloat(0.5), width: imageWidth, height: imageHeight)
                        }
                        imageBoard[i][j].contentMode = .scaleAspectFit
                        imageBoard[i][j].layer.zPosition = 1
                        if(Int(gameBoard[i][j].name!)! <= 0)
                        {
                            var consumeEndPoint = CGPoint()
                            let consumeAnimationImage = UIImageView()
                            consumeAnimationImage.frame = imageBoard[Int(consumePoints[tempCount].x)][Int(consumePoints[tempCount].y)].frame
                            consumeAnimationImage.image = icons[consumeOrder[tempCount]]
                            consumeAnimationImage.contentMode = .scaleAspectFit
                            consumeAnimationImage.layer.zPosition = 5
                            if(prevColor == tileColors[0])
                            {
                                consumeEndPoint = CGPoint(x: goldPool[2][0].path!.boundingBox.minX + CGFloat(goldPool[2][0].path!.boundingBox.width + consumeAnimationImage.frame.width)*CGFloat(0.5), y: goldPool[2][0].path!.boundingBox.minY + goldPool[2][0].path!.boundingBox.height*10 + consumeAnimationImage.frame.height*CGFloat(0.5))
                            }
                            else if(prevColor == tileColors[1])
                            {
                                consumeEndPoint = CGPoint(x: self.screenWidth*CGFloat(0.5) + consumeAnimationImage.frame.width*CGFloat(0.5), y: (armorPool[0].path?.boundingBox.minY)! + ((armorPool[0].path?.boundingBox.height)! + consumeAnimationImage.frame.height)*CGFloat(0.5))
                            }
                            else if(prevColor == tileColors[2] || prevColor == tileColors[4])
                            {
                                consumeEndPoint = CGPoint(x: self.screenWidth*CGFloat(0.5) + consumeAnimationImage.frame.width*CGFloat(0.5), y: (expPool[0].path?.boundingBox.minY)! + ((expPool[0].path?.boundingBox.height)! + consumeAnimationImage.frame.height)*CGFloat(0.5))
                            }
                            else if(prevColor == tileColors[3])
                            {
                                consumeEndPoint = CGPoint(x: (hpPool[0].path?.boundingBox.minX)! + ((hpPool[0].path?.boundingBox.width)! + consumeAnimationImage.frame.width)*CGFloat(0.5), y: (hpPool[0].path?.boundingBox.minY)! + (hpPool[0].path?.boundingBox.height)!*CGFloat(0.5))
                            }
                            UIView.animate(withDuration: 0)
                            {
                                consumeAnimationImage.transform = CGAffineTransform(translationX: 0, y: 0)
                            }
                            UIView.animate(withDuration: consumeDuration)
                            {
                                consumeAnimationImage.transform = CGAffineTransform(translationX: consumeEndPoint.x - consumeAnimationImage.frame.maxX, y: consumeEndPoint.y - consumeAnimationImage.frame.maxY).scaledBy(x: 0.00001, y: 0.00001)
                            }
                            tempCount += 1
                            self.view.addSubview(consumeAnimationImage)
                            animateConsumables.append(consumeAnimationImage)
                            tempCounter -= 1
                        }
                    }
                }
            }
        }
        if(path.count > 0)  // Clean Board
        {
            for i in 0...path.count - 1
            {
                path[i].removeFromSuperlayer()
            }
        }
        path.removeAll()
        points.removeAll()
        soundCount = 0
        updateSkillFill()
        updateBoardShift()
        updateEnemyLabel()
        updateDamageLabel()
        skillJustUsed = false
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        let touch = touches.first!
        let location = touch.location(in: self.view)
        let myPoint = checkCollision(location: location)
        if(!(myPoint.x == -1 && myPoint.y == -1))
        {
            if(points.count > 0)    // Draw line , add to array, check if point already exists
            {
                let prevPoint = points.last
                var colorsMatch = false
                if(distance(prevPoint!, location) <= distance(CGPoint(x: (gameBoard[0][0].path?.boundingBox.midX)!, y: (gameBoard[0][0].path?.boundingBox.midY)!), CGPoint(x: (gameBoard[1][1].path?.boundingBox.midX)!, y: (gameBoard[1][1].path?.boundingBox.midY)!)))
                {
                    if(checkColors(location: prevPoint!) == checkColors(location: myPoint))
                    {
                        colorsMatch = true
                    }
                    if((checkColors(location: prevPoint!) == UIColor.gray.cgColor && checkColors(location: myPoint) == UIColor.black.cgColor) || (checkColors(location: prevPoint!) == UIColor.black.cgColor && checkColors(location: myPoint) == UIColor.gray.cgColor))
                    {
                        colorsMatch = true
                    }
                }
                if(!points.contains(myPoint) && (distance(prevPoint!, myPoint) < screenWidth*CGFloat(0.333333333333)) && colorsMatch)   // If my point hasn't already been used and is adjacent and colors match
                {
                    for i in 0...tileColors.count - 1
                    {
                        if(checkColors(location: myPoint) == tileColors[i])
                        {
                            let rand = Int(arc4random_uniform(UInt32(soundArray[i].count)))
                            DispatchQueue.global().async
                            {
                                self.playSound(soundName: self.soundArray[i][rand])
                            }
                        }
                    }
                    let line = CAShapeLayer()
                    let linePath = UIBezierPath()
                    let adjustStart = CGPoint(x: prevPoint!.x + radius, y: prevPoint!.y + radius)
                    let adjustEndPoint = CGPoint(x: myPoint.x + radius, y: myPoint.y + radius)
                    line.zPosition = 2
                    linePath.move(to: adjustStart)
                    linePath.addLine(to: adjustEndPoint)
                    line.path = linePath.cgPath
                    line.fillColor = nil
                    line.lineWidth = radius + 2*pathWidth
                    line.lineCap = CAShapeLayerLineCap.round
                    let borderLayer = CAShapeLayer()
                    borderLayer.path = line.path
                    borderLayer.lineWidth = radius
                    borderLayer.strokeColor = UIColor.green.cgColor
                    borderLayer.fillColor = UIColor.clear.cgColor
                    borderLayer.lineCap = CAShapeLayerLineCap.round
                    line.addSublayer(borderLayer)
                    line.opacity = 0.75
                    line.strokeColor = UIColor.black.cgColor
                    view.layer.addSublayer(line)
                    path.append(line)
                    points.append(myPoint)
                    shrinkCoords(i: Int(checkCoords(location: myPoint).x), j: Int(checkCoords(location: myPoint).y))
                }
                if(points.count > 1)
                {
                    if(myPoint == points[points.count - 2]) // If backtracking
                    {
                        for i in 0...tileColors.count - 1
                        {
                            if(checkColors(location: myPoint) == tileColors[i])
                            {
                                let rand = Int(arc4random_uniform(UInt32(soundArray[i].count)))
                                DispatchQueue.global().async
                                {
                                    self.playSound(soundName: self.soundArray[i][rand])
                                }
                            }
                        }
                        growCoords(i: Int(checkCoords(location: points.last!).x), j: Int(checkCoords(location: points.last!).y))
                        path.last?.removeFromSuperlayer()
                        path.removeLast()
                        points.removeLast()
                    }
                }
            }
            else
            {
                darkenScreen(myPoint: myPoint)
                let circle = CAShapeLayer() // Draw initial dot, add to array
                circle.zPosition = 2
                circle.path = UIBezierPath(ovalIn: CGRect(x: myPoint.x, y: myPoint.y, width: radius*2, height: radius*2)).cgPath
                circle.strokeColor = UIColor.black.cgColor
                circle.lineWidth = pathWidth
                circle.fillColor = UIColor.green.cgColor
                circle.opacity = 0.75
                view.layer.addSublayer(circle)
                path.append(circle)
                points.append(myPoint)
                for i in 0...tileColors.count - 1
                {
                    if(checkColors(location: myPoint) == tileColors[i])
                    {
                        let rand = Int(arc4random_uniform(UInt32(soundArray[i].count)))
                        DispatchQueue.global().async
                        {
                            self.playSound(soundName: self.soundArray[i][rand])
                        }
                    }
                }
            }
        }
        if(0 < path.count - 1)
        {
            for i in 0...path.count - 1 // Increase transparency based on distance from current point on path
            {
                path[i].opacity = 0.75 - Float(path.count - 1 - i)*0.075
                if(path[i].opacity < 0.75 - Float(5 - 1)*0.075)
                {
                    path[i].opacity = 0.75 - Float(5 - 1)*0.075
                }
            }
        }
    }
    func distance(_ a: CGPoint, _ b: CGPoint) -> CGFloat
    {
        let xDist = a.x - b.x
        let yDist = a.y - b.y
        return CGFloat(sqrt(xDist * xDist + yDist * yDist))
    }
    func enemyTurn()
    {
        // Add up damages
        var totalDmg = 0
        for i in 0...imageBoard.count - 1
        {
            for j in 0...imageBoard[i].count - 1
            {
                if(imageBoard[i][j].subviews.count > 0)
                {
                    let tempLabel = imageBoard[i][j].subviews[0] as? UILabel
                    let parts = tempLabel!.text!.components(separatedBy: "\n")
                    totalDmg += Int(parts[0])!
                }
            }
        }
        print("Total Damage: " + String(totalDmg))
        currentHP -= totalDmg
        var counter = CGFloat(currentHP)/CGFloat(maxHP)*CGFloat(hpPool.count)
        if(currentHP <= 0)
        {
            deathScreen()
        }
        else
        {
            for i in 0...Int(counter) - 1
            {
                hpPool[i].fillColor = UIColor.red.cgColor
            }
            for j in Int(counter)...hpPool.count - 1
            {
                hpPool[j].fillColor = UIColor.clear.cgColor
            }
        }
    }
    func deathScreen()
    {
        // Stuff here
        print("You died")
        view.isUserInteractionEnabled = false
    }
    func levelGold()    // Choose your upgrade
    {
        if(goldLevel < 20)
        {
            goldLevel += 1
        }
        maxHP += 15
        for i in 0...hpPool.count - 1
        {
            hpPool[i].fillColor = UIColor.clear.cgColor
        }
        var counter = currentHP   // counter is how many hp points get added
        counter*=hpPool.count
        var temp = CGFloat(counter)
        counter/=maxHP
        temp/=CGFloat(maxHP)
        while(temp - CGFloat(counter) > 0)
        {
            counter += 1 + hpPool.count/maxHP
        }
        if(currentHP > maxHP)
        {
            currentHP = maxHP
        }
        var doneFilling = false
        while(!doneFilling)
        {
            for i in 0...hpPool.count - 1
            {
                if(counter > 0)
                {
                    if(hpPool[i].fillColor == tileColors[3])
                    {
                        if(i == hpPool.count - 1)    // Done filling hp bar
                        {
                            doneFilling = true
                        }
                    }
                    else    // Fill
                    {
                        hpPool[i].fillColor = tileColors[3]
                        counter -= 1
                    }
                }
                else    // Done filling if no more health pots
                {
                    doneFilling = true
                }
            }
        }
        currentHP += 15
    }
    func clearGold()
    {
        levelGold()
        for i in 0...goldPool.count - 1
        {
            for j in 0...goldPool[i].count - 1
            {
                goldPool[i][j].fillColor = UIColor.clear.cgColor
            }
        }
    }
    func levelArmor()   // Choose your upgrade
    {
        if(armorLevel < 20)
        {
            armorLevel += 1
        }
        maxArmor += 1
        currentArmor += 1
    }
    func clearArmor()
    {
        levelArmor()
        for i in 0...armorPool.count - 1
        {
            armorPool[i].fillColor = UIColor.clear.cgColor
        }
    }
    func levelExp()   // Choose your upgrade
    {
        if(expLevel < 20)
        {
            expLevel += 1
        }
        currentDamage += 1
        levelSkill(skill: 3)
        if(skillLevels[3] >= maxTurns[3])
        {
            skillLevels[3] = maxTurns[3]
        }
        print(skillLevels[3])
    }
    func clearExp()
    {
        levelExp()
        for i in 0...expPool.count - 1
        {
            expPool[i].fillColor = UIColor.clear.cgColor
        }
    }
    func updateBoardShift()
    {
        for i in 0...gameBoard.count - 1
        {
            for j in 0...gameBoard[i].count - 1
            {
                if(Int(gameBoard[i][j].name!)! <= 0)
                {
                    growCoords(i: i, j: j)
                }
                else
                {
                    let skullHPText = UILabel(frame: CGRect(x: imageBoard[i][j].layer.bounds.maxX - imageBoard[i][j].layer.bounds.width/5, y: imageBoard[i][j].layer.bounds.minY, width: imageBoard[i][j].layer.bounds.width/5, height: imageBoard[i][j].layer.bounds.height))
                    skullHPText.adjustsFontSizeToFitWidth = true
                    skullHPText.numberOfLines = 3
                    skullHPText.lineBreakMode = .byWordWrapping
                    skullHPText.font = UIFont(name: skullHPText.font.fontName, size: skullHPText.frame.width)
                    let tempText = NSMutableAttributedString(string: String(skullDmgLevel) + "\n" + String(skullArmLevel) + "\n" + gameBoard[i][j].name!)
                    tempText.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.white, range: NSRange(location:0,length:2))
                    tempText.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.blue, range: NSRange(location:2,length:2))
                    tempText.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red, range: NSRange(location:4,length:1))
                    skullHPText.attributedText = tempText
                    skullHPText.layer.zPosition = imageBoard[i][j].layer.zPosition + 1
                    skullHPText.textAlignment = .center
                    view.addSubview(skullHPText)
                    imageBoard[i][j].subviews[0].removeFromSuperview()
                    imageBoard[i][j].addSubview(skullHPText)
                    imageBoard[i][j].bringSubviewToFront(skullHPText)
                }
            }
        }
    }
    func updateSkillFill()
    {
        for i in 0...skillFill.count - 1
        {
            var ratio = CGFloat(maxTurns[i] - skillLevels[i] - turnsLeft[i])/CGFloat(maxTurns[i] - skillLevels[i])
            if(ratio < 0)
            {
                ratio = 0
            }
            var cornersToRound = UIRectCorner()
            cornersToRound = [.topLeft, .topRight]
            if(turnsLeft[i] == 0 || turnsLeft[i] == maxTurns[i] - skillLevels[i])
            {
                cornersToRound = [.allCorners]
            }
            if(skillLevels[i] == maxTurns[i])
            {
                skillFill[i].path = UIBezierPath(roundedRect: CGRect(x: mySkills[i].layer.frame.minX, y: mySkills[i].layer.frame.minY, width: mySkills[i].layer.frame.width, height: 0), byRoundingCorners: cornersToRound, cornerRadii: CGSize(width: mySkills[i].layer.frame.width*CGFloat(0.0625), height: mySkills[i].layer.frame.width*CGFloat(0.0625)) ).cgPath
                skillFill[i].fillColor = UIColor.black.cgColor
                skillFill[i].zPosition = 4
                skillFill[i].opacity = 0.5
                mySkills[i].layer.borderColor = UIColor.white.cgColor
            }
            else
            {
                skillFill[i].path = UIBezierPath(roundedRect: CGRect(x: mySkills[i].layer.frame.minX, y: mySkills[i].layer.frame.minY, width: mySkills[i].layer.frame.width, height: mySkills[i].layer.frame.height*(1 - ratio)), byRoundingCorners: cornersToRound, cornerRadii: CGSize(width: mySkills[i].layer.frame.width*CGFloat(0.0625), height: mySkills[i].layer.frame.width*CGFloat(0.0625)) ).cgPath
                skillFill[i].fillColor = UIColor.black.cgColor
                skillFill[i].zPosition = 4
                skillFill[i].opacity = 0.5
            }
        }
        updatePoolStats()
    }
    func initEnemyLabel()
    {
        enemyLabel = UILabel(frame: CGRect(x: armorText.frame.midX - CGFloat(1.5)*armorText.frame.width, y: armorText.frame.minY, width: armorText.frame.width*CGFloat(0.5), height: armorText.frame.height))
        enemyLabel.text = String("+") + String(skullHPLevel)
        enemyLabel.textColor = UIColor.white
        enemyLabel.font = UIFont(name: enemyLabel.font.fontName, size: enemyLabel.frame.height)
        enemyLabel.textAlignment = .center
        enemyLabel.adjustsFontSizeToFitWidth = true
        enemyLabel.layer.zPosition = 3
        self.view.addSubview(enemyLabel)
    }
    func updateEnemyLabel()
    {
        enemyLabel.text = String("+") + String(skullHPLevel)
    }
    func initDamageLabel()
    {
        damageLabel = UILabel(frame: CGRect(x: armorText.frame.midX + armorText.frame.width, y: armorText.frame.minY, width: armorText.frame.width*CGFloat(0.5), height: armorText.frame.height))
        damageLabel.text = String("+") + String(currentDamage)
        damageLabel.textColor = UIColor.white
        damageLabel.font = UIFont(name: damageLabel.font.fontName, size: damageLabel.frame.height)
        damageLabel.textAlignment = .center
        damageLabel.adjustsFontSizeToFitWidth = true
        damageLabel.layer.zPosition = 3
        self.view.addSubview(damageLabel)
    }
    func initSoundButton()
    {
        toggleSound = UIButton(frame: CGRect(x: mySkills.last!.frame.minX + mySkills.last!.frame.minX - mySkills[2].frame.minX, y: mySkills.last!.frame.minY, width: mySkills.last!.frame.width*1.2, height: mySkills.last!.frame.height*CGFloat(0.5)))
        toggleSound.layer.borderColor = UIColor.white.cgColor
        toggleSound.layer.borderWidth = 1.0
        toggleSound.backgroundColor = darkBlue
        toggleSound.layer.zPosition = 3.0
        toggleSound.layer.cornerRadius = mySkills.last!.layer.cornerRadius
        toggleSound.setTitle("Sound off", for: .normal)
        toggleSound.addTarget(self, action: "toggleMute", for: .touchDown)
        self.view.addSubview(toggleSound)
    }
    func initMenuButton()
    {
        toggleMenu = UIButton(frame: CGRect(x: mySkills.last!.frame.minX + mySkills.last!.frame.minX - mySkills[2].frame.minX, y: mySkills.last!.frame.maxY - mySkills.last!.frame.height*CGFloat(0.5), width: mySkills.last!.frame.width*1.2, height: mySkills.last!.frame.height*CGFloat(0.5)))
        toggleMenu.layer.borderColor = UIColor.white.cgColor
        toggleMenu.layer.borderWidth = 1.0
        toggleMenu.backgroundColor = darkBlue
        toggleMenu.layer.zPosition = 3.0
        toggleMenu.layer.cornerRadius = mySkills.last!.layer.cornerRadius
        toggleMenu.setTitle("Menu off", for: .normal)
        toggleMenu.addTarget(self, action: "toggleMenuOverlay", for: .touchDown)
        self.view.addSubview(toggleMenu)
    }
    func initUpgradeScreen()
    {
        upgradeMenuDimRect.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
        upgradeMenuDimRect.backgroundColor = UIColor.black.cgColor
        upgradeMenuDimRect.opacity = 0.6
        upgradeMenuDimRect.zPosition = 6
        upgradeMenuDimRect.isHidden = true
        upgradeMenuArray.append(upgradeMenuDimRect)
        view.layer.addSublayer(upgradeMenuDimRect)
        let xPos = ((mySkills.first?.frame.width)!*CGFloat(0.5))
        let yPos = (topMed.path?.boundingBox.maxY)! + (mySkills.first?.frame.height)!*CGFloat(0.333333333333)
        let width = screenWidth - xPos
        let height = (botMed.path?.boundingBox.minY)! - yPos - (mySkills.first?.frame.height)!*CGFloat(0.8)
        upgradeMenu.frame = CGRect(x: xPos, y: yPos, width: width, height: height)
        upgradeMenu.backgroundColor = medBlue.cgColor
        upgradeMenu.zPosition = 7
        upgradeMenu.isHidden = true
        upgradeMenu.shadowColor = UIColor.black.cgColor
        upgradeMenu.shadowOpacity = 1
        upgradeMenu.shadowRadius = topLight.path!.boundingBox.height/2
        upgradeMenu.shadowPath = CGPath(rect: CGRect(x: upgradeMenu.bounds.minX - upgradeMenu.shadowRadius, y: upgradeMenu.bounds.minY - upgradeMenu.shadowRadius, width: upgradeMenu.bounds.width + 2*upgradeMenu.shadowRadius, height: upgradeMenu.bounds.height + 2*upgradeMenu.shadowRadius), transform: .none)
        upgradeMenu.shadowOffset = CGSize(width: 2, height: 2)
        upgradeMenuArray.append(upgradeMenu)
        view.layer.addSublayer(upgradeMenu)
        let xPos2 = xPos + topMed.path!.boundingBox.height
        let yPos2 = yPos + topMed.path!.boundingBox.height
        let width2 = screenWidth - xPos2
        let height2 = height - 2*topMed.path!.boundingBox.height
        upgradeMenuLayer2.frame = CGRect(x: xPos2, y: yPos2, width: width2, height: height2)
        upgradeMenuLayer2.backgroundColor = lightBlue.cgColor
        upgradeMenuLayer2.zPosition = 8
        upgradeMenuLayer2.isHidden = true
        upgradeMenuArray.append(upgradeMenuLayer2)
        view.layer.addSublayer(upgradeMenuLayer2)
        let xPos3 = xPos2 + topLight.path!.boundingBox.height
        let yPos3 = yPos2 + topLight.path!.boundingBox.height
        let width3 = screenWidth - xPos3
        let height3 = height2 - 2*topLight.path!.boundingBox.height
        upgradeMenuLayer3.frame = CGRect(x: xPos3, y: yPos3, width: width3, height: height3)
        upgradeMenuLayer3.backgroundColor = darkBlue.cgColor
        upgradeMenuLayer3.zPosition = 8
        upgradeMenuLayer3.isHidden = true
        upgradeMenuArray.append(upgradeMenuLayer3)
        view.layer.addSublayer(upgradeMenuLayer3)
        let yPos3a = upgradeMenu.frame.maxY
        upgradeConfirm.frame = CGRect(x: xPos, y: yPos3a, width: mySkills[0].frame.width + 2*(mySkills[0].frame.minX + topLight.path!.boundingBox.height + topMed.path!.boundingBox.height), height: botMed.path!.boundingBox.minY - yPos3a - botMed.path!.boundingBox.height)
        upgradeConfirm.backgroundColor = medBlue.cgColor
        upgradeConfirm.zPosition = 9
        upgradeConfirm.isHidden = true
        upgradeConfirm.shadowColor = UIColor.black.cgColor
        upgradeConfirm.shadowOpacity = 1
        upgradeConfirm.shadowRadius = topLight.path!.boundingBox.height/2
        upgradeConfirm.shadowPath = CGPath(rect: CGRect(x: upgradeConfirm.bounds.minX - upgradeConfirm.shadowRadius, y: upgradeConfirm.bounds.minY + 3*upgradeConfirm.shadowRadius, width: upgradeConfirm.bounds.width + 2*upgradeConfirm.shadowRadius, height: upgradeConfirm.bounds.height - upgradeConfirm.shadowRadius), transform: .none)
        upgradeConfirm.shadowOffset = CGSize(width: 2, height: 0)
        upgradeMenuArray.append(upgradeConfirm)
        view.layer.addSublayer(upgradeConfirm)
        upgradeConfirm2.frame = CGRect(x: xPos2, y: yPos3a - topMed.path!.boundingBox.height, width: mySkills[0].frame.width + 2*(mySkills[0].frame.minX + topLight.path!.boundingBox.height), height: botMed.path!.boundingBox.minY - yPos3a - botMed.path!.boundingBox.height)
        upgradeConfirm2.backgroundColor = lightBlue.cgColor
        upgradeConfirm2.zPosition = 10
        upgradeConfirm2.isHidden = true
        upgradeMenuArray.append(upgradeConfirm2)
        view.layer.addSublayer(upgradeConfirm2)
        upgradeConfirm3.frame = CGRect(x: xPos3, y: yPos3a - topMed.path!.boundingBox.height - topLight.path!.boundingBox.height, width: mySkills[0].frame.width + 2*(mySkills[0].frame.minX), height: botMed.path!.boundingBox.minY - yPos3a - botMed.path!.boundingBox.height)
        upgradeConfirm3.backgroundColor = darkBlue.cgColor
        upgradeConfirm3.zPosition = 11
        upgradeConfirm3.isHidden = true
        upgradeMenuArray.append(upgradeConfirm3)
        view.layer.addSublayer(upgradeConfirm3)
        for i in 0...1
        {
            upgradeIcons.append([CAShapeLayer]())
            for j in 0...3
            {
                let xPos4 = xPos3 + CGFloat(mySkills[0].frame.minX)*CGFloat(1 + 4*i) + CGFloat(mySkills[0].frame.width)*CGFloat(i)
                let yPos4 = yPos3 + CGFloat(mySkills[0].frame.minX)*CGFloat(4.2 + CGFloat(j)/2) + CGFloat(mySkills[0].frame.height)*CGFloat(j)
                let width4 = mySkills[0].frame.width
                let height4 = mySkills[0].frame.height
                upgradeIcons[i].append(CAShapeLayer())
                upgradeIcons[i][j].frame = CGRect(x: xPos4, y: yPos4, width: width4, height: height4)
                upgradeIcons[i][j].backgroundColor = UIColor(white: 0, alpha: 0.25).cgColor
                upgradeIcons[i][j].borderColor = UIColor.black.cgColor
                upgradeIcons[i][j].borderWidth = mySkills[0].layer.borderWidth
                upgradeIcons[i][j].cornerRadius = mySkills[0].layer.cornerRadius
                upgradeIcons[i][j].zPosition = 9
                upgradeIcons[i][j].isHidden = true
                upgradeMenuArray.append(upgradeIcons[i][j])
                view.layer.addSublayer(upgradeIcons[i][j])
            }
        }
        for i in 0...3
        {
            let xPos4 = xPos3 + CGFloat(mySkills[0].frame.minX)*CGFloat(0.75)
            let yPos4 = upgradeIcons[0][i].frame.minY - CGFloat(mySkills[0].frame.minX)*CGFloat(0.25)//yPos3 + CGFloat(mySkills[0].frame.minX)*CGFloat(2.75 + CGFloat(i)) + CGFloat(mySkills[0].frame.height)*CGFloat(i)
            let width4 = upgradeMenuLayer3.frame.width - CGFloat(2)*CGFloat(mySkills[0].frame.minX) + CGFloat(mySkills[0].frame.minX)*CGFloat(0.5)
            let height4 = mySkills[0].frame.height + CGFloat(mySkills[0].frame.minX)*CGFloat(0.5)
            upgradeButtons.append(UIButton())
            upgradeButtons[i].frame = CGRect(x: xPos4, y: yPos4, width: width4, height: height4)
            upgradeButtons[i].backgroundColor = UIColor.clear
            upgradeButtons[i].layer.borderColor = UIColor.clear.cgColor
            upgradeButtons[i].layer.opacity = 0.25
            upgradeButtons[i].layer.borderWidth = mySkills[0].layer.borderWidth
            upgradeButtons[i].layer.cornerRadius = mySkills[0].layer.cornerRadius
            upgradeButtons[i].layer.zPosition = 10
            upgradeButtons[i].isHidden = true
            upgradeButtons[i].addTarget(self, action: #selector(selectUpgrade), for: .touchDown)
            view.addSubview(upgradeButtons[i])
        }
        confirmUpgrade.frame = CGRect(x: Int(upgradeIcons[0][3].frame.minX), y: Int(upgradeConfirm3.frame.minY), width: Int(upgradeIcons[0][3].frame.width), height:  Int(upgradeIcons[0][3].frame.width*2/3))
        confirmUpgrade.backgroundColor = UIColor(white: 1, alpha: 0.1)
        confirmUpgrade.layer.borderColor = UIColor.black.cgColor
        confirmUpgrade.layer.borderWidth = mySkills[0].layer.borderWidth
        confirmUpgrade.layer.cornerRadius = mySkills[0].layer.cornerRadius
        confirmUpgrade.layer.zPosition = 12
        confirmUpgrade.isHidden = true
        confirmUpgrade.setTitle("✓", for: .normal)
        confirmUpgrade.addTarget(self, action: "toggleMenuOverlay", for: .touchDown)
        confirmUpgrade.titleLabel?.font = UIFont(name: (confirmUpgrade.titleLabel?.font.fontName)!, size: confirmUpgrade.frame.height)
        view.addSubview(confirmUpgrade)
    }
    @objc func selectUpgrade(_ sender: UIButton)
    {
        for i in 0...upgradeButtons.count - 1
        {
            if(upgradeButtons[i] != sender)
            {
                upgradeButtons[i].backgroundColor = UIColor.clear
                upgradeButtons[i].layer.borderColor = UIColor.clear.cgColor
                upgradeIcons[0][i].backgroundColor = UIColor(white: 0, alpha: 0.25).cgColor
                upgradeIcons[1][i].backgroundColor = UIColor(white: 0, alpha: 0.25).cgColor
            }
            else
            {
                upgradeButtons[i].backgroundColor = UIColor(white: 1, alpha: 0.05)
                upgradeButtons[i].layer.borderColor = UIColor.white.cgColor
                upgradeIcons[0][i].backgroundColor = UIColor(white: 1, alpha: 0.05).cgColor
                upgradeIcons[1][i].backgroundColor = UIColor(white: 1, alpha: 0.05).cgColor
            }
        }
    }
    @objc func toggleMute()
    {
        if(soundEnabled)
        {
            soundEnabled = false
            toggleSound.setTitle("Sound off", for: .normal)
        }
        else
        {
            soundEnabled = true
            toggleSound.setTitle("Sound on", for: .normal)
        }
    }
    @objc func toggleMenuOverlay()
    {
        for i in 0...upgradeMenuArray.count - 1
        {
            upgradeMenuArray[i].isHidden = menuEnabled
        }
        for i in 0...upgradeButtons.count - 1
        {
            upgradeButtons[i].isHidden = menuEnabled
        }
        confirmUpgrade.isHidden = menuEnabled
        menuEnabled = !menuEnabled
    }
    func updateDamageLabel()
    {
        damageLabel.text = String("+") + String(currentDamage)
    }
    func updatePoolStats()
    {
        var hpCount = 0
        for i in 0...hpPool.count - 1
        {
            if(hpPool[i].fillColor == UIColor.red.cgColor)
            {
                hpCount += 1
            }
        }
        hpText.text = String(currentHP) + "/" + String(maxHP)
        armorText.text = String(currentArmor) + "/" + String(maxArmor)
    }
    func levelSkill(skill: Int)
    {
        if(skillLevels[skill] < 9)
        {
            skillLevels[skill] += 1
            if(turnsLeft[skill] > 0)
            {
                turnsLeft[skill] -= 1
            }
            updateSkillLevels()
        }
    }
    func updateSkillLevels()
    {
        for i in 0...mySkills.count - 1
        {
            levelLabels[i].text = String(skillLevels[i] + 1)
        }
    }
    func drawSkillLevels()
    {
        for i in 0...mySkills.count - 1
        {
            let myLabel = UILabel(frame: CGRect(x: mySkills[i].frame.maxX - mySkills[i].frame.width*CGFloat(0.25), y: mySkills[i].frame.maxY - mySkills[i].frame.height*CGFloat(0.28125), width: mySkills[i].frame.width*CGFloat(0.1875), height: mySkills[i].frame.height*CGFloat(0.21875)))
            myLabel.text = String(skillLevels[i] + 1)
            myLabel.textColor = UIColor.white
            myLabel.font = UIFont(name: myLabel.font.fontName, size: myLabel.frame.height)
            myLabel.textAlignment = .center
            myLabel.adjustsFontSizeToFitWidth = true
            myLabel.layer.zPosition = 3
            self.view.addSubview(myLabel)
            levelLabels.append(myLabel)
        }
    }
    func drawSkills()
    {
        for i in 0...3
        {
            let gapSpace = (topLight.path!.boundingBox.minY - (topBorder.path?.boundingBox.minY)! - buttonHeight*buttonRatio)*CGFloat(0.5)
            let yPos = gapSpace + (topBorder.path?.boundingBox.minY)!
            let myButton = UIButton(frame: CGRect(x: gapSpace*CGFloat(i + 1) + buttonWidth*buttonRatio*CGFloat(i), y: yPos, width: buttonWidth*buttonRatio, height: buttonHeight*buttonRatio))
            myButton.layer.cornerRadius = buttonHeight*buttonRatio*CGFloat(0.0625)
            myButton.layer.borderColor = UIColor.black.cgColor
            myButton.layer.borderWidth = 1
            myButton.layer.backgroundColor = UIColor.white.cgColor
            myButton.layer.zPosition = 3
            myButton.addTarget(self, action: #selector(useSkill), for: .touchDown)
            self.view.addSubview(myButton)
            mySkills.append(myButton)
            skillFill.append(CAShapeLayer())
            view.layer.addSublayer(skillFill[i])
        }
    }
    func drawBorders()
    {
        borderHeight = buttonHeight*CGFloat(1.234375)
        let medRatio = CGFloat(1.5)
        backBoard.zPosition = 0
        let yPos = screenHeight*CGFloat(0.5) - screenWidth*boardPercent*CGFloat(0.5) - borderHeight*CGFloat(0.0238095238095)
        backBoard.path = UIBezierPath(roundedRect: CGRect(x: screenWidth*(1 - boardPercent)/2, y: yPos, width: screenWidth*boardPercent, height: screenWidth*boardPercent), cornerRadius: 0).cgPath
        backBoard.fillColor = UIColor.black.cgColor
        view.layer.addSublayer(backBoard)
        topBorder.zPosition = 2
        topBorder.path = UIBezierPath(roundedRect: CGRect(x: 0, y: (backBoard.path?.boundingBox.minY)! - borderHeight - borderHeight*1/21*medRatio, width: screenWidth, height: borderHeight), cornerRadius: 0).cgPath
        topBorder.fillColor = darkBlue.cgColor
        view.layer.addSublayer(topBorder)
        topLight.zPosition = 2
        topLight.path = UIBezierPath(roundedRect: CGRect(x: 0, y: topBorder.path!.boundingBox.maxY - borderHeight*(1 + medRatio)/21, width: screenWidth, height: borderHeight*1/21), cornerRadius: 0).cgPath
        topLight.fillColor = lightBlue.cgColor
        view.layer.addSublayer(topLight)
        topMed.zPosition = 2
        topMed.path = UIBezierPath(roundedRect: CGRect(x: 0, y: (topLight.path?.boundingBox.maxY)!, width: screenWidth, height: (topLight.path?.boundingBox.height)!*medRatio), cornerRadius: 0).cgPath
        topMed.fillColor = medBlue.cgColor
        view.layer.addSublayer(topMed)
        topBlack.zPosition = 2
        topBlack.path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: screenWidth, height: (topBorder.path?.boundingBox.minY)!), cornerRadius: 0).cgPath
        topBlack.fillColor = UIColor.black.cgColor
        view.layer.addSublayer(topBlack)
        botBorder.zPosition = 1
        botBorder.path = UIBezierPath(roundedRect: CGRect(x: 0, y: (backBoard.path?.boundingBox.maxY)! + borderHeight*1.5/21, width: screenWidth, height: borderHeight), cornerRadius: 0).cgPath
        botBorder.fillColor = darkBlue.cgColor
        view.layer.addSublayer(botBorder)
        botMed.zPosition = 1
        botMed.path = UIBezierPath(roundedRect: CGRect(x: 0, y: (botBorder.path?.boundingBox.minY)!, width: screenWidth, height: (topMed.path?.boundingBox.height)!), cornerRadius: 0).cgPath
        botMed.fillColor = medBlue.cgColor
        view.layer.addSublayer(botMed)
        botLight.zPosition = 1
        botLight.path = UIBezierPath(roundedRect: CGRect(x: 0, y: (botMed.path?.boundingBox.maxY)!, width: screenWidth, height: borderHeight*1/21), cornerRadius: 0).cgPath
        botLight.fillColor = lightBlue.cgColor
        view.layer.addSublayer(botLight)
        botBlack.zPosition = 1
        botBlack.path = UIBezierPath(roundedRect: CGRect(x: 0, y: (botBorder.path?.boundingBox.maxY)!, width: screenWidth, height: screenHeight - (botBorder.path?.boundingBox.maxY)!), cornerRadius: 0).cgPath
        botBlack.fillColor = UIColor.black.cgColor
        view.layer.addSublayer(botBlack)
    }
    func initBoard()
    {
        for i in 0...5
        {
            gameBoard.append([])
            imageBoard.append([])
            for j in 0...5
            {
                let rand = Int(arc4random_uniform(5))   // Fill Randomly with Gold, Armor, Swords, Health Pots, Enemies
                let square = CAShapeLayer()
                square.opacity = 0.5
                square.zPosition = -1
                let squareSide = (backBoard.path?.boundingBox.width)!/6
                square.path = UIBezierPath(roundedRect: CGRect(x: (backBoard.path?.boundingBox.minX)! + squareSide*CGFloat(j), y: (backBoard.path?.boundingBox.minY)! + squareSide*CGFloat(i), width: squareSide, height: squareSide), cornerRadius: 0).cgPath
                square.fillColor = tileColors[rand]
                view.layer.addSublayer(square)
                gameBoard[i].insert(square, at: j)
                let tilt = Int(arc4random_uniform(2))
                var tiltedImage = icons[rand]!.rotate(radians: .pi/180)
                if(tilt == 0)
                {
                    tiltedImage = icons[rand]!.rotate(radians: .pi/180*3)
                }
                if(tilt == 1)
                {
                    tiltedImage = icons[rand]!.rotate(radians: .pi/180*(-3))
                }
                let imageView = UIImageView(image: tiltedImage)
                imageView.layer.zPosition = 1
                imageView.contentMode = .scaleAspectFit
                if(square.fillColor == tileColors[0])   // Gold
                {
                    let imageWidth = (square.path?.boundingBox.height)!*goldFillRatio
                    let imageHeight = (square.path?.boundingBox.height)!*goldFillRatio
                    imageView.frame = CGRect(x: (square.path?.boundingBox.minX)! + imageWidth*(1 - goldFillRatio)/2, y: (square.path?.boundingBox.minY)! + imageHeight*(1 - goldFillRatio)/2, width: imageWidth, height: imageHeight)
                }
                else
                {
                    let imageWidth = (square.path?.boundingBox.height)!*pieceFillRatio
                    let imageHeight = (square.path?.boundingBox.height)!*pieceFillRatio
                    imageView.frame = CGRect(x: (square.path?.boundingBox.minX)! + imageWidth*(1 - pieceFillRatio)/2, y: (square.path?.boundingBox.minY)! + imageHeight*(1 - pieceFillRatio)/2, width: imageWidth, height: imageHeight)
                }
                view.addSubview(imageView)
                imageBoard[i].insert(imageView, at: j)
                if(rand == 4)   // If it's a skull, give it hp
                {
                    gameBoard[i][j].name = String(skullHPLevel)
                    let skullHPText = UILabel(frame: CGRect(x: imageBoard[i][j].layer.bounds.maxX - imageBoard[i][j].layer.bounds.width/5, y: imageBoard[i][j].layer.bounds.minY, width: imageBoard[i][j].layer.bounds.width/5, height: imageBoard[i][j].layer.bounds.height))
                    skullHPText.adjustsFontSizeToFitWidth = true
                    skullHPText.numberOfLines = 3
                    skullHPText.lineBreakMode = .byWordWrapping
                    skullHPText.font = UIFont(name: skullHPText.font.fontName, size: skullHPText.frame.width)
                    let tempText = NSMutableAttributedString(string: String(skullDmgLevel) + "\n" + String(skullArmLevel) + "\n" + gameBoard[i][j].name!)
                    tempText.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.white, range: NSRange(location:0,length:2))
                    tempText.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.blue, range: NSRange(location:2,length:2))
                    tempText.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red, range: NSRange(location:4,length:1))
                    skullHPText.attributedText = tempText
                    skullHPText.layer.zPosition = imageBoard[i][j].layer.zPosition + 1
                    skullHPText.textAlignment = .center
                    view.addSubview(skullHPText)
                    imageBoard[i][j].addSubview(skullHPText)
                    imageBoard[i][j].bringSubviewToFront(skullHPText)
                }
                else
                {
                    gameBoard[i][j].name = "0"
                }
            }
        }
    }
    func initGold()
    {
        let goldBorder = CAShapeLayer()
        let borderWidth = CGFloat(2)
        let lineWidth = CGFloat(1)
        let xPos = borderWidth/2 + screenWidth*0.125/6
        let height = (botBorder.path!.boundingBox.maxY - botLight.path!.boundingBox.maxY - borderWidth)
        goldBorder.path = UIBezierPath(roundedRect: CGRect(x: xPos, y: botLight.path!.boundingBox.maxY + borderWidth/2, width: screenWidth*1.5/6 - borderWidth, height: height), cornerRadius: 0).cgPath
        goldBorder.lineCap = CAShapeLayerLineCap.square
        goldBorder.fillColor = UIColor.clear.cgColor
        goldBorder.strokeColor = goldBlue.cgColor
        goldBorder.lineWidth = borderWidth
        goldBorder.zPosition = 2
        view.layer.addSublayer(goldBorder)
        for i in 0...4
        {
            goldPool.append([])
            for j in 0...19
            {
                let width = (screenWidth*1.5/6 - lineWidth*2 - borderWidth)/5
                let height = (botBorder.path!.boundingBox.maxY - botLight.path!.boundingBox.maxY - 1*lineWidth - borderWidth)/20
                let xPos = ((screenWidth*1.5/6 - borderWidth)/5)*CGFloat(i) + lineWidth/2 + screenWidth*0.125/6
                let yPos = (botLight.path?.boundingBox.maxY)! + lineWidth/2 + borderWidth/2 + height*CGFloat(j)
                let gold = CAShapeLayer()
                gold.zPosition = 1
                gold.path = UIBezierPath(roundedRect: CGRect(x: xPos, y: yPos, width: width, height: height), cornerRadius: 0).cgPath
                gold.fillColor = UIColor.clear.cgColor
                gold.strokeColor = goldBlue.cgColor
                gold.lineWidth = lineWidth
                gold.frame = view.bounds
                gold.zPosition = 1
                view.layer.addSublayer(gold)
                goldPool[i].insert(gold, at: j)
            }
        }
    }
    func initArmor()
    {
        let armorCount = 100
        let borderWidth = CGFloat(4)
        let height = (screenHeight - screenWidth)*CGFloat(0.0625)
        let width = screenWidth*CGFloat(0.333333333333) + screenWidth*CGFloat(0.0833333333333)
        let xPos = (screenWidth - width)/2 + borderWidth/2
        let yPos = botBorder.path!.boundingBox.maxY - height*CGFloat(2) - CGFloat(1.5)*borderWidth
        let armorBorder = CAShapeLayer()
        armorBorder.path = UIBezierPath(roundedRect: CGRect(x: xPos, y: yPos, width: width - borderWidth, height: height), cornerRadius: 0).cgPath
        armorBorder.lineCap = CAShapeLayerLineCap.square
        armorBorder.fillColor = UIColor.clear.cgColor
        armorBorder.strokeColor = armorBlue.cgColor
        armorBorder.lineWidth = borderWidth
        view.layer.addSublayer(armorBorder)
        armorBorder.zPosition = 1
        armorText = UILabel(frame: CGRect(x: screenWidth/2 - width/4/2, y: (armorBorder.path?.boundingBox.minY)! - CGFloat(1.5)*height, width: width/4, height: height))
        armorText.textColor = armorTextColor
        armorText.layer.zPosition = 3
        armorText.textAlignment = .center
        armorText.adjustsFontSizeToFitWidth = true
        self.view.addSubview(armorText)
        let armorWidth = (armorBorder.path!.boundingBox.width - borderWidth)/CGFloat(armorCount)
        for i in 0...(armorCount - 1)
        {
            let armor = CAShapeLayer()
            armor.zPosition = 0
            armor.path = UIBezierPath(roundedRect: CGRect(x: xPos + borderWidth/2 + armorWidth*CGFloat(i), y: yPos + borderWidth/2, width: (width - CGFloat(2)*borderWidth)/CGFloat(armorCount), height: height - borderWidth), cornerRadius: 0).cgPath
            if(i < armorCount/2)
            {
                armor.fillColor = UIColor.blue.cgColor
            }
            else
            {
                armor.fillColor = UIColor.clear.cgColor
            }
            armor.zPosition = 1
            view.layer.addSublayer(armor)
            armorPool.append(armor)
        }
    }
    func initExp()
    {
        let expCount = 100
        let borderWidth = CGFloat(4)
        let height = (screenHeight - screenWidth)/16
        let width = screenWidth/3 + screenWidth*CGFloat(0.0833333333333)
        let xPos = (screenWidth - width)/2 + borderWidth/2
        let yPos = botBorder.path!.boundingBox.maxY - height - borderWidth/2
        let expBorder = CAShapeLayer()
        expBorder.path = UIBezierPath(roundedRect: CGRect(x: xPos, y: yPos, width: width - borderWidth, height: height), cornerRadius: 0).cgPath
        expBorder.lineCap = CAShapeLayerLineCap.square
        expBorder.fillColor = UIColor.clear.cgColor
        expBorder.strokeColor = expGreen.cgColor
        expBorder.lineWidth = borderWidth
        expBorder.zPosition = 1
        view.layer.addSublayer(expBorder)
        let expWidth = (expBorder.path!.boundingBox.width - borderWidth)/CGFloat(expCount)
        for i in 0...(expCount - 1)
        {
            let exp = CAShapeLayer()
            exp.zPosition = 0
            exp.path = UIBezierPath(roundedRect: CGRect(x: xPos + borderWidth/2 + expWidth*CGFloat(i), y: yPos + borderWidth/2, width: expWidth, height: height - borderWidth), cornerRadius: 0).cgPath
            if(i < expCount/2)
            {
                exp.fillColor = UIColor.green.cgColor
            }
            else
            {
                exp.fillColor = UIColor.clear.cgColor
            }
            exp.zPosition = 1
            view.layer.addSublayer(exp)
            expPool.append(exp)
        }
    }
    func initHP()
    {
        let hpBorder = CAShapeLayer()
        let hpCount = CGFloat(100)
        let borderWidth = CGFloat(2)
        let xPos = screenWidth*CGFloat(0.75) + borderWidth/2 - screenWidth*CGFloat(0.0208333333333)
        let yPos = botLight.path!.boundingBox.maxY + borderWidth/2
        let width = screenWidth*CGFloat(0.25) - borderWidth
        let height = (botBorder.path!.boundingBox.maxY - botLight.path!.boundingBox.maxY - borderWidth)
        hpBorder.path = UIBezierPath(roundedRect: CGRect(x: xPos, y: yPos, width: width, height: height), cornerRadius: 0).cgPath
        hpBorder.lineCap = CAShapeLayerLineCap.square
        hpBorder.fillColor = UIColor.clear.cgColor
        hpBorder.strokeColor = lightRed.cgColor
        hpBorder.lineWidth = borderWidth
        hpBorder.zPosition = 1
        hpText = UILabel(frame: CGRect(x: xPos + width/4, y: yPos + height*CGFloat(0.75), width: width/2, height: height/4))
        hpText.text = "Test"
        hpText.textColor = hpTextColor
        hpText.layer.zPosition = 3
        hpText.textAlignment = .center
        hpText.adjustsFontSizeToFitWidth = true
        self.view.addSubview(hpText)
        view.layer.addSublayer(hpBorder)
        for i in 0...Int(hpCount - 1)
        {
            let hp = CAShapeLayer()
            hp.path = UIBezierPath(roundedRect: CGRect(x: xPos + borderWidth/2, y: botBorder.path!.boundingBox.maxY - borderWidth - (height - borderWidth)/hpCount*CGFloat(i + 1), width: screenWidth*CGFloat(0.25) - CGFloat(2)*borderWidth, height: (height - CGFloat(2)*borderWidth)/(hpCount)), cornerRadius: 0).cgPath
            if(i < Int(hpCount/2))
            {
                hp.fillColor = UIColor.red.cgColor
            }
            else
            {
                hp.fillColor = UIColor.clear.cgColor
            }
            hp.zPosition = 1
            view.layer.addSublayer(hp)
            hpPool.append(hp)
        }
    }
    func shrinkCoords(i: Int, j: Int)   // Shrink Piece
    {
        let imageWidth = imageBoard[i][j].frame.width*pieceShrinkRatio
        let imageHeight = imageBoard[i][j].frame.height*pieceShrinkRatio
        imageBoard[i][j].frame = CGRect(x: imageBoard[i][j].frame.minX + imageWidth*CGFloat(1 - pieceShrinkRatio)*CGFloat(0.5), y: imageBoard[i][j].frame.minY + imageHeight*CGFloat(1 - pieceShrinkRatio)*CGFloat(0.5), width: imageWidth, height: imageHeight)
    }
    func growCoords(i: Int, j: Int)
    {
        let squareSide = (backBoard.path?.boundingBox.width)!/6
        var imageWidth = CGFloat(0)
        var imageHeight = CGFloat(0)
        if(gameBoard[i][j].fillColor == tileColors[0])   // Gold
        {
            imageWidth = squareSide*goldFillRatio
            imageHeight = squareSide*goldFillRatio
        }
        else
        {
            imageWidth = squareSide*pieceFillRatio
            imageHeight = squareSide*pieceFillRatio
        }
        if(imageBoard[i][j].frame.width != imageWidth)
        {
            imageBoard[i][j].frame = CGRect(x: (backBoard.path?.boundingBox.minX)! + (backBoard.path?.boundingBox.width)!*CGFloat(0.166666666667)*CGFloat(j) + ((backBoard.path?.boundingBox.width)!/6 - imageWidth)/2, y: (backBoard.path?.boundingBox.minY)! + (backBoard.path?.boundingBox.width)!*CGFloat(0.166666666667)*CGFloat(i) + ((backBoard.path?.boundingBox.height)!/6 - imageHeight)/2, width: imageWidth, height: imageHeight)
        }
    }
    func darkenScreen(myPoint: CGPoint)
    {
        for i in 0...gameBoard.count - 1
        {
            for j in 0...gameBoard[i].count - 1
            {
                if(gameBoard[i][j].fillColor == checkColors(location: myPoint))
                {
                    // Do nothing
                }
                else if(checkColors(location: myPoint) == tileColors[2] || checkColors(location: myPoint) == tileColors[4]) // Skulls and Swords
                {
                    if(gameBoard[i][j].fillColor == tileColors[2] || gameBoard[i][j].fillColor == tileColors[4])
                    {
                        // Do nothing
                    }
                    else
                    {
                        imageBoard[i][j].alpha = 0.5    // Darken
                    }
                }
                else
                {
                    imageBoard[i][j].alpha = 0.5    // Darken
                }
            }
        }
    }
    func lightenScreen()
    {
        for i in 0...gameBoard.count - 1
        {
            for j in 0...gameBoard[i].count - 1
            {
                imageBoard[i][j].alpha = 1.0
                growCoords(i: i, j: j)  // Reset image size
            }
        }
    }
    @objc func useSkill(_ sender: UIButton)
    {
        self.view.isUserInteractionEnabled = false
        UIView.animate(withDuration: consumeDuration*2, animations:
        {

        }, completion:
        { (finished: Bool) in
            self.view.isUserInteractionEnabled = true
        })
        if(!usingSkill)
        {
            usingSkill = true
            skillUsed = -1
            var toggled = false
            for i in 0...mySkills.count - 1
            {
                if(mySkills[i] == sender)
                {
                    if(turnsLeft[i] == 0 && !toggled)
                    {
                        if(i != 2)
                        {
                            for j in 0...3
                            {
                                if(i != j)
                                {
                                    turnsLeft[j] += 1
                                }
                            }
                        }
                        toggled = true
                    }
                }
            }
            if(toggled)
            {
                if(sender.titleLabel?.text == "Repair" && turnsLeft[0] == 0)
                {
                    skillUsed = 0
                    var armorExists = false
                    for i in 0...5  //gameBoard.count - 1
                    {
                        for j in 0...5  //gameBoard[i].count - 1
                        {
                            if(gameBoard[i][j].fillColor == tileColors[1])
                            {
                                armorExists = true
                                points.append(CGPoint(x: (gameBoard[i][j].path?.boundingBox.midX)! - radius, y: (gameBoard[i][j].path?.boundingBox.midY)! - radius))
                                path.append(CAShapeLayer())
                            }
                        }
                    }
                    if(armorExists)
                    {
                        for i in 0...turnsLeft.count - 1
                        {
                            if(i != 0)
                            {
                                turnsLeft[i] += 1
                            }
                        }
                        skillJustUsed = true
                        touchesEnded(Set<UITouch>(), with: UIEvent())
                        turnsLeft[0] = maxTurns[0] - skillLevels[0]
                        sender.layer.borderColor = UIColor.black.cgColor
                    }
                    else
                    {
                        for i in 0...turnsLeft.count - 1
                        {
                            if(i != 0)
                            {
                                turnsLeft[i] -= 1
                            }
                        }
                        updateSkillFill()
                    }
                }
                else if(sender.titleLabel?.text == "Heal" && turnsLeft[1] == 0)
                {
                    skillUsed = 1
                    var hpExists = false
                    for i in 0...5  //gameBoard.count - 1
                    {
                        for j in 0...5  //gameBoard[i].count - 1
                        {
                            if(gameBoard[i][j].fillColor == tileColors[3])
                            {
                                hpExists = true
                                points.append(CGPoint(x: (gameBoard[i][j].path?.boundingBox.midX)! - radius, y: (gameBoard[i][j].path?.boundingBox.midY)! - radius))
                                path.append(CAShapeLayer())
                            }
                        }
                    }
                    if(hpExists)
                    {
                        for i in 0...turnsLeft.count - 1
                        {
                            if(i != 1)
                            {
                                turnsLeft[i] += 1
                            }
                        }
                        skillJustUsed = true
                        touchesEnded(Set<UITouch>(), with: UIEvent())
                        turnsLeft[1] = maxTurns[1] - skillLevels[1]
                        sender.layer.borderColor = UIColor.black.cgColor
                    }
                    else
                    {
                        for i in 0...turnsLeft.count - 1
                        {
                            if(i != 1)
                            {
                                turnsLeft[i] -= 1
                            }
                        }
                        updateSkillFill()
                    }
                }
                else if(sender.titleLabel?.text == "Masochism" && turnsLeft[2] == 0)
                {
                    skillUsed = 2
                    var goldExists = false
                    for i in 0...5  //gameBoard.count - 1
                    {
                        for j in 0...5  //gameBoard[i].count - 1
                        {
                            if(gameBoard[i][j].fillColor == tileColors[0])
                            {
                                goldExists = true
                                gameBoard[i][j].fillColor = tileColors[4]
                                gameBoard[i][j].name = String(skullHPLevel)
                                let skullHPText = UILabel(frame: CGRect(x: imageBoard[i][j].layer.bounds.maxX - imageBoard[i][j].layer.bounds.width/5, y: imageBoard[i][j].layer.bounds.minY, width: imageBoard[i][j].layer.bounds.width/5, height: imageBoard[i][j].layer.bounds.height))
                                skullHPText.adjustsFontSizeToFitWidth = true
                                skullHPText.numberOfLines = 3
                                skullHPText.lineBreakMode = .byWordWrapping
                                skullHPText.font = UIFont(name: skullHPText.font.fontName, size: skullHPText.frame.width)
                                let tempText = NSMutableAttributedString(string: String(skullDmgLevel) + "\n" + String(skullArmLevel) + "\n" + gameBoard[i][j].name!)
                                tempText.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.white, range: NSRange(location:0,length:2))
                                tempText.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.blue, range: NSRange(location:2,length:2))
                                tempText.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red, range: NSRange(location:4,length:1))
                                skullHPText.attributedText = tempText
                                skullHPText.layer.zPosition = imageBoard[i][j].layer.zPosition + 1
                                skullHPText.textAlignment = .center
                                view.addSubview(skullHPText)
                                imageBoard[i][j].addSubview(skullHPText)
                                imageBoard[i][j].bringSubviewToFront(skullHPText)
                                
                                let tilt = Int(arc4random_uniform(2))
                                var tiltedImage = icons[4]!.rotate(radians: .pi/180)
                                if(tilt == 0)
                                {
                                    tiltedImage = icons[4]!.rotate(radians: .pi/180*3)
                                }
                                if(tilt == 1)
                                {
                                    tiltedImage = icons[4]!.rotate(radians: .pi/180*(-3))
                                }
                                imageBoard[i][j].image = tiltedImage
                            }
                        }
                    }
                    if(goldExists)
                    {
                        turnsLeft[2] = maxTurns[2] - skillLevels[2]
                        sender.layer.borderColor = UIColor.black.cgColor
                    }
                    updateBoardShift()
                }
                else if(sender.titleLabel?.text == "AttackAll" && turnsLeft[3] == 0)
                {
                    skillUsed = 3
                    var enemyExists = false
                    for i in 0...5  //gameBoard.count - 1
                    {
                        for j in 0...5  //gameBoard[i].count - 1
                        {
                            if(gameBoard[i][j].fillColor == tileColors[2] || gameBoard[i][j].fillColor == tileColors[4])
                            {
                                enemyExists = true
                                points.append(CGPoint(x: (gameBoard[i][j].path?.boundingBox.midX)! - radius, y: (gameBoard[i][j].path?.boundingBox.midY)! - radius))
                                path.append(CAShapeLayer())
                            }
                        }
                    }
                    if(enemyExists)
                    {
                        for i in 0...turnsLeft.count - 1
                        {
                            if(i != 3)
                            {
                                turnsLeft[i] += 1
                            }
                        }
                        skillJustUsed = true
                        touchesEnded(Set<UITouch>(), with: UIEvent())
                        turnsLeft[3] = maxTurns[3] - skillLevels[3]
                        sender.layer.borderColor = UIColor.black.cgColor
                    }
                    else
                    {
                        for i in 0...turnsLeft.count - 1
                        {
                            if(i != 3)
                            {
                                turnsLeft[i] -= 1
                            }
                        }
                        updateSkillFill()
                    }
                }
            }
            skillUsed = -1
            updateSkillFill()
            usingSkill = false
        }
    }
    func playSound(soundName: String)
    {
        if(soundEnabled)
        {
            guard let url = Bundle.main.url(forResource: soundName, withExtension: "mp3")
                else
            {
                print("url not found")
                return
            }
            for i in 0...soundArray.count - 1
            {
                for j in 0...soundArray[i].count - 1
                {
                    if(soundArray[i][j] == soundName)
                    {
                        do
                        {
    //                        try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)    // ios 10+
                            if #available(iOS 10.0, *)
                            {
                                try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
    //                            try? AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.ambient)
                            }
                            else    // Fallback on earlier versions
                            {
                            }
                            try AVAudioSession.sharedInstance().setActive(true)
                            
                            if(soundCount >= myPlayers[i].count)
                            {
                                print("reset count")
                                soundCount = 0
                            }
                            else
                            {
                                myPlayers[i][soundCount] = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
                                myPlayers[i][soundCount].play()
                            }
                        }
                        catch let error as NSError
                        {
                            print("error: \(error.localizedDescription)")
                        }
                    }
                }
            }
            if(soundCount < 36)
            {
                soundCount += 1
            }
        }
    }
    func attackSkull(tile: CAShapeLayer)
    {
        tile.name = String(Int(tile.name!)! - currentDamage)
    }
}
extension UIImage
{
    func rotate(radians: Float) -> UIImage?
    {
        var newSize = CGRect(origin: CGPoint.zero, size: self.size).applying(CGAffineTransform(rotationAngle: CGFloat(radians))).size
        newSize.width = floor(newSize.width)
        newSize.height = floor(newSize.height)
        UIGraphicsBeginImageContextWithOptions(newSize, false, self.scale)
        let context = UIGraphicsGetCurrentContext()!
        context.translateBy(x: newSize.width/2, y: newSize.height/2)
        context.rotate(by: CGFloat(radians))
        self.draw(in: CGRect(x: -self.size.width/2, y: -self.size.height/2, width: self.size.width, height: self.size.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}
