//
//  RealmManager.swift
//  MyNewExampleTest
//
//  Created by bro on 2022/08/03.
//

import Foundation

import RealmSwift
import RxSwift


class RealmManager: DataBaseManagerType {
    
    private init(){ }
    static let shared = RealmManager()
    
    private var list: [MovieItem] = []
    private lazy var storage = BehaviorSubject<[MovieItem]>(value: list)
    
    @discardableResult
    func createMovie(movie: Movie) -> Observable<MovieItem> {
        let localRealm = try! Realm()
        let movieItem = MovieItem.convertMovie(movie: movie)
        
        do {
            try localRealm.write {
                localRealm.add(movieItem)
            }
            return Observable.just(movieItem)
        } catch {
            print("create Error: \(error)")
            return Observable.error(error)
        }
    }
    
    @discardableResult
    func movieList() -> Observable<[MovieItem]> {
        let localRealm = try! Realm()
        let results = localRealm.objects(MovieItem.self)
        var array: [MovieItem] = []
        results.forEach { movieItem in
            array.append(movieItem)
        }
        return Observable.just(array)
    }
    
    @discardableResult
    func update(oldMovie: MovieItem, newMovie: MovieItem) -> Observable<MovieItem> {
        let localRealm = try! Realm()
        if let oldMovie = localRealm.objects(MovieItem.self).where({ $0._id == oldMovie._id}).first {
            do {
                try localRealm.write { () -> Observable<MovieItem> in
                    let update = MovieItem.updateMovie(oldMovie: oldMovie, updateMovie: newMovie)
                    return Observable.just(update)
                }
            } catch {
                print("update Error: \(error)")
                return Observable.error(error)
            }
        }
        
        return Observable.just(MovieItem())
    }
    
    @discardableResult
    func delete(movie: MovieItem) -> Observable<MovieItem> {
        let localRealm = try! Realm()
        do {
            try localRealm.write {
                localRealm.delete(movie)
            }
            return Observable.just(movie)
        } catch {
            print("Error Delete : \(error)")
            return Observable.error(error)
        }
    }
    
    func checkFavorite(title: String, pubDate: String) -> Bool {
        let localRealm = try! Realm()
        
        let checkItem = localRealm.objects(MovieItem.self).where({
            $0.title == title || $0.pubDate == pubDate
        }).first
        
        return checkItem != nil ? true : false
    }
    
    
}
