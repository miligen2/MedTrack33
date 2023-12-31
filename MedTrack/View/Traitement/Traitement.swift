//
//  Traitement.swift
//  MedTrack
//
//  Created by Angelo Macaire on 29/09/2023.
//

import SwiftUI
import UIKit


struct Traitement: View {
    
    @State var medicamentProgramme = []
    
    @State var isLinkActive = false
    
    @State var isLinkActiveforP2 = false
    
    var db = DataManagerMedicament()
    
    @State public var pillDataArray: [PillData] = []
    
    
    var body: some View {
        NavigationStack {
            ZStack{
                VStack {
                    if pillDataArray.isEmpty {
                        Text("Commençons !")
                            .font(.title2)
                            .fontWeight(.medium)
                            .foregroundColor(.gray)
                            .padding(.bottom, 2.0)
                        
                        Text("Ajoutez votre premier traitement et recevez vos rappels")
                            .font(.body)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 48.0)
                        
                        
                        Button {
                            self.isLinkActive = true
                            self.isLinkActiveforP2 = true
                            
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
                        
                        
                        
                    } else {
                        TraitementRappel(rappelNombreComprimé: pillDataArray, isLinkActive: $isLinkActive)
                    }
                }
            }.onAppear(){
                do {
                    pillDataArray = try db.displayDataFromTable()
                    } catch{
                    print("ok")
                }
            }
        }
        
    }
}




struct traitement_Previews: PreviewProvider {
    static var previews: some View {
        Traitement()
    }
}


struct addMedicament: View {
    
    var dbM = DataManagerMedicament()
    
    @State private var searchText = ""
    @State private var selectedMedicament: String? 
    
    var searchResults: [Medicament] {
        if searchText.isEmpty {
            return []
        } else {
            return dbM.loadMedicaments().filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var body: some View{
        
        NavigationStack {
            List {
                ForEach(searchResults, id: \.self) { medicament in
                    NavigationLink(destination: ProgrammationMed(selectedMedicament: $selectedMedicament)){
                        HStack{
                            Image(systemName: "pill").foregroundColor(Color(hue: 0.313, saturation: 0.957, brightness: 0.627))
                            Text(medicament.name).font(.footnote)
                        }
                    }
                    .onTapGesture {
                        selectedMedicament = medicament.name
                    }
                }
            }.listStyle(.plain).searchable(text: $searchText,placement: .navigationBarDrawer(displayMode: .always), prompt: "Rechercher un médicament")
            
        }
        
    }
    
}
