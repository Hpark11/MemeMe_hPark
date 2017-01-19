//
//  PopupNewPostViewController_ext.swift
//  MemeMe
//
//  Created by connect on 2017. 1. 19..
//  Copyright © 2017년 boostcamp. All rights reserved.
//

import UIKit
import CoreData

extension PopupNewPostViewController: UITableViewDelegate, UITableViewDataSource {
    func establishMemeCell(cell: MemeTableViewCell, indexPath: IndexPath) {
        let meme = self.memeController.object(at: indexPath)
        cell.establishMemeCell(meme: meme)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = memeTableView.dequeueReusableCell(withIdentifier: KEY_MEME_TABLE_CELL, for: indexPath) as! MemeTableViewCell
        establishMemeCell(cell: cell, indexPath: indexPath)
        return UITableViewCell()
    }
    
    // when selected particular cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let objects = memeController.fetchedObjects, objects.count > 0 {
            let meme = objects[indexPath.row]
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = memeController.sections {
            let sectionInfo = sections[section]
            return sectionInfo.numberOfObjects
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 84.0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if let sections = memeController.sections {
            return sections.count
        }
        return 0
    }
}


extension PopupNewPostViewController: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        memeTableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        memeTableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch(type) {
        case .insert:
            if let indexPath = newIndexPath {
                memeTableView.insertRows(at: [indexPath], with: .fade)
            }
            break
        case .delete:
            if let indexPath = indexPath {
                memeTableView.deleteRows(at: [indexPath], with: .fade)
            }
            break
        case .update:
            if let indexPath = indexPath {
                let cell = memeTableView.cellForRow(at: indexPath) as! MemeTableViewCell
                establishMemeCell(cell: cell, indexPath: indexPath)
            }
            break
        case .move:
            if let indexPath = indexPath {
                memeTableView.deleteRows(at: [indexPath], with: .fade)
            }
            if let indexPath = newIndexPath {
                memeTableView.insertRows(at: [indexPath], with: .fade)
            }
            break
        }
    }
}

extension PopupNewPostViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let sections = memeController.sections else {
            return 0
        }
        let sectionInfo = sections[section]
        return sectionInfo.numberOfObjects
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = memeCollectionView.dequeueReusableCell(withReuseIdentifier: KEY_MEME_COLLECTION_CELL, for: indexPath) as! MemeCollectionViewCell
        let meme = self.memeController.object(at: indexPath)
        cell.establishMemeCell(meme: meme)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let objects = memeController.fetchedObjects, objects.count > 0 {
            let meme = objects[indexPath.row]
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        guard let sections = memeController.sections else {
            return 0
        }
        return sections.count
    }
}
