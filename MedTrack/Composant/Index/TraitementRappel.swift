//
//  TraitementRappel.swift
//  MedTrack
//
//  Created by Angelo Macaire on 29/09/2023.
//

import SwiftUI

struct TraitementRappel: View {
    
    
    @State var rappelNombreComprimé: [PillData]
    @Binding var isLinkActive: Bool
    var db = DataManagerMedicament()
    
    @State private var isAlertActive = false
    @State private var selectedMedicamentID: Int?
    
    var body: some View {
        VStack{
            List{
                ForEach(rappelNombreComprimé, id: \.id) { rappel in
                    Section{
                        ZStack { 
                        VStack {
                            HStack {
                                Image(systemName: "pills")
                                    .font(.title)
                                    .foregroundColor(Color(red: 0.596, green: 0.878, blue: 0.599))
                                
                                Text("\(rappel.nom)")
                                    .font(.title3)
                                    .fontWeight(.bold)
                                
                                Spacer()
                                
                                
                                
                            }.padding(.bottom, 1.0)
                            HStack{
                                Text("\(rappel.nombreDeFoisParJour) fois par jour - 08:00 et 20:00")
                                Spacer()
                                
                            }
                            
                            HStack{
                                // nombre de comprimé dans la boite de medicament
                                Text("Il reste \(rappel.nombreDeComprimesDansBoite) Comprimé(s)")
                                    .frame(width: 200.0, height: 34.0)
                                    .font(.headline)
                                    .background(.gray.opacity(0.5))
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                
                                Spacer()
                                Image(systemName: "bell").font(.title).foregroundColor(Color(red: 0.596, green: 0.878, blue: 0.599))
                                
                            }
                            
                            
                        }.padding(1.0)
                            
                            VStack{
                                HStack{
                                    Spacer()
                                    Button {
                                        selectedMedicamentID = rappel.id
                                        isAlertActive = true

                                } label: {
                                    Image(systemName: "xmark").foregroundStyle(.red)
                                }.alert("Êtes-vous sûr de le supprimer ?", isPresented: $isAlertActive) {
                                    Button("Annuler", role: .cancel) { }
                                    Button("Supprimer", role: .destructive) {
                                        if let idToDelete = selectedMedicamentID {
                                            do {
                                                try db.delete(idToDelete: idToDelete) // Supprimez le médicament de la base de données
                                            } catch {
                                                print("Probleme de suppression de l'objet : \(error)")
                                            }
                                        }
                                    }
                                }
                                }
                                Spacer()
                            }
                    }
                    }
                }.frame(width:310, height: 150.0)
                
                
            }
            Button {
                self.isLinkActive = true
                db.creatTable()
            } label: {
                Text("Ajouter un rappel")
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(50)
            }.navigationDestination(isPresented: $isLinkActive) {
                addMedicament()
            }
        }
        
    }
}

struct TraitementRappel_Previews: PreviewProvider {
    static var previews: some View {
        let testData: [PillData] = [
            PillData(id: 1, nom: "Test", nombreDeFoisParJour: 2, heureDePrise1: "08:00", heureDePrise2: "20:00", heureDePrise3: "", nombreDeComprimes: 4, nombreDeComprimesDansBoite: 12, rappelComprimes: 1),
            PillData(id: 2, nom: "test", nombreDeFoisParJour: 3, heureDePrise1: "08:00", heureDePrise2: "14:00", heureDePrise3: "20:00", nombreDeComprimes: 3, nombreDeComprimesDansBoite: 15, rappelComprimes: 1),
                // Ajoutez d'autres données fictives ici si nécessaire
            ]
        TraitementRappel(rappelNombreComprimé: testData, isLinkActive: .constant(false))
    }
}

