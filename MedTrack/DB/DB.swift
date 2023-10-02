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
    
    }
    
    func creatTable(){
        
        do {
            let fileManager = FileManager.default
            let databaseURL = try Connection("\(dbPath)/mydatabase.sqlite3").description
            
            if fileManager.fileExists(atPath: databaseURL) {
                print("💿✅ La base de données existe déjà. Aucune opération nécessaire.")
                        } else {
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
                        }
                } catch {
                    print("💿❌ error lors de la création de la bdd : \(error)")
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
    
    
    
    
    func saveDataTakePill(nomDuMedicament: String, nombreDeFoisParJour: Int,heureDePrise: Date, heureDePrise2: Date, heureDePrise3: Date, nombreDeComprimes: Int,nombreDeComprimesDansBoite: Int, rappelComprimes: Int) throws {
  
        
        let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm"
        
        let heureDePrise1String = dateFormatter.string(from: heureDePrise)
        let heureDePrise2String = dateFormatter.string(from: heureDePrise2)
        let heureDePrise3String = dateFormatter.string(from: heureDePrise3)
        
        do {
            /// Changé le format des heures en int

                // creation table
            let pillsProgramme = Table("pillsProgrammé")
                // creation donnée de la table
            let id = Expression<Int>("id")
            let nom = Expression<String>("name")
            let nmbFois = Expression<Int>("nmbFois")
            let heureDePrise = Expression<String>("heureDePrise")
            let heureDePrise2 = Expression<String>("heureDePrise2")
            let heureDePrise3 = Expression<String>("heureDePrise3")
            let nmbPills = Expression<Int>("nmbPills")
            // deuxieme vue
            let comprimes = Expression<Int>("comprimes")
            let rappel = Expression<Int>("rappel")
            
            
        // essate de créé la table
            try db.run(pillsProgramme.create(ifNotExists: true) { t in
                       t.column(id, primaryKey: true)
                       t.column(nom)
                       t.column(nmbFois)
                       t.column(heureDePrise)
                       t.column(heureDePrise2)
                       t.column(heureDePrise3)
                       t.column(nmbPills)
                       t.column(comprimes)
                       t.column(rappel)
                   })
            //insert les donnée dans la table
            let insert = pillsProgramme.insert(
                nom <- nomDuMedicament,
                nmbFois <- nombreDeFoisParJour,
                heureDePrise <- heureDePrise1String,
                heureDePrise2 <- heureDePrise2String,
                heureDePrise3 <- heureDePrise3String,
                nmbPills <- nombreDeComprimes,
                comprimes <- nombreDeComprimesDansBoite,
                rappel <- rappelComprimes
            )
            
            print(insert)
            
            // application de insert
            try db?.run(insert)
        } catch {
            throw error
        }
    }
    
    
    func displayDataFromTable() throws -> [PillData] {
        var pillDataArray: [PillData] = []
        do {
            let pillsProgramme = Table("pillsProgrammé")
            let id = Expression<Int>("id")
            let nom = Expression<String>("name")
            let nmbFois = Expression<Int>("nmbFois")
            let heureDePrise = Expression<String>("heureDePrise")
            let heureDePrise2 = Expression<String>("heureDePrise2")
            let heureDePrise3 = Expression<String>("heureDePrise3")
            let nmbPills = Expression<Int>("nmbPills")
            let comprimes = Expression<Int>("comprimes")
            let rappel = Expression<Int>("rappel")
            
            for row in try db.prepare(pillsProgramme) {
                let pillArray = PillData(id: row[id], nom:row[nom], nombreDeFoisParJour: row[nmbFois], heureDePrise1: row[heureDePrise], heureDePrise2: row[heureDePrise2], heureDePrise3: row[heureDePrise3], nombreDeComprimes: row[nmbPills],nombreDeComprimesDansBoite: row[comprimes],rappelComprimes: row[rappel])
                
                pillDataArray.append(pillArray)
                
                print("ID: \(row[id]), Nombre de fois par jour: \(row[nmbFois]), Heure de prise 1: \(row[heureDePrise]), Heure de prise 2: \(row[heureDePrise2]), Heure de prise 3: \(row[heureDePrise3]), Nombre de comprimés: \(row[nmbPills]), Nombre de comprimé dans la boite  : \(row[comprimes]), Ajouter un rappel quand :\(row[rappel])")
            }
        } catch {
            throw error
        }
        return pillDataArray
    }
    
    func delete(idToDelete:Int) throws{
        let pillsProgramme = Table("pillsProgrammé")
        let id = Expression<Int>("id")
        
        let rowToDelete = pillsProgramme.filter(id == idToDelete)
           
           do {
               try db.run(rowToDelete.delete())
               print("Ligne supprimée avec succès.")
           } catch {
               throw error
           }
        
    }
}
