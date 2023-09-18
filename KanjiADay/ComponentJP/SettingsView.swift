import Foundation
import SwiftUI

let gradesJPFilename = "gradesJP.json"

struct SettingsView: View {
    @Binding var showSettings: Bool
    @Binding var GradesJP: [Int]
    
    var body: some View {
        VStack {
            HStack {

                
                Button(action: {
                    showSettings.toggle()
                }) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 30, weight: .bold))
                        .foregroundColor(.black)
                }
                .padding()
                Text("Settings")
                    .font(.system(size: 30))
                    .fontWeight(.bold)

                Spacer()
            }
            
            VStack(alignment: .leading, spacing: 15) {
                Text("Select GradesJP")
                    .font(.system(size: 25))
                    .fontWeight(.bold)
                    .padding(.leading, 20)
                
                ForEach(1..<8) { grade in
                    HStack {
                        Text("\(grade)")
                            .font(.system(size: 20))
                            .fontWeight(.semibold)
                            .padding(.leading, 20)
                        
                        Spacer()
                        
                        CheckboxView(checked: self.GradesJP.contains(grade)) {
                            if self.GradesJP.contains(grade) {
                                if let index = self.GradesJP.firstIndex(of: grade) {
                                    self.GradesJP.remove(at: index)
                                }
                            } else {
                                self.GradesJP.append(grade)
                            }
                            print(self.GradesJP)
                            saveGradesJPToDisk(GradesJP: self.GradesJP)
                        }

                        .padding(.trailing, 20)
                    }
                }
            }
            
            Button(action: {
                KanjiList = []
                deleteKanjiListFromDisk()
                newKanji(gradesJP: self.GradesJP)
                print("deleted kanjiList")
            }) {
                Text("Clear Deck")
                    .font(.system(size: 20))
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 30)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .padding(.top, 20)
            }
            
            Spacer()
        }
        .background(Color(.systemBackground))
        .onAppear {
            GradesJP = loadGradesJPFromDisk()
        }
    }
}

func saveGradesJPToDisk(GradesJP: [Int]) {
    let encoder = JSONEncoder()
    do {
        let data = try encoder.encode(GradesJP)
        try data.write(to: getGradesJPFileURL())
        print("GradesJP saved to disk")
    } catch {
        print("Error saving GradesJP to disk: \(error.localizedDescription)")
    }
}
func loadGradesJPFromDisk() -> [Int] {
    do {
        let data = try Data(contentsOf: getGradesJPFileURL())
        let decoder = JSONDecoder()
        let gradesJP = try decoder.decode([Int].self, from: data)
        print("GradesJP loaded from disk")
        return gradesJP.isEmpty ? [1,2,3,4,5,6,7] : gradesJP
    } catch {
        print("Error loading GradesJP from disk: \(error.localizedDescription)")
        return [1,2,3,4,5,6,7]
    }
}

func getGradesJPFileURL() -> URL {
    let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    let fileURL = documentsDirectory.appendingPathComponent(gradesJPFilename)
    return fileURL
}

func deleteGradesJPFromDisk() {
    let fileManager = FileManager.default
    let fileURL = getGradesJPFileURL()
    do {
        try fileManager.removeItem(at: fileURL)
        print("GradesJP deleted from disk")
    } catch {
        print("Error deleting GradesJP from disk: \(error.localizedDescription)")
    }
}

struct CheckboxView: View {
    let checked: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: {
            self.action()
        }) {
            if checked {
                Image(systemName: "checkmark.square.fill")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .foregroundColor(.blue)
                
            } else {
                Image(systemName: "square")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .foregroundColor(.gray)
            }
        }
    }
}
