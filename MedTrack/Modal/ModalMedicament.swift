import Foundation

struct Medicament:Identifiable,Hashable {
    let id : Int64
    let name : String
}

struct PillData {
    let id: Int
    let nom: String
    let nombreDeFoisParJour: Int
    let heureDePrise1: String
    let heureDePrise2: String
    let heureDePrise3: String
    let nombreDeComprimes: Int
    let nombreDeComprimesDansBoite: Int
    let rappelComprimes: Int
}
