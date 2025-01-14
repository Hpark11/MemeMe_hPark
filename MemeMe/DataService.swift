//
//  DataService.swift
//  MemeMe
//
//  Created by connect on 2017. 1. 20..
//  Copyright © 2017년 boostcamp. All rights reserved.
//

import Foundation
import Firebase
import SwiftKeychainWrapper

let DB_BASE = FIRDatabase.database().reference()
let STORAGE_BASE = FIRStorage.storage().reference()

class DataService {
    static let instance = DataService()
    
    // Database References
    private var _REF_BASE = DB_BASE
    private var _REF_POSTS = DB_BASE.child(IdForFirebaseRef.databasePosts)
    private var _REF_USERS = DB_BASE.child(IdForFirebaseRef.databaseUsers)
    
    // Storage References
    private var _REF_ST_POST_IMAGES = STORAGE_BASE.child(IdForFirebaseRef.storageImages)
    
    // User currently signed in
    
    var REF_BASE: FIRDatabaseReference {
        return _REF_BASE
    }
    
    var REF_POSTS: FIRDatabaseReference {
        return _REF_POSTS
    }
    
    var REF_USERS: FIRDatabaseReference {
        return _REF_USERS
    }
    
    var REF_USER_CURRENT: FIRDatabaseReference? {
        guard let uid = KeychainWrapper.standard.string(forKey: IdForKeyChain.uid) else {
            return nil
        }
        let user = REF_USERS.child(uid)
        return user
    }
    
    var REF_ST_POST_IMAGES: FIRStorageReference {
        return _REF_ST_POST_IMAGES
    }
    
    
    func createFirebaseDatabaseUser(uid: String, dataUser: Dictionary<String, String>) {
        REF_USERS.child(uid).updateChildValues(dataUser)
    }
}
