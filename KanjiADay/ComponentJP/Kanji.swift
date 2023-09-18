import Foundation
import SwiftUI

let kanjiFilename = "kanji.json"

struct Kanji: Identifiable, Codable {
    var id = UUID()
    let character: String
    let meaning: String
    let onyomi: String
    let kunyomi: String
    let grade: Int
    var order: Int
    var offset: CGFloat = 0
    var words: KanjiWords
    var sentences: KanjiSentences

    struct KanjiWords: Codable {
        let this: [String]
        let reading: [String]
        let meaning: [String]
    }

    struct KanjiSentences: Codable {
        let this: [String]
        let reading: [String]
        let meaning: [String]
    }
}


var KanjiList = loadKanjiListFromDisk()

func newKanji(gradesJP: [Int] = [1, 2, 3, 4, 5, 6, 7]) {
    guard let url = Bundle.main.url(forResource: "kanjidict", withExtension: "json") else {
        print("Error: kanjidict.json not found")
        return
    }
    
    guard let data = try? Data(contentsOf: url) else {
        print("Error: failed to read kanjidict.json")
        return
    }
    
    guard let kanjiData = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
        print("Error: failed to parse kanjidict.json")
        return
    }
    
    var kanjiList: [Kanji] = []
    
    for (character, kanjiInfo) in kanjiData {
        guard let kanjiDict = kanjiInfo as? [String: Any],
              let grade = kanjiDict["grade"] as? Int,
              let meaning = kanjiDict["meaning"] as? String,
              let onyomi = kanjiDict["on"] as? String,
              let kunyomi = kanjiDict["kun"] as? String,
              let wordsDict = kanjiDict["words"] as? [String: [String]],
              let sentencesDict = kanjiDict["sentences"] as? [String: [String]]
        else {
            continue
        }
        
        let kanji = Kanji(
            character: character,
            meaning: meaning,
            onyomi: onyomi,
            kunyomi: kunyomi,
            grade: grade,
            order: 0,
            offset: 300,
            words: Kanji.KanjiWords(
                this: wordsDict["this"] ?? [],
                reading: wordsDict["reading"] ?? [],
                meaning: wordsDict["meaning"] ?? []
            ),
            sentences: Kanji.KanjiSentences(
                this: sentencesDict["this"] ?? [],
                reading: sentencesDict["reading"] ?? [],
                meaning: sentencesDict["meaning"] ?? []
            )
        )
        
        kanjiList.append(kanji)
    }

    let filteredKanjiList = kanjiList.filter { gradesJP.contains($0.grade) }
    let newKanjiList = filteredKanjiList.map { kanji in
        var newKanji = kanji
        newKanji.order = 1 // set the order of the new kanji to 0
        return newKanji
    }
    guard let randomKanji = newKanjiList.randomElement() else {
        print("Error: no kanji found for gradesJP \(gradesJP)")
        return
    }
    KanjiList.insert(randomKanji, at: 0)
    // increment the order of all other kanji in the list
    KanjiList = Array(KanjiList.prefix(14))
    for i in 0..<KanjiList.count {
        KanjiList[i].order = i
        if i>0{
            KanjiList[i].offset = 0
        }
    }
    saveKanjiListToDisk()
}

func saveKanjiListToDisk() {
    let encoder = JSONEncoder()
    do {
        let data = try encoder.encode(KanjiList)
        try data.write(to: getKanjiFileURL())
        print("KanjiList saved to disk")
    } catch {
        print("Error saving KanjiList to disk: \(error.localizedDescription)")
    }
}

func loadKanjiListFromDisk() -> [Kanji] {
    do {
        let data = try Data(contentsOf: getKanjiFileURL())
        let decoder = JSONDecoder()
        var kanjiList = try decoder.decode([Kanji].self, from: data)
        print("KanjiList loaded from disk")
        kanjiList[0].offset = 0
        return kanjiList
    } catch {
        print("Error loading KanjiList from disk: \(error.localizedDescription)")
        return []
    }
}

func getKanjiFileURL() -> URL {
    let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    let fileURL = documentsDirectory.appendingPathComponent(kanjiFilename)
    return fileURL
}

func deleteKanjiListFromDisk() {
    let fileManager = FileManager.default
    let fileURL = getKanjiFileURL()
    do {
        try fileManager.removeItem(at: fileURL)
        print("KanjiList deleted from disk")
    } catch {
        print("Error deleting KanjiList from disk: \(error.localizedDescription)")
    }
}
