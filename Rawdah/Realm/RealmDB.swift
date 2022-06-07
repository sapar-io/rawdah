//
//  RealmDB.swift
//  Rawdah
//
//  Created by Sapar Jumabekov on 30.05.2022.
//

import Foundation
import RealmSwift

class LearnedName: Object {
    @Persisted var id: Int
    @Persisted var learned: Bool
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

class PassedQuiz: Object {
    @Persisted var id: Int
    @Persisted var passed: Bool
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

class RealmDB {
    let realm = try! Realm()
    
    func learnedNames() -> [LearnedName] {
        let names = realm.objects(LearnedName.self)
        return Array(names)
    }
    
    func isLearnedName(id: Int) -> Bool {
        let name = realm.object(ofType: LearnedName.self, forPrimaryKey: id)
        return name?.learned ?? false
    }
    
    func learnName(id: Int, learned: Bool, completion: (() -> Void)?) {
        let name = LearnedName()
        name.id = id
        name.learned = learned
        try! realm.write {
            realm.add(name)
            completion?()
        }
    }
    
    func passedQuizes() -> [PassedQuiz] {
        let quizes = realm.objects(PassedQuiz.self)
        return Array(quizes)
    }
    
    func isPassedQuiz(id: Int) -> Bool {
        let quiz = realm.object(ofType: PassedQuiz.self, forPrimaryKey: id)
        return quiz?.passed ?? false
    }
    
    func passQuiz(id: Int, passed: Bool, completion: (() -> Void)?) {
        let name = PassedQuiz()
        name.id = id
        name.passed = passed
        try! realm.write {
            realm.add(name)
            completion?()
        }
    }
}
