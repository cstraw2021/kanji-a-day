//
//  DetailJPView.swift
//  Kanji A Day
//
//  Created by Chris on 3/28/23.
//

import Foundation
import SwiftUI

struct DetailJP : View{
    var kanji : Kanji
    @Binding var show : Bool
    var name : Namespace.ID
    var body : some View {
        
        VStack{
            HStack{
                Button(action: {
                    
                    withAnimation(.spring()){
                        show.toggle()
                    }
                }){

                    Image(systemName: "xmark")
                        .font(.system(size: 25))
                        .foregroundColor(.black)
                }
                .padding()
                Spacer()
            }
            
            ScrollView(.vertical,showsIndicators: false){


                HStack{
                    Text("\(kanji.character)")
                        .font(.system(size: 140, weight:.bold))
                        .matchedGeometryEffect(id: kanji.character, in: name)
                        .padding(.trailing,10)
                    

                    
                    VStack(alignment: .leading){
                        
                        Text("On: \(kanji.onyomi)")
                            .font(.system(size: 27))
                            .padding(.bottom,6)
                            
                        Text("Kun: \(kanji.kunyomi)")
                            .font(.system(size: 27))
                    }
                    Spacer()

                    

                }
                .padding(.leading,20)
                .padding(.trailing,20)
                .padding(.top,1)

                    HStack{
                        VStack(alignment: .leading){
                            Text(kanji.meaning)
                                .font(.system(size:36, weight:.bold))
                                .foregroundColor(.black)
                            
                            if(kanji.grade==7){
                                Text("Grades 7+")
                                    .font(.system(size:24))
                                    .foregroundColor(.black)
                            }
                            else{
                                Text("Grade \(kanji.grade)")
                                    .font(.system(size:24))
                                    .foregroundColor(.black)
                            }

                        }
                        
                        Spacer(minLength: 0)
                        
                        .foregroundColor(Color.gray.opacity(0.7))
                    }
                    .padding(.horizontal,20)
            }
            .onAppear {
                UIScrollView.appearance().bounces = false
            }
            .onDisappear {
                UIScrollView.appearance().bounces = true
            }
        }
        .background(Color.white)
    }
}
