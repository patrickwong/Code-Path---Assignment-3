//
//  ViewController.swift
//  Assignment 3
//
//  Created by Patrick Wong on 2/20/15.
//  Copyright (c) 2015 Patrick Wong. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var scrollViewContent: UIView!
    @IBOutlet weak var message: UIImageView!
    @IBOutlet weak var messageContainer: UIView!
    @IBOutlet weak var archiveIcon: UIImageView!
    @IBOutlet weak var laterIcon: UIImageView!
    @IBOutlet weak var feed: UIImageView!
    @IBOutlet weak var reschedule: UIButton!
    @IBOutlet weak var list: UIButton!
    @IBOutlet weak var contentView: UIView!
    
    var messageInitialX: CGFloat!
    var messageInitialXPanBegan: CGFloat!
    var messageFinalX: CGFloat!
    var archiveIconInitialX: CGFloat!
    var laterIconInitialX: CGFloat!
    var screenWidth: CGFloat!
    var contentViewInitialX: CGFloat!
    var contentViewFinalX: CGFloat!
    
    var grey = UIColor(hue: 225/355, saturation: 2/100, brightness: 90/100, alpha: 1)
    var green = UIColor(hue: 105/355, saturation: 100/100, brightness: 80/100, alpha: 1)
    var red = UIColor(hue: 1, saturation: 1, brightness: 1, alpha: 1)
    var yellow = UIColor(hue: 50/355, saturation: 1, brightness: 1, alpha: 1)
    var brown = UIColor(hue: 35/355, saturation: 15/100, brightness: 65/100, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        scrollView.contentSize = scrollViewContent.frame.size
        messageInitialX = message.frame.origin.x
        contentViewInitialX = contentView.frame.origin.x
        
        screenWidth = scrollViewContent.frame.width
        println (screenWidth)
        
        archiveIcon.alpha = 0
        laterIcon.alpha = 0
        archiveIconInitialX = archiveIcon.frame.origin.x
        laterIconInitialX = laterIcon.frame.origin.x
        reschedule.alpha = 0
        list.alpha = 0
    
        var edgeGesture = UIScreenEdgePanGestureRecognizer(target: self, action: "onEdgePan:")
        edgeGesture.edges = UIRectEdge.Left
        contentView.addGestureRecognizer(edgeGesture)

        contentViewInitialX = contentView.frame.origin.x

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func messageDidPan(sender: UIPanGestureRecognizer) {
        var translation = sender.translationInView(view)
        
        if (sender.state == UIGestureRecognizerState.Began){
            messageInitialX = message.frame.origin.x
            message.backgroundColor = grey

        }  else if (sender.state == UIGestureRecognizerState.Changed){
            messageFinalX = messageInitialX + translation.x
            message.frame.origin.x = messageFinalX

            // Swipe Right
            
                if (self.messageFinalX > 20 && self.messageFinalX < 60) {
                    self.archiveIcon.image = UIImage(named: "archive_icon.png")
                    self.messageContainer.backgroundColor = grey
                    self.archiveIcon.alpha = translation.x / 60
                }
                else if (self.messageFinalX > 60 && self.messageFinalX < 260){
                    self.messageContainer.backgroundColor = green
                    self.archiveIcon.image = UIImage(named: "archive_icon.png")
                    self.archiveIcon.alpha = 1
                    self.archiveIcon.frame.origin.x = translation.x - 40
                }
                else if (self.messageFinalX > 260){
                    self.archiveIcon.image = UIImage(named: "delete_icon.png")
                    self.archiveIcon.alpha = 1
                    self.messageContainer.backgroundColor = red
                    self.archiveIcon.frame.origin.x = translation.x - 40
                }
                else {
                    self.archiveIcon.alpha = 0
                    self.laterIcon.alpha = 0
                    self.messageContainer.backgroundColor = grey
                }
            
            //  Swipe Left
            
                if (self.messageFinalX < -20 && self.messageFinalX > -60) {
                    self.laterIcon.image = UIImage(named: "later_icon.png")
                    self.messageContainer.backgroundColor = grey
                    self.laterIcon.alpha = -translation.x / 60
                }
                else if (self.messageFinalX < -60 && self.messageFinalX > -260){
                    self.messageContainer.backgroundColor = yellow
                    self.laterIcon.image = UIImage(named: "later_icon.png")
                    self.laterIcon.alpha = 1
                    self.laterIcon.frame.origin.x = translation.x + 340
                }
                else if (self.messageFinalX < -260){
                    self.laterIcon.image = UIImage(named: "list_icon.png")
                    self.laterIcon.alpha = 1
                    self.messageContainer.backgroundColor = brown
                }
        }  else if (sender.state == UIGestureRecognizerState.Ended){

            message.frame.origin.x = messageInitialX
            self.message.frame.origin.x = self.messageFinalX
            
            // Swipe Right Release Pan
            
            if(self.messageFinalX > 0 && self.messageFinalX < 60){
                UIView.animateWithDuration(1, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: nil, animations: { () -> Void in
                    self.message.frame.origin.x = self.messageInitialX
                    }, completion: { (finished: Bool) -> Void in
                        //
                })
            } else if (self.messageFinalX > 60 && self.messageFinalX < 260){
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    self.message.frame.origin.x = self.messageFinalX + (self.screenWidth - self.messageFinalX)
                    self.archiveIcon.frame.origin.x = self.message.frame.origin.x - 40
                    self.archiveIcon.alpha = 0
                    }, completion: { (finished: Bool) -> Void in
                        
                    UIView.animateWithDuration(0.25, animations: { () -> Void in
                        self.feed.center.y = self.feed.center.y - self.messageContainer.frame.height
                    })
                })
            } else if (self.messageFinalX > 260){
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.message.frame.origin.x = self.messageFinalX + (self.screenWidth - self.messageFinalX)
                    self.archiveIcon.frame.origin.x = self.message.frame.origin.x - 40
                    self.archiveIcon.alpha = 0
                    }, completion: { (finished: Bool) -> Void in
                    
                    UIView.animateWithDuration(0.25, animations: { () -> Void in
                        self.feed.center.y = self.feed.center.y - self.messageContainer.frame.height
                    })
                })
            } else {
                //
            }
            
            // Swipe Left Release Pan
            
            if(self.messageFinalX < 0 && self.messageFinalX > -60){
                UIView.animateWithDuration(1, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: nil, animations: { () -> Void in
                    self.message.frame.origin.x = self.messageInitialX
                    }, completion: { (finished: Bool) -> Void in
                        //
                })
            } else if (self.messageFinalX < -60 && self.messageFinalX > -260){
                    self.message.frame.origin.x = messageFinalX
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    self.message.frame.origin.x = self.messageFinalX - (self.screenWidth - self.messageFinalX)
                    self.laterIcon.frame.origin.x = self.message.frame.origin.x + 40
                    self.laterIcon.alpha = 0
                    }, completion: { (finished: Bool) -> Void in
                        
                        UIView.animateWithDuration(0.25, animations: { () -> Void in
                            self.reschedule.alpha = 1
                        })
                })
            } else if (self.messageFinalX < -260){
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                        self.message.frame.origin.x = self.messageFinalX - (self.screenWidth - self.messageFinalX)
                        self.laterIcon.frame.origin.x = self.message.frame.origin.x + 40
                        self.laterIcon.alpha = 0
                    }, completion: { (finished: Bool) -> Void in
                        self.list.alpha = 1
                })
            }
        }
    }
    
    @IBAction func rescheduleDidPress(sender: AnyObject) {
        reschedule.alpha = 0
        
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.feed.center.y = self.feed.center.y - self.messageContainer.frame.height
            }) { (finished: Bool) -> Void in
            self.message.frame.origin.x = self.messageInitialX
            self.feed.center.y = self.feed.center.y + self.messageContainer.frame.height
        }
    }
    
    @IBAction func listDidPress(sender: AnyObject) {
        list.alpha = 0
        
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.feed.center.y = self.feed.center.y - self.messageContainer.frame.height
            }) { (finished: Bool) -> Void in
                self.message.frame.origin.x = self.messageInitialX
                self.feed.center.y = self.feed.center.y + self.messageContainer.frame.height
        }
    }

    func onEdgePan(sender: UIScreenEdgePanGestureRecognizer) {
        var translation = sender.translationInView(view)
        var velocity = sender.velocityInView(view)
        var menuDidPan = UIPanGestureRecognizer(target: self, action: "menuPan:")
        
        contentViewFinalX = contentViewInitialX + translation.x

        if (sender.state == UIGestureRecognizerState.Began){
            contentView.frame.origin.x = contentViewInitialX
        }  else if (sender.state == UIGestureRecognizerState.Changed){
            contentView.frame.origin.x = contentViewFinalX
            println("Panning")
        }
        else if (sender.state == UIGestureRecognizerState.Ended){
            if (velocity.x > 0){
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.contentView.frame.origin.x = 270
                     })

            } else if (velocity.x < 0) {
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.contentView.frame.origin.x = self.contentViewInitialX
                    println("Panning left")
                })
            }
        }
    }
    @IBAction func hamburgerDidPress(sender: AnyObject) {
        UIView.animateWithDuration(0.25, animations: { () -> Void in
            self.contentView.frame.origin.x = self.contentViewInitialX
        })
    }
}