//
//  MPCollectionViewController.swift
//  Testo
//
//  Created by oskar morett on 1/31/17.
//  Copyright © 2017 oskar morett. All rights reserved.
//

import UIKit
import Foundation
import Firebase
import Contacts
import ContactsUI

class MPCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
   
   
   var groups = [CNGroup]()
   var contacts = [CNContact]()
   var groupsNames = [String] ()
   let cModel = DataModel.shared
   var selected = ""
   weak var delageta : CellDelegate?

   
   @IBOutlet weak var collectionView: UICollectionView!
   
   
   
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      print(groupsNames.count)
      return groups.count
      
   }
   
   
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mpCollectionCell", for: indexPath) as! MPCollectionViewCell
      cell.groupLabel.text = groups[indexPath.item].name
      var cellIndex = collectionView.indexPathsForVisibleItems

      return cell
   }
   
   
   func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      
      let frontPageVC = self.parent as! FrontPageViewController
      frontPageVC.groupSelected = GroupSelected(name: groups[indexPath.item].name, idetifier: groups[indexPath.item].identifier)
      frontPageVC.performSegue(withIdentifier: "toMenu", sender: groups[indexPath.row])
   }
   
   func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
      var visibleRect = CGRect()
      
      visibleRect.origin = collectionView.contentOffset
      visibleRect.size = collectionView.bounds.size
      
      let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
      
      let visibleIndexPath: IndexPath = collectionView.indexPathForItem(at: visiblePoint)!
      print ("#############################")
      print(visibleIndexPath)
      delageta?.didSelectedSection(section: visibleIndexPath.section)
      
   }
   
   
   
   //MARK: ViewDidLoad ------------------------------------------------------------------------------------------------
   override func viewDidLoad() {
      super.viewDidLoad()
      autorization()
      groups = getGRoups()
      collectionView.reloadData()
      
      let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
      let width = UIScreen.main.bounds.width
      layout.itemSize = CGSize(width: width, height: 130)
      layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
      layout.minimumInteritemSpacing = 0
      layout.minimumLineSpacing = 0
      layout.scrollDirection = .horizontal
      collectionView?.collectionViewLayout = layout
      
      
   }//@
   
   
   
   func getGRoups() -> [CNGroup] {
      
      let store = CNContactStore()
      var allGroups = [CNGroup]()
      do {
         allGroups = try store.groups(matching: nil)
         for groupx in allGroups {
            var groupsId = [String]()
            groupsId.append(groupx.identifier)
            groupsNames.append(groupx.name)
         print ("-------------------------------------------------------------------------")
         print (groupx.name)
         print (groupsNames.count)
         print (groupsId.count)
         groups = allGroups
         }
       } catch {
         print("Error fetching Groups")
         }
   return groups
   }//@
   
   
   
   
   func autorization () {
      
      let status = CNContactStore.authorizationStatus(for: .contacts)
      if status == .authorized {
         collectionView.reloadData()
         
      } else if status == .denied {
         let alert = UIAlertController(title: "Oops!", message: "the acces has been denay,please go to your setting to allow access ", preferredStyle: UIAlertControllerStyle.alert)
         present(alert, animated: true, completion: nil)
      }
      
   }

   
   
   
   
}//END of MPCollectionViewController


extension MPCollectionViewController : CellDelegate {
   internal func didSelectedSection(section: Int) {
      
      collectionView.scrollToItem(at: IndexPath(row: 0, section: section ), at: .top, animated: true)
   }

   
   
   
   
}
