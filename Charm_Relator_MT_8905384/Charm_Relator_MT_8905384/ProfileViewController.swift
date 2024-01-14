//
//  ProfileViewController.swift
//  Midterm
//
//  Created by Charm Johannes Relator on 2023-11-02.

// Logo and image used on the landing screen for this application: <a href="https://www.freepik.com/free-vector/dry-leaves-falling-off-tree_19589032.htm#query=autumn%20tree&position=5&from_view=search&track=ais">Image by brgfx</a> on Freepik
//

import UIKit

class ProfileViewController: UIViewController {
    
    var currentImgIndex = 0;
    var profPicArr: [String] = ["pCopslayer.jpg"
                                         ,"pBookworm.jpg"
                                         ,"pFall.jpg"
                                         ,"pBoholForest.jpg"
                                         ,"pTechVolunteer.jpg"
                                        ];
    @IBOutlet weak var profileImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //set currentIndex here
        currentImgIndex = 2;
        // Do any additional setup after loading the view.
        
        
        // I decided to play with the swipe gesture recognizer. Struggled with constraining the arrows so I did this.
        let leftRecognizer = UISwipeGestureRecognizer(target: self, action:
        #selector(changePhoto(_:)))
           leftRecognizer.direction = .left
        let rightRecognizer = UISwipeGestureRecognizer(target: self, action:
        #selector(changePhoto(_:)))
           rightRecognizer.direction = .right
           self.view.addGestureRecognizer(leftRecognizer)
           self.view.addGestureRecognizer(rightRecognizer)
    }
    
    // allows to view other pictures by swiping left or right.
    @IBAction func changePhoto(_ sender: UISwipeGestureRecognizer) {
        // goes clockwise
        if sender.direction == .left {
            if currentImgIndex < 4 {
                currentImgIndex += 1;
            } else {
                currentImgIndex = 0;
            }
            
        // goes counterclockwise
        } else if sender.direction == .right {
            if currentImgIndex > 0 {
                currentImgIndex -= 1;
            } else {
                currentImgIndex = 4;
            }
        }
  
        // name of the picture is retrieved using the index
        profileImage.image = UIImage(named: profPicArr[currentImgIndex]);
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
