//
//  HomeJP.swift
//  KanjiADay
//
//  Created by Chris Straw on 5/21/23.
//

import Foundation
import SwiftUI

struct HomeJP : View {
    @State var renList = KanjiList
    @State var swiped = 0
    @Namespace var name
    @Binding var showSettings: Bool
    @Binding var Grades: [Int]
    @State var selected: Kanji = Kanji(
        character: "default",
        meaning: "default",
        onyomi: "default",
        kunyomi: "default",
        grade: 1,
        order: 0,
        offset: 0,
        words: Kanji.KanjiWords(
            this: ["default", "default", "default"],
            reading: ["default", "default", "default"],
            meaning: ["default", "default", "default"]
        ),
        sentences: Kanji.KanjiSentences(
            this: [
                "default1",
                "default2",
                "default3"
            ],
            reading: [
                "default1",
                "default2",
                "default3"
            ],
            meaning: [
                "default1",
                "default2",
                "default3"
            ]
        )
    )

    @State var show = false
    var body: some View{
        ZStack{
            VStack{
                HStack{
                    VStack(alignment: .leading, spacing: 5) {
                        
                        Text("Kanji a Day")
                            .font(.system(size: 45))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        
                        /*HStack(spacing: 15){
                            Text("Languages")
                                .font(.system(size: 25))
                                .fontWeight(.bold)
                                .foregroundColor(Color.white.opacity(0.7))
                            
                            Button(action: {}){
                                Image(systemName:"chevron.down")
                                    .font(.system(size: 25))
                                    .foregroundColor(Color.orange)
                            }
                        }*/


                    }
                    .padding()
                    Spacer()
                }
                .padding()
                
                
                GeometryReader{reader in
                    ZStack{
                        ForEach(renList.reversed()){kanji in
                            CardJP(kanji: kanji, reader: reader, swiped: $swiped,show:$show,selected: $selected,name:name)
                                .offset(x:CGFloat(kanji.offset))
                                .rotationEffect(.init(degrees: getRotation(offset: kanji.offset)))
                                .gesture(DragGesture().onChanged({(value) in
                                    
                                    withAnimation {
                                        renList[kanji.order].offset = value.translation.width
                                        
                                    }
                                }).onEnded({ (value) in
                                    withAnimation {
                                        
                                        if abs(value.translation.width) > 150{
                                            renList[kanji.order].offset = value.translation.width*5
                                            
                                            
                                            swiped = kanji.order + 1
                                        
                                            restoreLocal()
                                        }
                                        else{
                                            renList[kanji.order].offset = 0
                                
                                        }
                                    }
                                              
                                }))
                        }
                    }
                }
                HStack{
                    Button(action: {
                        newKanji(gradesJP: Grades)
                        renList = KanjiList
                        /*print("newKanji")
                        for i in 0..<KanjiList.count{
                            print(KanjiList[i].character,KanjiList[i].order)
                        }*/
                        renList[0].offset=300
                        withAnimation{
                            renList[0].offset=0
                        }

                        
                    }) {
                        Image(systemName: "arrow.clockwise.circle.fill")
                            .font(.system(size: 40))
                            .foregroundColor(.white)
                    }
                    .padding()
                    .background(Color.orange)
                    .clipShape(Circle())
                    .shadow(radius: 10)
                    .padding(.bottom, 20)
                    .padding(.leading, 20)
                    Spacer()
                    Button(action: {
                        showSettings.toggle()
                    }) {
                        Image(systemName: "gear")
                            .font(.system(size: 30))
                            .foregroundColor(.white)
                    }
                    
                    .padding(20)
                    .background(Color.blue)
                    .clipShape(Circle())
                    .shadow(radius: 10)
                    .padding(.trailing, 20)
                    .padding(.bottom, 20)
                    .onChange(of: showSettings) { value in
                        if value==false{
                            renList=KanjiList
                            renList[0].offset=0
                        }
                    }
                    
                }
                
            }
            
            if show{
                DetailJP(kanji: selected, show: $show, name: name)
            }
            
        }
        .background(
            LinearGradient(gradient: .init(colors: [Color.blue,Color.cyan,Color(.lightGray)]  ), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
                .opacity(show ? 0 : 1)
        )
    }
    func restoreLocal(){
        //print("swipe")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            let currentCard = KanjiList[0]
            KanjiList.remove(at: 0)
            KanjiList.append(currentCard)
            for i in 0..<KanjiList.count{
                KanjiList[i].order = i
                if i>0{
                    KanjiList[i].offset=0
                }
            }
            renList = KanjiList

            /*for i in 0..<KanjiList.count{
                print(KanjiList[i].character,KanjiList[i].order)
            }*/
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {

            withAnimation{
                renList[renList.count-1].offset = 0
            }
            
            
        }
    }
    
    func getRotation(offset:CGFloat)->Double{
        let value = offset / 150
        
        let angle: CGFloat = 6
        
        let degree = Double(value * angle)
        
        return degree
    }
    


}
