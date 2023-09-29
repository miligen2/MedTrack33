//
//  DB.swift
//  MedTrack
//
//  Created by Angelo Macaire on 29/09/2023.
//test

import SQLite
import Foundation


struct DataManagerMedicament {
    
    private var db: Connection!
    
    private let dbPath = FileManager.default.urls(for: .documentDirectory, in:.userDomainMask).first!
    
    init() {
        do {
            db = try Connection("\(dbPath)/mydatabase.sqlite3")
            
        } catch {
            print("Error initializing the database: \(error)")
        }
        creatTable()
    }
    
    func creatTable(){
        
        do {
                    // Charger le contenu du fichier 'medicament.db'
                    if let bundlePath = Bundle.main.path(forResource: "medicament", ofType: "sql") {
                        let sqlScript = try String(contentsOfFile: bundlePath, encoding: .utf8)
                        
                        // Séparez les instructions SQL en utilisant ";"
                        let sqlStatements = sqlScript.components(separatedBy: ";")
                        
                        // Exécutez chaque instruction SQL dans la nouvelle table
                        for statement in sqlStatements {
                            try db.execute(statement)
                        }
                        
                        print("💿✅ Données insérées avec succès dans la nouvelle table.")
                    } else {
                        print("💿❌ Le fichier 'medicament.db' n'a pas pu être chargé.")
                    }
                } catch {
                    print("💿✅ Base de donnée déja créée  : \(error)")
                }
  }
    
    func loadMedicaments() -> [Medicament] {
        var medicaments: [Medicament] = []
        
        do {
            let medicamentTable = Table("medicament")
            let id = Expression<Int>("id")
            let name = Expression<String>("name")
            
            for row in try db.prepare(medicamentTable) {
                let medicament = Medicament(id: Int64(row[id]), name: row[name])
                medicaments.append(medicament)
            }
        } catch {
            print("Erreur lors de la lecture des médicaments depuis la base de données : \(error)")
        }
        
        return medicaments
    }
        
}

struct DatabaseManager {
     private var db: Connection!
    
    // The path to the SQLite database (storage location)
    private let dbPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
    
    init() {
        do {
            db = try Connection("\(dbPath)/mydatabase.sqlite3")
            
        } catch {
            print("Error initializing the database: \(error)")
        }

    }

    // 1ere partie du rappel
    
    func saveDataTakePill(nombreDeFoisParJour: Int,heureDePrise: Date, heureDePrise2: Date, heureDePrise3: Date, nombreDeComprimes: Int) throws {
        guard db != nil else {
            throw NSError(domain: "DatabaseManagerError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Database not initialized."])
        }
        
        do {
            /// Changé le format des heures en int

            let timestamp1 = Int(heureDePrise.timeIntervalSince1970)
            let timestamp2 = Int(heureDePrise2.timeIntervalSince1970)
            let timestamp3 = Int(heureDePrise3.timeIntervalSince1970)

                // creation table
            let pillsProgramme = Table("pillsProgrammé")
                // creation donnée de la table
            let id = Expression<Int>("id")
            let nmbFois = Expression<Int>("nmbFois")
            let heureDePrise = Expression<Int>("heureDePrise")
            let heureDePrise2 = Expression<Int?>("heureDePrise2")
            let heureDePrise3 = Expression<Int?>("heureDePrise3")
            let nmbPills = Expression<Int>("nmbPills")
            
            
        // essate de créé la table
            try db.run(pillsProgramme.create(ifNotExists: true) { t in
                       t.column(id, primaryKey: true)
                       t.column(nmbFois)
                       t.column(heureDePrise)
                       t.column(heureDePrise2)
                       t.column(heureDePrise3)
                       t.column(nmbPills)
                   })
            //insert les donnée dans la table
            let insert = pillsProgramme.insert(
                id <- id,
                nmbFois <- Int(nombreDeFoisParJour),
                heureDePrise <- timestamp1,
                heureDePrise2 <- timestamp2,
                heureDePrise3 <- timestamp3,
                nmbPills <- nmbPills)
            
            print(insert)
            
            // application de insert
            try db?.run(insert)
        } catch {
            throw error
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    // 2 partie du rappel
    
    
    func saveDataPill(nombreDeComprimesDansBoite: Int, rappelComprimes: Int) throws {
        guard db != nil else {
            throw NSError(domain: "DatabaseManagerError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Database not initialized."])
        }
        
        do {
            let rappelProgramme = Table("rappelPillsProgramme")
        
            let id = Expression<Int>("id")
            let comprimes = Expression<Int>("comprimes")
            let rappel = Expression<Int>("rappel")
            
            
            let statement = rappelProgramme.create(ifNotExists: true) { t in
                            t.column(id, primaryKey: true)
                            t.column(comprimes, unique: true )
                            t.column(rappel)
                        }
            
            let insert = rappelProgramme.insert(id <- id,
                                      comprimes <- nombreDeComprimesDansBoite,
                                      rappel <- rappelComprimes)
            
            print(insert)
            
            try db?.run(statement)
        } catch {
            throw error
        }
    }
}
