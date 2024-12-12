//
//  CoreDataManager.swift
//  Movie
//
//  Created by Tushar Arora on 12/12/24.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {
    
    // MARK: - Properties
    static let shared = CoreDataManager()
    private let entityName = "Movies"
    
    // Managed Object Context
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // Save Movie to Core Data
    func saveMovie(_ movie: MovieResults) {
        let entity = NSEntityDescription.entity(forEntityName: entityName, in: context)!
        let movieEntity = NSManagedObject(entity: entity, insertInto: context)
        
        movieEntity.setValue(movie.id, forKey: "movie_id")
        movieEntity.setValue(movie.title, forKey: "title")
        movieEntity.setValue(movie.overview, forKey: "overview")
        movieEntity.setValue(movie.release_date, forKey: "release_date")
        movieEntity.setValue(movie.poster_path, forKey: "poster_path")
        
        do {
            try context.save()
        } catch let error as NSError {
            print("Failed to save movie: \(error), \(error.userInfo)")
        }
    }
    
    // Fetch Favorite Movies from Core Data
    func fetchFavoriteMovies() -> [MovieResults] {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        
        do {
            let result = try context.fetch(fetchRequest)
            return result.map { movieEntity in
                MovieResults(movieId: movieEntity.value(forKey: "movie_id") as! Int,
                             title: (movieEntity.value(forKey: "title") as? String) ?? "",
                             description: (movieEntity.value(forKey: "overview") as? String) ?? "",
                             releaseDate: (movieEntity.value(forKey: "release_date") as? String) ?? "",
                             posterPath: (movieEntity.value(forKey: "poster_path") as? String) ?? "")
            }
        } catch let error as NSError {
            print("Failed to fetch movies: \(error), \(error.userInfo)")
            return []
        }
    }
    
    // Delete Movie from Core Data
    func deleteMovie(_ movie: MovieResults) {
        guard let mId = movie.id else { return }
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "movie_id == %i", mId)
        
        do {
            let moviesToDelete = try context.fetch(fetchRequest)
            for movieEntity in moviesToDelete {
                context.delete(movieEntity)
            }
            try context.save()
        } catch let error as NSError {
            print("Failed to delete movie: \(error), \(error.userInfo)")
        }
    }
    
    // Check if movie is already saved in Core Data
    func isMovieInFavorites(_ movie: MovieResults) -> Bool {
        guard let mId = movie.id else { return false}
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "movie_id == %i", mId)
        
        do {
            let result = try context.fetch(fetchRequest)
            return !result.isEmpty
        } catch {
            print("Failed to check movie existence: \(error.localizedDescription)")
            return false
        }
    }
}
